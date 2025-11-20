import { put } from "@vercel/blob";

type NodeInputs = {
  articlesJson: string;
  targetLanguage: string;
  spitchApiKey: string;
};

type NodeScriptOptions = {
  logging: Console;
};

type Article = {
  id?: string;
  title?: string;
  content?: string;
  translatedContent?: string;
  audioUrl?: string;
  audioFormat?: string;
  audioSizeBytes?: number;
  audioGenerated?: boolean;
  processed?: boolean;
  [key: string]: unknown;
};

const VOICE_MAP: Record<string, string> = {
  en: "lucy",
  yo: "sade",
  ha: "amina",
  ig: "ngozi",
};

const AUDIO_FORMAT = "mp3";
const MIME_TYPE = AUDIO_FORMAT === "mp3" ? "audio/mpeg" : "audio/wav";
const MAX_TEXT_LENGTH = 5_000;

const slugify = (value: string) => value.replace(/[^a-z0-9_-]+/gi, "-").toLowerCase();

export default async function generateArticleAudio(
  { articlesJson, targetLanguage, spitchApiKey }: NodeInputs,
  { logging }: NodeScriptOptions
) {
  try {
    const parsed = JSON.parse(articlesJson ?? "[]") as unknown;
    if (!Array.isArray(parsed) || parsed.length === 0) {
      throw new Error("articlesJson must contain at least one article");
    }

    const parsedArticles = parsed.map((article) => {
      if (typeof article !== "object" || article === null) {
        throw new Error("Each article must be an object");
      }
      return article as Article;
    });

    const selectedVoice = VOICE_MAP[targetLanguage] ?? VOICE_MAP.en;
    const processedArticles: Article[] = [];

    for (const article of parsedArticles) {
      logging.log(`Generating audio for article: ${article.title ?? article.id}`);

      const textForAudio = (article.translatedContent ?? article.content ?? "").toString();
      const truncatedText =
        textForAudio.length > MAX_TEXT_LENGTH
          ? `${textForAudio.slice(0, MAX_TEXT_LENGTH)}…`
          : textForAudio;

      try {
        const payload = {
          text: truncatedText,
          voice: selectedVoice,
          language: targetLanguage,
          format: AUDIO_FORMAT,
        };

        const audioResponse = await fetch("https://api.spi-tch.com/v1/speech", {
          method: "POST",
          headers: {
            Authorization: `Bearer ${spitchApiKey}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify(payload),
        });

        if (!audioResponse.ok) {
          throw new Error(`Spitch responded with status ${audioResponse.status}`);
        }

        const audioBuffer = Buffer.from(await audioResponse.arrayBuffer());

        let audioUrl = "";
        try {
          const safeId = slugify(article.id ?? article.title ?? "article");
          const objectKey = `audio/${safeId}-${Date.now()}.${AUDIO_FORMAT}`;
          const { url } = await put(objectKey, audioBuffer, {
            access: "public",
            contentType: MIME_TYPE,
          });
          audioUrl = url;
        } catch (uploadError) {
          const uploadMessage =
            uploadError instanceof Error ? uploadError.message : String(uploadError);
          logging.error(`Vercel Blob upload failed for article ${article.id}: ${uploadMessage}`);
          const base64Audio = audioBuffer.toString("base64");
          audioUrl = `data:${MIME_TYPE};base64,${base64Audio}`;
        }

        article.audioUrl = audioUrl;
        article.audioFormat = AUDIO_FORMAT;
        article.audioSizeBytes = audioBuffer.length;
        article.audioGenerated = Boolean(audioUrl);
        article.processed = true;
      } catch (error) {
        logging.error(
          `Audio generation error for article ${article.id}: ${
            error instanceof Error ? error.message : String(error)
          }`
        );
        article.audioUrl = "";
        article.audioGenerated = false;
        article.processed = true;
      }

      processedArticles.push(article);
    }

    return {
      articlesJson: JSON.stringify(processedArticles),
      success: "true",
      totalProcessed: processedArticles.length.toString(),
    };
  } catch (error) {
    logging.error(
      `Audio generation process error: ${error instanceof Error ? error.message : String(error)}`
    );
    return {
      articlesJson,
      success: "false",
      error: error instanceof Error ? error.message : "Unknown error",
      totalProcessed: "0",
    };
  }
}

