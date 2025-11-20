// @ts-nocheck

import { getSecret, scripExecutor, setResult } from "../buildship/utils";
import { httpExecutor } from "../buildship/http";
import { nodes } from "./nodes";

const executeScript = scripExecutor(nodes);
const executeHttp = httpExecutor(nodes);

enum NODES {
    "validateAndPrepareArticles" = "2d3caab7-db7c-4e95-aa15-22a09cb48419",
    "branch" = "2cbfadb8-9b3d-42ab-a136-4cba24a7e3d7",
    "translateArticleContent" = "21a35fd9-4473-4544-8e96-c839223fafe5",
    "passThroughArticles" = "4506f7fb-da9c-4919-bee2-21c5095e6242",
    "mergeTranslationResults" = "7e082daf-6fe9-42f7-ba00-48f929ed9de4",
    "branch1" = "2a4cd031-91a0-40c1-8901-112bb8e3f549",
    "generateArticleAudio" = "1a413c23-58cb-4ca2-9a17-6e06e8812f28",
    "skipAudioGeneration" = "d4366ac1-df4f-4bd5-8f5f-32b29612017b",
    "mergeFinalResults" = "a791c2f1-54cf-4fe5-821f-387ca7684584",
    "buildFinalResponse" = "8ebeb63a-9a88-4500-9bc4-f806c762bd95",
    "output" = "21fe6d32-37aa-4056-8ce1-897a2ec95a2b"
}


async function branch_then(root) {
    const result = {};
    setResult(root, await executeScript(NODES.translateArticleContent, { "spitchApiKey": await getSecret("SPITCH_API_KEY"), "sourceLanguage": root[NODES.validateAndPrepareArticles]["sourceLanguage"], "targetLanguage": root[NODES.validateAndPrepareArticles]["targetLanguage"], "articlesJson": root[NODES.validateAndPrepareArticles]["articlesJson"] }, root, {}), [NODES.branch, "then", NODES.translateArticleContent]);

    return result;
}

async function branch_else(root) {
    const result = {};
    setResult(root, await executeScript(NODES.passThroughArticles, { "articlesJson": root["inputs"]["articlesJson"] }, root, {}), [NODES.branch, "else", NODES.passThroughArticles]);

    return result;
}

async function branch1_then(root) {
    const result = {};
    setResult(root, await executeScript(NODES.generateArticleAudio, { "articlesJson": root[NODES.mergeTranslationResults]["articlesJson"], "targetLanguage": root[NODES.validateAndPrepareArticles]["targetLanguage"], "spitchApiKey": await getSecret("SPITCH_API_KEY") }, root, {}), [NODES.branch1, "then", NODES.generateArticleAudio]);

    return result;
}

async function branch1_else(root) {
    const result = {};
    setResult(root, await executeScript(NODES.skipAudioGeneration, { "articlesJson": root[NODES.mergeTranslationResults]["articlesJson"] }, root, {}), [NODES.branch1, "else", NODES.skipAudioGeneration]);

    return result;
}

export type WorkflowInputs = {
    articlesJson: string;
    targetLanguage: string;
    action?: string;
    articleId?: string;
};

export async function executeWorkflow(inputs: WorkflowInputs) {
    const root: Record<string, any> = { inputs: {} };
    Object.entries(inputs).forEach(([key, value]) => {
        root["inputs"][key] = value;
    });

    setResult(
        root,
        await executeScript(
            NODES.validateAndPrepareArticles,
            {
                targetLanguage: root["inputs"]["targetLanguage"],
                articles: root["inputs"]["articlesJson"],
                articleId: root["inputs"]["articleId"],
                articlesJson: root["inputs"]["articlesJson"],
                action: root["inputs"]["action"],
            },
            root,
            {}
        ),
        [NODES.validateAndPrepareArticles]
    );

    const action = root[NODES.validateAndPrepareArticles]["action"];
    const shouldTranslate = action === "translate_only" || action === "translate_and_audio";

    if (shouldTranslate) {
        await branch_then(root);
    }
    await branch_else(root);

    const translated = root[NODES.branch]?.["then"]?.[NODES.translateArticleContent];
    const passthrough = root[NODES.branch]?.["else"]?.[NODES.passThroughArticles];

    setResult(
        root,
        await executeScript(
            NODES.mergeTranslationResults,
            {
                translatedArticlesJson: translated?.articlesJson ?? "",
                passthroughArticlesJson: passthrough?.articlesJson ?? translated?.articlesJson ?? "",
                translatedSuccess: translated?.success ?? "false",
                passthroughSuccess: passthrough?.success ?? "true",
                translatedTotal: translated?.totalTranslated ?? "0",
                passthroughTotal: passthrough?.totalTranslated ?? translated?.totalTranslated ?? "0",
            },
            root,
            {}
        ),
        [NODES.mergeTranslationResults]
    );

    const shouldGenerateAudio = action === "audio_only" || action === "translate_and_audio";
    if (shouldGenerateAudio) {
        await branch1_then(root);
    }
    await branch1_else(root);

    const audio = root[NODES.branch1]?.["then"]?.[NODES.generateArticleAudio];
    const skipAudio = root[NODES.branch1]?.["else"]?.[NODES.skipAudioGeneration];

    setResult(
        root,
        await executeScript(
            NODES.mergeFinalResults,
            {
                audioArticlesJson: audio?.articlesJson ?? "",
                audioSuccess: audio?.success ?? "false",
                audioTotal: audio?.totalProcessed ?? "0",
                skipAudioArticlesJson: skipAudio?.articlesJson ?? audio?.articlesJson ?? "",
                skipAudioSuccess: skipAudio?.success ?? "true",
                skipAudioTotal: skipAudio?.totalProcessed ?? audio?.totalProcessed ?? "0",
            },
            root,
            {}
        ),
        [NODES.mergeFinalResults]
    );

    setResult(
        root,
        await executeScript(
            NODES.buildFinalResponse,
            {
                finalArticlesJson: root[NODES.mergeFinalResults]["articlesJson"],
                success: root[NODES.mergeFinalResults]["success"],
                originalAction: root[NODES.validateAndPrepareArticles]["action"],
                targetLanguage: root[NODES.validateAndPrepareArticles]["targetLanguage"],
            },
            root,
            {}
        ),
        [NODES.buildFinalResponse]
    );

    return root[NODES.buildFinalResponse];
}

export default executeWorkflow;
