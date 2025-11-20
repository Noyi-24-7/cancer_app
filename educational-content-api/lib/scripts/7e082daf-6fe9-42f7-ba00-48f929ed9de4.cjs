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

// educationalContentProcessor/tmp_scripts_627/7e082daf-6fe9-42f7-ba00-48f929ed9de4_temp.ts
var e082daf_6fe9_42f7_ba00_48f929ed9de4_temp_exports = {};
__export(e082daf_6fe9_42f7_ba00_48f929ed9de4_temp_exports, {
  default: () => mergeTranslationResults
});
module.exports = __toCommonJS(e082daf_6fe9_42f7_ba00_48f929ed9de4_temp_exports);
async function mergeTranslationResults({
  translatedArticlesJson,
  translatedSuccess,
  translatedTotal,
  passthroughArticlesJson,
  passthroughSuccess,
  passthroughTotal
}, {
  logging
}) {
  const isTranslated = translatedArticlesJson && translatedArticlesJson !== "";
  if (isTranslated) {
    return {
      articlesJson: translatedArticlesJson,
      success: translatedSuccess,
      totalProcessed: translatedTotal
    };
  } else {
    return {
      articlesJson: passthroughArticlesJson,
      success: passthroughSuccess,
      totalProcessed: passthroughTotal
    };
  }
}
