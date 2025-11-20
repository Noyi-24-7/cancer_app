var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// educationalContentProcessor/tmp_scripts_627/2d3caab7-db7c-4e95-aa15-22a09cb48419_temp.ts
var d3caab7_db7c_4e95_aa15_22a09cb48419_temp_exports = {};
__export(d3caab7_db7c_4e95_aa15_22a09cb48419_temp_exports, {
  default: () => validateArticleProcessingInput
});
module.exports = __toCommonJS(d3caab7_db7c_4e95_aa15_22a09cb48419_temp_exports);
async function validateArticleProcessingInput({
  articlesJson,
  targetLanguage,
  action,
  articleId
  // <- will be ignored/overwritten
}, { logging }) {
  if (!articlesJson || typeof articlesJson === "string" && articlesJson.trim().length === 0) {
    throw new Error("Articles data is required");
  }
  if (!targetLanguage) {
    throw new Error("Target language is required");
  }
  const validLanguages = ["en", "yo", "ha", "ig"];
  if (!validLanguages.includes(targetLanguage)) {
    throw new Error("Invalid language code. Supported: en, yo, ha, ig");
  }
  const validActions = ["translate_only", "audio_only", "translate_and_audio"];
  const finalAction = action && validActions.includes(action) ? action : "translate_only";
  if (!validActions.includes(finalAction)) {
    throw new Error("Invalid action");
  }
  let parsed;
  try {
    parsed = typeof articlesJson === "string" ? JSON.parse(articlesJson) : articlesJson;
  } catch {
    throw new Error("Invalid articles JSON format");
  }
  const parsedArticles = Array.isArray(parsed) ? parsed : [parsed];
  if (!Array.isArray(parsedArticles) || parsedArticles.length === 0) {
    throw new Error("Articles must be a non-empty array");
  }
  const toUnixSecondsString = (value) => {
    if (value === void 0 || value === null || value === "") {
      return Math.floor(Date.now() / 1e3).toString();
    }
    const s = String(value);
    if (/^\d{9,13}$/.test(s)) {
      return (s.length === 13 ? Math.floor(Number(s) / 1e3) : Number(s)).toString();
    }
    const t = Date.parse(s);
    return isNaN(t) ? Math.floor(Date.now() / 1e3).toString() : Math.floor(t / 1e3).toString();
  };
  const normalized = parsedArticles.map((a, idx) => {
    if (!a || typeof a !== "object") throw new Error(`Article at index ${idx} is not an object`);
    const id = (a.id ?? `auto_${idx}`).toString();
    const title = (a.title ?? "").toString().trim();
    const content = (a.content ?? "").toString().trim();
    if (!title || !content) throw new Error(`Article ${id} is missing required "title" or "content"`);
    return {
      id,
      title,
      content,
      category: (a.category ?? "").toString(),
      imageUrl: (a.imageUrl ?? "").toString(),
      videoId: (a.videoId ?? "").toString(),
      author: (a.author ?? "").toString(),
      readTime: (a.readTime ?? "").toString(),
      lastUpdate: toUnixSecondsString(a.lastUpdate),
      // extended fields
      originalContent: (a.originalContent ?? content).toString(),
      translatedContent: (a.translatedContent ?? "").toString(),
      translatedTitle: (a.translatedTitle ?? "").toString(),
      audioUrl: (a.audioUrl ?? "").toString(),
      targetLanguage: (a.targetLanguage ?? targetLanguage).toString(),
      processed: typeof a.processed === "boolean" ? a.processed : false
    };
  });
  const derivedArticleId = normalized[0]?.id ?? "";
  if (!derivedArticleId) {
    throw new Error("Unable to derive articleId from input articles");
  }
  if (articleId && String(articleId) !== String(derivedArticleId)) {
    logging.log(`Overriding provided articleId "${articleId}" \u2192 "${derivedArticleId}" (from input array).`);
  } else {
    logging.log(`Using articleId "${derivedArticleId}" from input array.`);
  }
  logging.log(`Processing ${normalized.length} articles for ${finalAction} in ${targetLanguage}`);
  return {
    articlesJson: JSON.stringify(normalized),
    targetLanguage,
    action: finalAction,
    sourceLanguage: "en",
    success: "true",
    articleCount: normalized.length.toString(),
    // expose the chosen id so downstream nodes/UI can reference it
    articleId: derivedArticleId
  };
}
