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

// educationalContentProcessor/tmp_scripts_627/8ebeb63a-9a88-4500-9bc4-f806c762bd95_temp.ts
var ebeb63a_9a88_4500_9bc4_f806c762bd95_temp_exports = {};
__export(ebeb63a_9a88_4500_9bc4_f806c762bd95_temp_exports, {
  default: () => buildArticleProcessingResponse
});
module.exports = __toCommonJS(ebeb63a_9a88_4500_9bc4_f806c762bd95_temp_exports);
async function buildArticleProcessingResponse({
  finalArticlesJson,
  success,
  originalAction,
  targetLanguage
}, {
  logging
}) {
  const articles = JSON.parse(finalArticlesJson || "[]");
  logging.log(`Final response: ${articles.length} articles processed`);
  return {
    success: success === "true",
    articles,
    totalProcessed: articles.length,
    action: originalAction,
    targetLanguage,
    timestamp: (/* @__PURE__ */ new Date()).toISOString()
  };
}
