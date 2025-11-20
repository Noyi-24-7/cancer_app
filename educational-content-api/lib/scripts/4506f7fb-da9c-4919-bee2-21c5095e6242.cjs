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

// educationalContentProcessor/tmp_scripts_627/4506f7fb-da9c-4919-bee2-21c5095e6242_temp.ts
var f7fb_da9c_4919_bee2_21c5095e6242_temp_exports = {};
__export(f7fb_da9c_4919_bee2_21c5095e6242_temp_exports, {
  default: () => passThroughArticles
});
module.exports = __toCommonJS(f7fb_da9c_4919_bee2_21c5095e6242_temp_exports);
async function passThroughArticles({
  articlesJson
}) {
  return {
    articlesJson,
    success: "true",
    totalTranslated: "0"
  };
}
