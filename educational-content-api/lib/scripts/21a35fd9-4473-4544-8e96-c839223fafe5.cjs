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

// educationalContentProcessor/tmp_scripts_627/21a35fd9-4473-4544-8e96-c839223fafe5_temp.ts
var a35fd9_4473_4544_8e96_c839223fafe5_temp_exports = {};
__export(a35fd9_4473_4544_8e96_c839223fafe5_temp_exports, {
  default: () => translateArticleContent
});
module.exports = __toCommonJS(a35fd9_4473_4544_8e96_c839223fafe5_temp_exports);
async function translateArticleContent({
  articlesJson,
  sourceLanguage,
  targetLanguage,
  spitchApiKey
}, {
  logging
}) {
  try {
    const articles = JSON.parse(articlesJson);
    const translatedArticles = [];
    for (const article of articles) {
      logging.log(`Translating article: ${article.title}`);
      if (sourceLanguage === targetLanguage) {
        article.translatedContent = article.content;
        article.translatedTitle = article.title;
        translatedArticles.push(article);
        continue;
      }
      try {
        const contentResponse = await fetch("https://api.spi-tch.com/v1/translate", {
          method: "POST",
          headers: {
            "Authorization": `Bearer ${spitchApiKey}`,
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            text: article.content,
            source: sourceLanguage,
            target: targetLanguage
          })
        });
        if (contentResponse.ok) {
          const contentData = await contentResponse.json();
          article.translatedContent = contentData.translated_text || contentData.translation || contentData.text;
          const titleResponse = await fetch("https://api.spi-tch.com/v1/translate", {
            method: "POST",
            headers: {
              "Authorization": `Bearer ${spitchApiKey}`,
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              text: article.title,
              source: sourceLanguage,
              target: targetLanguage
            })
          });
          if (titleResponse.ok) {
            const titleData = await titleResponse.json();
            article.translatedTitle = titleData.translated_text || titleData.translation || titleData.text;
          } else {
            article.translatedTitle = article.title;
          }
        } else {
          logging.error(`Translation failed for article ${article.id}`);
          article.translatedContent = article.content;
          article.translatedTitle = article.title;
        }
      } catch (error) {
        logging.error(`Translation error for article ${article.id}: ${error.message}`);
        article.translatedContent = article.content;
        article.translatedTitle = article.title;
      }
      translatedArticles.push(article);
    }
    logging.log(`Successfully processed ${translatedArticles.length} articles`);
    return {
      articlesJson: JSON.stringify(translatedArticles),
      success: "true",
      totalTranslated: translatedArticles.length.toString()
    };
  } catch (error) {
    logging.error(`Translation process error: ${error.message}`);
    return {
      articlesJson,
      success: "false",
      error: error.message,
      totalTranslated: "0"
    };
  }
}
