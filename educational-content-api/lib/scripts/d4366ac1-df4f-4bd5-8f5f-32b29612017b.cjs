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

// educationalContentProcessor/tmp_scripts_627/d4366ac1-df4f-4bd5-8f5f-32b29612017b_temp.ts
var d4366ac1_df4f_4bd5_8f5f_32b29612017b_temp_exports = {};
__export(d4366ac1_df4f_4bd5_8f5f_32b29612017b_temp_exports, {
  default: () => skipAudioGeneration
});
module.exports = __toCommonJS(d4366ac1_df4f_4bd5_8f5f_32b29612017b_temp_exports);
async function skipAudioGeneration({
  articlesJson
}) {
  return {
    articlesJson,
    success: "true",
    totalProcessed: "0"
  };
}
