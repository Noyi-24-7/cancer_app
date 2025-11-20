import generateArticleAudio from "./custom/generateArticleAudio";
import validateAndPrepareModule from "./2d3caab7-db7c-4e95-aa15-22a09cb48419.cjs";
import translateArticlesModule from "./21a35fd9-4473-4544-8e96-c839223fafe5.cjs";
import passThroughModule from "./4506f7fb-da9c-4919-bee2-21c5095e6242.cjs";
import mergeTranslationModule from "./7e082daf-6fe9-42f7-ba00-48f929ed9de4.cjs";
import skipAudioModule from "./d4366ac1-df4f-4bd5-8f5f-32b29612017b.cjs";
import mergeFinalModule from "./a791c2f1-54cf-4fe5-821f-387ca7684584.cjs";
import buildFinalModule from "./8ebeb63a-9a88-4500-9bc4-f806c762bd95.cjs";

type ScriptArgs = Record<string, unknown>;
type ScriptOptions = Record<string, unknown>;
type ScriptFn = (args: ScriptArgs, options: ScriptOptions) => Promise<unknown>;

const normalize = (module: unknown): ScriptFn => {
  if (typeof module === "function") {
    return module as ScriptFn;
  }

  if (module && typeof module === "object") {
    const defaultExport = (module as { default?: unknown }).default;
    if (typeof defaultExport === "function") {
      return defaultExport as ScriptFn;
    }
    if (defaultExport && typeof defaultExport === "object") {
      const nested = (defaultExport as { default?: unknown }).default;
      if (typeof nested === "function") {
        return nested as ScriptFn;
      }
    }
  }

  throw new Error("Invalid script module");
};

const audioScript = generateArticleAudio as unknown as ScriptFn;

export const scriptMap: Record<string, ScriptFn> = {
  "2d3caab7-db7c-4e95-aa15-22a09cb48419": normalize(validateAndPrepareModule),
  "21a35fd9-4473-4544-8e96-c839223fafe5": normalize(translateArticlesModule),
  "4506f7fb-da9c-4919-bee2-21c5095e6242": normalize(passThroughModule),
  "7e082daf-6fe9-42f7-ba00-48f929ed9de4": normalize(mergeTranslationModule),
  "1a413c23-58cb-4ca2-9a17-6e06e8812f28": audioScript,
  "d4366ac1-df4f-4bd5-8f5f-32b29612017b": normalize(skipAudioModule),
  "a791c2f1-54cf-4fe5-821f-387ca7684584": normalize(mergeFinalModule),
  "8ebeb63a-9a88-4500-9bc4-f806c762bd95": normalize(buildFinalModule),
};

