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

// educationalContentProcessor/tmp_scripts_627/a791c2f1-54cf-4fe5-821f-387ca7684584_temp.ts
var a791c2f1_54cf_4fe5_821f_387ca7684584_temp_exports = {};
__export(a791c2f1_54cf_4fe5_821f_387ca7684584_temp_exports, {
  default: () => mergeFinalResults
});
module.exports = __toCommonJS(a791c2f1_54cf_4fe5_821f_387ca7684584_temp_exports);
async function mergeFinalResults({
  audioArticlesJson,
  audioSuccess,
  audioTotal,
  skipAudioArticlesJson,
  skipAudioSuccess,
  skipAudioTotal
}, {
  logging
}) {
  const hasAudio = audioArticlesJson && audioArticlesJson !== "";
  if (hasAudio) {
    return {
      articlesJson: audioArticlesJson,
      success: audioSuccess,
      totalProcessed: audioTotal
    };
  } else {
    return {
      articlesJson: skipAudioArticlesJson,
      success: skipAudioSuccess,
      totalProcessed: skipAudioTotal
    };
  }
}
