export const nodes = [
  {
    "type": "script",
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
    "inputs": {
      "properties": {
        "articleId": {
          "buildship": {
            "sensitive": false,
            "index": "3",
            "defaultExpressionType": "text"
          },
          "type": "string",
          "title": "Article Id"
        },
        "action": {
          "buildship": {
            "index": "2",
            "sensitive": false,
            "defaultExpressionType": "text"
          },
          "title": "Action",
          "type": "string"
        },
        "articlesJson": {
          "buildship": {
            "sensitive": false,
            "index": "0",
            "defaultExpressionType": "text"
          },
          "title": "Articles Json",
          "type": "string"
        },
        "targetLanguage": {
          "type": "string",
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "1"
          },
          "title": "Target Language"
        }
      },
      "sections": {},
      "required": [],
      "structure": [
        {
          "index": "0",
          "id": "articlesJson",
          "depth": "0",
          "parentId": null
        },
        {
          "id": "targetLanguage",
          "index": "1",
          "parentId": null,
          "depth": "0"
        },
        {
          "depth": "0",
          "index": "2",
          "parentId": null,
          "id": "action"
        },
        {
          "id": "articleId",
          "parentId": null,
          "index": "3",
          "depth": "0"
        }
      ],
      "type": "object"
    },
    "output": {
      "type": "object",
      "buildship": {
        "index": "0"
      },
      "properties": {
        "action": {
          "type": "string",
          "title": "action",
          "buildship": {
            "index": "2"
          }
        },
        "sourceLanguage": {
          "type": "string",
          "buildship": {
            "index": "3"
          },
          "title": "sourceLanguage"
        },
        "articlesJson": {
          "title": "articlesJson",
          "buildship": {
            "index": "0"
          },
          "format": "style",
          "type": "string"
        },
        "articleCount": {
          "type": "string",
          "title": "articleCount",
          "format": "utc-millisec",
          "buildship": {
            "index": "5"
          }
        },
        "success": {
          "title": "success",
          "type": "string",
          "buildship": {
            "index": "4"
          }
        },
        "targetLanguage": {
          "type": "string",
          "buildship": {
            "index": "1"
          },
          "title": "targetLanguage"
        }
      }
    },
    "meta": {
      "id": "2d3caab7-db7c-4e95-aa15-22a09cb48419",
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
      "name": "Starter Script"
    },
    "id": "2d3caab7-db7c-4e95-aa15-22a09cb48419",
    "label": "Validate and Prepare Articles",
    "script": "export default async function validateArticleProcessingInput(\n  {\n    articlesJson,\n    targetLanguage,\n    action,\n    articleId // <- will be ignored/overwritten\n  }: NodeInputs,\n  { logging }: NodeScriptOptions\n) {\n  if (!articlesJson || (typeof articlesJson === 'string' && articlesJson.trim().length === 0)) {\n    throw new Error('Articles data is required');\n  }\n  if (!targetLanguage) {\n    throw new Error('Target language is required');\n  }\n\n  const validLanguages = ['en', 'yo', 'ha', 'ig'] as const;\n  if (!validLanguages.includes(targetLanguage as any)) {\n    throw new Error('Invalid language code. Supported: en, yo, ha, ig');\n  }\n\n  const validActions = ['translate_only', 'audio_only', 'translate_and_audio'] as const;\n  const finalAction = (action && validActions.includes(action as any)) ? action : 'translate_only';\n  if (!validActions.includes(finalAction as any)) {\n    throw new Error('Invalid action');\n  }\n\n  // parse input string/object → array\n  let parsed: any;\n  try {\n    parsed = typeof articlesJson === 'string' ? JSON.parse(articlesJson) : articlesJson;\n  } catch {\n    throw new Error('Invalid articles JSON format');\n  }\n  const parsedArticles: any[] = Array.isArray(parsed) ? parsed : [parsed];\n  if (!Array.isArray(parsedArticles) || parsedArticles.length === 0) {\n    throw new Error('Articles must be a non-empty array');\n  }\n\n  // helper to normalize timestamps to UNIX seconds string\n  const toUnixSecondsString = (value: any): string => {\n    if (value === undefined || value === null || value === '') {\n      return Math.floor(Date.now() / 1000).toString();\n    }\n    const s = String(value);\n    if (/^\\d{9,13}$/.test(s)) {\n      return (s.length === 13 ? Math.floor(Number(s) / 1000) : Number(s)).toString();\n    }\n    const t = Date.parse(s);\n    return isNaN(t) ? Math.floor(Date.now() / 1000).toString() : Math.floor(t / 1000).toString();\n  };\n\n  // normalize all articles (no filtering by input articleId)\n  const normalized = parsedArticles.map((a: any, idx: number) => {\n    if (!a || typeof a !== 'object') throw new Error(`Article at index ${idx} is not an object`);\n    const id = (a.id ?? `auto_${idx}`).toString();\n    const title = (a.title ?? '').toString().trim();\n    const content = (a.content ?? '').toString().trim();\n    if (!title || !content) throw new Error(`Article ${id} is missing required \"title\" or \"content\"`);\n\n    return {\n      id,\n      title,\n      content,\n      category: (a.category ?? '').toString(),\n      imageUrl: (a.imageUrl ?? '').toString(),\n      videoId: (a.videoId ?? '').toString(),\n      author: (a.author ?? '').toString(),\n      readTime: (a.readTime ?? '').toString(),\n      lastUpdate: toUnixSecondsString(a.lastUpdate),\n\n      // extended fields\n      originalContent: (a.originalContent ?? content).toString(),\n      translatedContent: (a.translatedContent ?? '').toString(),\n      translatedTitle: (a.translatedTitle ?? '').toString(),\n      audioUrl: (a.audioUrl ?? '').toString(),\n      targetLanguage: (a.targetLanguage ?? targetLanguage).toString(),\n      processed: typeof a.processed === 'boolean' ? a.processed : false\n    };\n  });\n\n  // === NEW: derive/overwrite articleId from array ===\n  const derivedArticleId = normalized[0]?.id ?? '';\n  if (!derivedArticleId) {\n    throw new Error('Unable to derive articleId from input articles');\n  }\n  if (articleId && String(articleId) !== String(derivedArticleId)) {\n    logging.log(`Overriding provided articleId \"${articleId}\" → \"${derivedArticleId}\" (from input array).`);\n  } else {\n    logging.log(`Using articleId \"${derivedArticleId}\" from input array.`);\n  }\n\n  logging.log(`Processing ${normalized.length} articles for ${finalAction} in ${targetLanguage}`);\n\n  return {\n    articlesJson: JSON.stringify(normalized),\n    targetLanguage,\n    action: finalAction,\n    sourceLanguage: 'en',\n    success: 'true',\n    articleCount: normalized.length.toString(),\n    // expose the chosen id so downstream nodes/UI can reference it\n    articleId: derivedArticleId\n  };\n}\n"
  },
  {
    "type": "branch",
    "id": "2cbfadb8-9b3d-42ab-a136-4cba24a7e3d7",
    "else": [
      {
        "output": {
          "buildship": {
            "index": "0"
          },
          "type": "object",
          "properties": {
            "articlesJson": {
              "title": "articlesJson",
              "buildship": {
                "index": "0"
              },
              "type": "string",
              "format": "style"
            },
            "totalTranslated": {
              "format": "utc-millisec",
              "buildship": {
                "index": "2"
              },
              "title": "totalTranslated",
              "type": "string"
            },
            "success": {
              "buildship": {
                "index": "1"
              },
              "title": "success",
              "type": "string"
            }
          }
        },
        "meta": {
          "id": "4506f7fb-da9c-4919-bee2-21c5095e6242",
          "name": "Starter Script",
          "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)"
        },
        "label": "Pass Through Articles",
        "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
        "type": "script",
        "inputs": {
          "properties": {
            "articlesJson": {
              "title": "Articles Json",
              "type": "string",
              "buildship": {
                "defaultExpressionType": "text",
                "sensitive": false,
                "index": "0"
              }
            }
          },
          "structure": [
            {
              "index": "0",
              "depth": "0",
              "id": "articlesJson",
              "parentId": null
            }
          ],
          "type": "object",
          "sections": {},
          "required": []
        },
        "id": "4506f7fb-da9c-4919-bee2-21c5095e6242",
        "script": "export default async function passThroughArticles({\n    articlesJson\n}: NodeInputs) {\n    return {\n        articlesJson: articlesJson,\n        success: 'true',\n        totalTranslated: '0'\n    };\n}"
      }
    ],
    "then": [
      {
        "script": "export default async function translateArticleContent({\n    articlesJson,\n    sourceLanguage,\n    targetLanguage,\n    spitchApiKey\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    try {\n        const articles = JSON.parse(articlesJson);\n        const translatedArticles = [];\n        \n        for (const article of articles) {\n            logging.log(`Translating article: ${article.title}`);\n            \n            if (sourceLanguage === targetLanguage) {\n                article.translatedContent = article.content;\n                article.translatedTitle = article.title;\n                translatedArticles.push(article);\n                continue;\n            }\n            \n            try {\n                // Translate content\n                const contentResponse = await fetch('https://api.spi-tch.com/v1/translate', {\n                    method: 'POST',\n                    headers: {\n                        'Authorization': `Bearer ${spitchApiKey}`,\n                        'Content-Type': 'application/json'\n                    },\n                    body: JSON.stringify({\n                        text: article.content,\n                        source: sourceLanguage,\n                        target: targetLanguage\n                    })\n                });\n                \n                if (contentResponse.ok) {\n                    const contentData = await contentResponse.json();\n                    article.translatedContent = contentData.translated_text || contentData.translation || contentData.text;\n                    \n                    // Translate title\n                    const titleResponse = await fetch('https://api.spi-tch.com/v1/translate', {\n                        method: 'POST',\n                        headers: {\n                            'Authorization': `Bearer ${spitchApiKey}`,\n                            'Content-Type': 'application/json'\n                        },\n                        body: JSON.stringify({\n                            text: article.title,\n                            source: sourceLanguage,\n                            target: targetLanguage\n                        })\n                    });\n                    \n                    if (titleResponse.ok) {\n                        const titleData = await titleResponse.json();\n                        article.translatedTitle = titleData.translated_text || titleData.translation || titleData.text;\n                    } else {\n                        article.translatedTitle = article.title;\n                    }\n                } else {\n                    logging.error(`Translation failed for article ${article.id}`);\n                    article.translatedContent = article.content;\n                    article.translatedTitle = article.title;\n                }\n                \n            } catch (error) {\n                logging.error(`Translation error for article ${article.id}: ${error.message}`);\n                article.translatedContent = article.content;\n                article.translatedTitle = article.title;\n            }\n            \n            translatedArticles.push(article);\n        }\n        \n        logging.log(`Successfully processed ${translatedArticles.length} articles`);\n        \n        return {\n            articlesJson: JSON.stringify(translatedArticles),\n            success: 'true',\n            totalTranslated: translatedArticles.length.toString()\n        };\n        \n    } catch (error) {\n        logging.error(`Translation process error: ${error.message}`);\n        return {\n            articlesJson: articlesJson,\n            success: 'false',\n            error: error.message,\n            totalTranslated: '0'\n        };\n    }\n}",
        "label": "Translate Article Content",
        "inputs": {
          "type": "object",
          "properties": {
            "articlesJson": {
              "title": "Articles Json",
              "buildship": {
                "index": "0",
                "sensitive": false,
                "defaultExpressionType": "text"
              },
              "type": "string"
            },
            "targetLanguage": {
              "title": "Target Language",
              "type": "string",
              "buildship": {
                "index": "2",
                "defaultExpressionType": "text",
                "sensitive": false
              }
            },
            "sourceLanguage": {
              "buildship": {
                "index": "1",
                "defaultExpressionType": "text",
                "sensitive": false
              },
              "type": "string",
              "title": "Source Language"
            },
            "spitchApiKey": {
              "type": "string",
              "title": "Authorization",
              "buildship": {
                "defaultExpressionType": "text",
                "sensitive": false,
                "index": "3"
              }
            }
          },
          "required": [],
          "structure": [
            {
              "index": "0",
              "id": "articlesJson",
              "parentId": null,
              "depth": "0"
            },
            {
              "index": "1",
              "depth": "0",
              "parentId": null,
              "id": "sourceLanguage"
            },
            {
              "id": "targetLanguage",
              "parentId": null,
              "depth": "0",
              "index": "2"
            },
            {
              "id": "spitchApiKey",
              "index": "3",
              "depth": "0",
              "parentId": null
            }
          ],
          "sections": {}
        },
        "output": {
          "type": "object",
          "buildship": {
            "index": "0"
          },
          "properties": {
            "totalTranslated": {
              "buildship": {
                "index": "2"
              },
              "title": "totalTranslated",
              "type": "string",
              "format": "utc-millisec"
            },
            "success": {
              "title": "success",
              "buildship": {
                "index": "1"
              },
              "type": "string"
            },
            "articlesJson": {
              "title": "articlesJson",
              "type": "string",
              "format": "style",
              "buildship": {
                "index": "0"
              }
            }
          }
        },
        "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
        "id": "21a35fd9-4473-4544-8e96-c839223fafe5",
        "meta": {
          "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
          "id": "21a35fd9-4473-4544-8e96-c839223fafe5",
          "name": "Starter Script"
        },
        "type": "script"
      }
    ],
    "label": "Branch",
    "description": "Execute different sets of actions based on a specific condition. \n\nLearn more about the Branch node: [Docs](https://docs.buildship.com/core-nodes/if-else)",
    "condition": true
  },
  {
    "script": "export default async function translateArticleContent({\n    articlesJson,\n    sourceLanguage,\n    targetLanguage,\n    spitchApiKey\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    try {\n        const articles = JSON.parse(articlesJson);\n        const translatedArticles = [];\n        \n        for (const article of articles) {\n            logging.log(`Translating article: ${article.title}`);\n            \n            if (sourceLanguage === targetLanguage) {\n                article.translatedContent = article.content;\n                article.translatedTitle = article.title;\n                translatedArticles.push(article);\n                continue;\n            }\n            \n            try {\n                // Translate content\n                const contentResponse = await fetch('https://api.spi-tch.com/v1/translate', {\n                    method: 'POST',\n                    headers: {\n                        'Authorization': `Bearer ${spitchApiKey}`,\n                        'Content-Type': 'application/json'\n                    },\n                    body: JSON.stringify({\n                        text: article.content,\n                        source: sourceLanguage,\n                        target: targetLanguage\n                    })\n                });\n                \n                if (contentResponse.ok) {\n                    const contentData = await contentResponse.json();\n                    article.translatedContent = contentData.translated_text || contentData.translation || contentData.text;\n                    \n                    // Translate title\n                    const titleResponse = await fetch('https://api.spi-tch.com/v1/translate', {\n                        method: 'POST',\n                        headers: {\n                            'Authorization': `Bearer ${spitchApiKey}`,\n                            'Content-Type': 'application/json'\n                        },\n                        body: JSON.stringify({\n                            text: article.title,\n                            source: sourceLanguage,\n                            target: targetLanguage\n                        })\n                    });\n                    \n                    if (titleResponse.ok) {\n                        const titleData = await titleResponse.json();\n                        article.translatedTitle = titleData.translated_text || titleData.translation || titleData.text;\n                    } else {\n                        article.translatedTitle = article.title;\n                    }\n                } else {\n                    logging.error(`Translation failed for article ${article.id}`);\n                    article.translatedContent = article.content;\n                    article.translatedTitle = article.title;\n                }\n                \n            } catch (error) {\n                logging.error(`Translation error for article ${article.id}: ${error.message}`);\n                article.translatedContent = article.content;\n                article.translatedTitle = article.title;\n            }\n            \n            translatedArticles.push(article);\n        }\n        \n        logging.log(`Successfully processed ${translatedArticles.length} articles`);\n        \n        return {\n            articlesJson: JSON.stringify(translatedArticles),\n            success: 'true',\n            totalTranslated: translatedArticles.length.toString()\n        };\n        \n    } catch (error) {\n        logging.error(`Translation process error: ${error.message}`);\n        return {\n            articlesJson: articlesJson,\n            success: 'false',\n            error: error.message,\n            totalTranslated: '0'\n        };\n    }\n}",
    "label": "Translate Article Content",
    "inputs": {
      "type": "object",
      "properties": {
        "articlesJson": {
          "title": "Articles Json",
          "buildship": {
            "index": "0",
            "sensitive": false,
            "defaultExpressionType": "text"
          },
          "type": "string"
        },
        "targetLanguage": {
          "title": "Target Language",
          "type": "string",
          "buildship": {
            "index": "2",
            "defaultExpressionType": "text",
            "sensitive": false
          }
        },
        "sourceLanguage": {
          "buildship": {
            "index": "1",
            "defaultExpressionType": "text",
            "sensitive": false
          },
          "type": "string",
          "title": "Source Language"
        },
        "spitchApiKey": {
          "type": "string",
          "title": "Authorization",
          "buildship": {
            "defaultExpressionType": "text",
            "sensitive": false,
            "index": "3"
          }
        }
      },
      "required": [],
      "structure": [
        {
          "index": "0",
          "id": "articlesJson",
          "parentId": null,
          "depth": "0"
        },
        {
          "index": "1",
          "depth": "0",
          "parentId": null,
          "id": "sourceLanguage"
        },
        {
          "id": "targetLanguage",
          "parentId": null,
          "depth": "0",
          "index": "2"
        },
        {
          "id": "spitchApiKey",
          "index": "3",
          "depth": "0",
          "parentId": null
        }
      ],
      "sections": {}
    },
    "output": {
      "type": "object",
      "buildship": {
        "index": "0"
      },
      "properties": {
        "totalTranslated": {
          "buildship": {
            "index": "2"
          },
          "title": "totalTranslated",
          "type": "string",
          "format": "utc-millisec"
        },
        "success": {
          "title": "success",
          "buildship": {
            "index": "1"
          },
          "type": "string"
        },
        "articlesJson": {
          "title": "articlesJson",
          "type": "string",
          "format": "style",
          "buildship": {
            "index": "0"
          }
        }
      }
    },
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
    "id": "21a35fd9-4473-4544-8e96-c839223fafe5",
    "meta": {
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
      "id": "21a35fd9-4473-4544-8e96-c839223fafe5",
      "name": "Starter Script"
    },
    "type": "script"
  },
  {
    "output": {
      "buildship": {
        "index": "0"
      },
      "type": "object",
      "properties": {
        "articlesJson": {
          "title": "articlesJson",
          "buildship": {
            "index": "0"
          },
          "type": "string",
          "format": "style"
        },
        "totalTranslated": {
          "format": "utc-millisec",
          "buildship": {
            "index": "2"
          },
          "title": "totalTranslated",
          "type": "string"
        },
        "success": {
          "buildship": {
            "index": "1"
          },
          "title": "success",
          "type": "string"
        }
      }
    },
    "meta": {
      "id": "4506f7fb-da9c-4919-bee2-21c5095e6242",
      "name": "Starter Script",
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)"
    },
    "label": "Pass Through Articles",
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
    "type": "script",
    "inputs": {
      "properties": {
        "articlesJson": {
          "title": "Articles Json",
          "type": "string",
          "buildship": {
            "defaultExpressionType": "text",
            "sensitive": false,
            "index": "0"
          }
        }
      },
      "structure": [
        {
          "index": "0",
          "depth": "0",
          "id": "articlesJson",
          "parentId": null
        }
      ],
      "type": "object",
      "sections": {},
      "required": []
    },
    "id": "4506f7fb-da9c-4919-bee2-21c5095e6242",
    "script": "export default async function passThroughArticles({\n    articlesJson\n}: NodeInputs) {\n    return {\n        articlesJson: articlesJson,\n        success: 'true',\n        totalTranslated: '0'\n    };\n}"
  },
  {
    "id": "7e082daf-6fe9-42f7-ba00-48f929ed9de4",
    "script": "export default async function mergeTranslationResults({\n    translatedArticlesJson,\n    translatedSuccess,\n    translatedTotal,\n    passthroughArticlesJson,\n    passthroughSuccess,\n    passthroughTotal\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    \n    const isTranslated = translatedArticlesJson && translatedArticlesJson !== '';\n    \n    if (isTranslated) {\n        return {\n            articlesJson: translatedArticlesJson,\n            success: translatedSuccess,\n            totalProcessed: translatedTotal\n        };\n    } else {\n        return {\n            articlesJson: passthroughArticlesJson,\n            success: passthroughSuccess,\n            totalProcessed: passthroughTotal\n        };\n    }\n}",
    "output": {
      "properties": {
        "success": {
          "title": "success",
          "type": "string",
          "buildship": {
            "index": "1"
          }
        },
        "totalProcessed": {
          "title": "totalProcessed",
          "format": "utc-millisec",
          "type": "string",
          "buildship": {
            "index": "2"
          }
        },
        "articlesJson": {
          "buildship": {
            "index": "0"
          },
          "type": "string",
          "format": "style",
          "title": "articlesJson"
        }
      },
      "buildship": {
        "index": "0"
      },
      "type": "object"
    },
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
    "label": "Merge Translation Results",
    "meta": {
      "id": "7e082daf-6fe9-42f7-ba00-48f929ed9de4",
      "name": "Starter Script",
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)"
    },
    "type": "script",
    "inputs": {
      "sections": {},
      "type": "object",
      "required": [],
      "properties": {
        "passthroughTotal": {
          "title": "Passthrough Total",
          "type": "string",
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "5"
          }
        },
        "passthroughArticlesJson": {
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "3"
          },
          "title": "Passthrough Articles Json",
          "type": "string"
        },
        "translatedTotal": {
          "type": "string",
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "2"
          },
          "title": "Translated Total"
        },
        "translatedSuccess": {
          "title": "Translated Success",
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "1"
          },
          "type": "string"
        },
        "passthroughSuccess": {
          "title": "Passthrough Success",
          "type": "string",
          "buildship": {
            "defaultExpressionType": "text",
            "sensitive": false,
            "index": "4"
          }
        },
        "translatedArticlesJson": {
          "title": "Translated Articles Json",
          "buildship": {
            "defaultExpressionType": "text",
            "index": "0",
            "sensitive": false
          },
          "type": "string"
        }
      },
      "structure": [
        {
          "parentId": null,
          "depth": "0",
          "index": "0",
          "id": "translatedArticlesJson"
        },
        {
          "parentId": null,
          "index": "1",
          "id": "translatedSuccess",
          "depth": "0"
        },
        {
          "depth": "0",
          "id": "translatedTotal",
          "parentId": null,
          "index": "2"
        },
        {
          "parentId": null,
          "index": "3",
          "id": "passthroughArticlesJson",
          "depth": "0"
        },
        {
          "index": "4",
          "parentId": null,
          "depth": "0",
          "id": "passthroughSuccess"
        },
        {
          "parentId": null,
          "index": "5",
          "depth": "0",
          "id": "passthroughTotal"
        }
      ]
    }
  },
  {
    "then": [
      {
        "id": "1a413c23-58cb-4ca2-9a17-6e06e8812f28",
        "label": "Generate Article Audio",
        "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
        "inputs": {
          "required": [],
          "properties": {
            "articlesJson": {
              "title": "Articles Json",
              "type": "string",
              "buildship": {
                "sensitive": false,
                "index": "0",
                "defaultExpressionType": "text"
              }
            },
            "targetLanguage": {
              "title": "Target Language",
              "buildship": {
                "sensitive": false,
                "defaultExpressionType": "text",
                "index": "1"
              },
              "type": "string"
            },
            "spitchApiKey": {
              "type": "string",
              "title": "Authorization",
              "buildship": {
                "defaultExpressionType": "text",
                "index": "2",
                "sensitive": false
              }
            }
          },
          "structure": [
            {
              "id": "articlesJson",
              "parentId": null,
              "index": "0",
              "depth": "0"
            },
            {
              "index": "1",
              "id": "targetLanguage",
              "depth": "0",
              "parentId": null
            },
            {
              "id": "spitchApiKey",
              "depth": "0",
              "parentId": null,
              "index": "2"
            }
          ],
          "type": "object",
          "sections": {}
        },
        "output": {
          "buildship": {
            "index": "0"
          },
          "type": "object",
          "properties": {
            "articlesJson": {
              "buildship": {
                "index": "0"
              },
              "format": "style",
              "title": "articlesJson",
              "type": "string"
            },
            "success": {
              "title": "success",
              "buildship": {
                "index": "1"
              },
              "type": "string"
            },
            "totalProcessed": {
              "format": "utc-millisec",
              "title": "totalProcessed",
              "buildship": {
                "index": "2"
              },
              "type": "string"
            }
          }
        },
        "meta": {
          "id": "1a413c23-58cb-4ca2-9a17-6e06e8812f28",
          "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
          "name": "Starter Script"
        },
        "type": "script",
        "script": "import { Storage } from '@google-cloud/storage';\n\nexport default async function generateArticleAudio(\n  {\n    articlesJson,\n    targetLanguage,\n    spitchApiKey\n  }: NodeInputs,\n  { logging }: NodeScriptOptions\n) {\n  // --- helpers ---\n  const slug = (s: string) => String(s || 'article').replace(/[^a-z0-9_-]+/gi, '').toLowerCase();\n\n  // Choose an audio format. If Spitch supports MP3, keep 'mp3' (smaller files).\n  // If not, change ext/mime back to wav.\n  const audioFormat = 'mp3'; // 'wav' if needed\n  const mime = audioFormat === 'mp3' ? 'audio/mpeg' : 'audio/wav';\n\n  // Set up GCS client once\n  const bucketName = process.env.BUCKET;\n  const storage = new Storage();\n\n  try {\n    const articles = JSON.parse(articlesJson);\n    const processedArticles: any[] = [];\n\n    const voiceMap: Record<string, string> = {\n      en: 'lucy',\n      yo: 'sade',\n      ha: 'amina',\n      ig: 'ngozi'\n    };\n    const selectedVoice = voiceMap[targetLanguage] || 'lucy';\n\n    if (!bucketName) {\n      logging.warn('BUCKET env var not set; will fall back to base64 data URLs.');\n    }\n\n    for (const article of articles) {\n      logging.log(`Generating audio for article: ${article.title}`);\n\n      // Use translated content if available, otherwise original\n      const textForAudio = article.translatedContent || article.content || '';\n      const maxLength = 5000;\n      const truncatedText =\n        textForAudio.length > maxLength ? textForAudio.substring(0, maxLength) + '...' : textForAudio;\n\n      try {\n        const payload: any = {\n          text: truncatedText,\n          voice: selectedVoice,\n          language: targetLanguage,\n          // If Spitch supports explicit format, keep this line:\n          // format: audioFormat\n        };\n\n        const audioResponse = await fetch('https://api.spi-tch.com/v1/speech', {\n          method: 'POST',\n          headers: {\n            Authorization: `Bearer ${spitchApiKey}`,\n            'Content-Type': 'application/json'\n          },\n          body: JSON.stringify(payload)\n        });\n\n        if (!audioResponse.ok) {\n          logging.error(`Audio generation failed for article ${article.id} (HTTP ${audioResponse.status}).`);\n          article.audioUrl = '';\n          article.audioGenerated = false;\n          article.processed = true;\n          processedArticles.push(article);\n          continue;\n        }\n\n        const audioBuffer = Buffer.from(await audioResponse.arrayBuffer());\n\n        // Try to upload to GCS (short public link)\n        if (bucketName) {\n          try {\n            const safeId = slug(article.id ?? article.title ?? 'article');\n            const key = `audio/${safeId}-${Date.now()}.${audioFormat}`;\n            const bucket = storage.bucket(bucketName);\n            const file = bucket.file(key);\n\n            await file.save(audioBuffer, {\n              resumable: true,\n              contentType: mime,\n              public: true,\n              timeout: 300000\n            });\n\n            const publicUrl = `https://storage.googleapis.com/${bucket.name}/${file.name}`;\n            logging.log(`Upload successful: ${publicUrl}`);\n\n            article.audioUrl = publicUrl;            // ✅ short link\n            article.audioKey = key;\n            article.audioFormat = audioFormat;\n            article.audioSizeBytes = audioBuffer.length;\n            article.audioGenerated = true;\n          } catch (uploadErr: any) {\n            logging.error(`GCS upload failed for ${article.id}: ${uploadErr?.message || uploadErr}`);\n            // Fallback to base64 data URL\n            const base64Audio = audioBuffer.toString('base64');\n            article.audioUrl = `data:${mime};base64,${base64Audio}`;\n            article.audioGenerated = true;\n          }\n        } else {\n          // No BUCKET set: fallback to base64 data URL\n          const base64Audio = audioBuffer.toString('base64');\n          article.audioUrl = `data:${mime};base64,${base64Audio}`;\n          article.audioGenerated = true;\n        }\n      } catch (error: any) {\n        logging.error(`Audio error for article ${article.id}: ${error?.message || error}`);\n        article.audioUrl = '';\n        article.audioGenerated = false;\n      }\n\n      article.processed = true;\n      processedArticles.push(article);\n    }\n\n    logging.log(`Successfully processed audio for ${processedArticles.length} articles`);\n\n    return {\n      articlesJson: JSON.stringify(processedArticles),\n      success: 'true',\n      totalProcessed: processedArticles.length.toString()\n    };\n  } catch (error: any) {\n    logging.error(`Audio generation process error: ${error?.message || error}`);\n    return {\n      articlesJson: articlesJson,\n      success: 'false',\n      error: error.message,\n      totalProcessed: '0'\n    };\n  }\n}\n"
      }
    ],
    "id": "2a4cd031-91a0-40c1-8901-112bb8e3f549",
    "type": "branch",
    "label": "Branch",
    "else": [
      {
        "label": "Skip Audio Generation",
        "id": "d4366ac1-df4f-4bd5-8f5f-32b29612017b",
        "type": "script",
        "inputs": {
          "sections": {},
          "type": "object",
          "properties": {
            "articlesJson": {
              "title": "Articles Json",
              "type": "string",
              "buildship": {
                "sensitive": false,
                "index": "0",
                "defaultExpressionType": "text"
              }
            }
          },
          "required": [],
          "structure": [
            {
              "depth": "0",
              "parentId": null,
              "index": "0",
              "id": "articlesJson"
            }
          ]
        },
        "script": "export default async function skipAudioGeneration({\n    articlesJson\n}: NodeInputs) {\n    return {\n        articlesJson: articlesJson,\n        success: 'true',\n        totalProcessed: '0'\n    };\n}",
        "meta": {
          "id": "d4366ac1-df4f-4bd5-8f5f-32b29612017b",
          "name": "Starter Script",
          "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)"
        },
        "output": {
          "properties": {
            "success": {
              "title": "success",
              "buildship": {
                "index": "1"
              },
              "type": "string"
            },
            "articlesJson": {
              "title": "articlesJson",
              "buildship": {
                "index": "0"
              },
              "type": "string",
              "format": "style"
            },
            "totalProcessed": {
              "buildship": {
                "index": "2"
              },
              "title": "totalProcessed",
              "format": "utc-millisec",
              "type": "string"
            }
          },
          "buildship": {
            "index": "0"
          },
          "type": "object"
        },
        "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)"
      }
    ],
    "description": "Execute different sets of actions based on a specific condition. \n\nLearn more about the Branch node: [Docs](https://docs.buildship.com/core-nodes/if-else)",
    "condition": true
  },
  {
    "id": "1a413c23-58cb-4ca2-9a17-6e06e8812f28",
    "label": "Generate Article Audio",
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
    "inputs": {
      "required": [],
      "properties": {
        "articlesJson": {
          "title": "Articles Json",
          "type": "string",
          "buildship": {
            "sensitive": false,
            "index": "0",
            "defaultExpressionType": "text"
          }
        },
        "targetLanguage": {
          "title": "Target Language",
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "1"
          },
          "type": "string"
        },
        "spitchApiKey": {
          "type": "string",
          "title": "Authorization",
          "buildship": {
            "defaultExpressionType": "text",
            "index": "2",
            "sensitive": false
          }
        }
      },
      "structure": [
        {
          "id": "articlesJson",
          "parentId": null,
          "index": "0",
          "depth": "0"
        },
        {
          "index": "1",
          "id": "targetLanguage",
          "depth": "0",
          "parentId": null
        },
        {
          "id": "spitchApiKey",
          "depth": "0",
          "parentId": null,
          "index": "2"
        }
      ],
      "type": "object",
      "sections": {}
    },
    "output": {
      "buildship": {
        "index": "0"
      },
      "type": "object",
      "properties": {
        "articlesJson": {
          "buildship": {
            "index": "0"
          },
          "format": "style",
          "title": "articlesJson",
          "type": "string"
        },
        "success": {
          "title": "success",
          "buildship": {
            "index": "1"
          },
          "type": "string"
        },
        "totalProcessed": {
          "format": "utc-millisec",
          "title": "totalProcessed",
          "buildship": {
            "index": "2"
          },
          "type": "string"
        }
      }
    },
    "meta": {
      "id": "1a413c23-58cb-4ca2-9a17-6e06e8812f28",
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
      "name": "Starter Script"
    },
    "type": "script",
    "script": "import { Storage } from '@google-cloud/storage';\n\nexport default async function generateArticleAudio(\n  {\n    articlesJson,\n    targetLanguage,\n    spitchApiKey\n  }: NodeInputs,\n  { logging }: NodeScriptOptions\n) {\n  // --- helpers ---\n  const slug = (s: string) => String(s || 'article').replace(/[^a-z0-9_-]+/gi, '').toLowerCase();\n\n  // Choose an audio format. If Spitch supports MP3, keep 'mp3' (smaller files).\n  // If not, change ext/mime back to wav.\n  const audioFormat = 'mp3'; // 'wav' if needed\n  const mime = audioFormat === 'mp3' ? 'audio/mpeg' : 'audio/wav';\n\n  // Set up GCS client once\n  const bucketName = process.env.BUCKET;\n  const storage = new Storage();\n\n  try {\n    const articles = JSON.parse(articlesJson);\n    const processedArticles: any[] = [];\n\n    const voiceMap: Record<string, string> = {\n      en: 'lucy',\n      yo: 'sade',\n      ha: 'amina',\n      ig: 'ngozi'\n    };\n    const selectedVoice = voiceMap[targetLanguage] || 'lucy';\n\n    if (!bucketName) {\n      logging.warn('BUCKET env var not set; will fall back to base64 data URLs.');\n    }\n\n    for (const article of articles) {\n      logging.log(`Generating audio for article: ${article.title}`);\n\n      // Use translated content if available, otherwise original\n      const textForAudio = article.translatedContent || article.content || '';\n      const maxLength = 5000;\n      const truncatedText =\n        textForAudio.length > maxLength ? textForAudio.substring(0, maxLength) + '...' : textForAudio;\n\n      try {\n        const payload: any = {\n          text: truncatedText,\n          voice: selectedVoice,\n          language: targetLanguage,\n          // If Spitch supports explicit format, keep this line:\n          // format: audioFormat\n        };\n\n        const audioResponse = await fetch('https://api.spi-tch.com/v1/speech', {\n          method: 'POST',\n          headers: {\n            Authorization: `Bearer ${spitchApiKey}`,\n            'Content-Type': 'application/json'\n          },\n          body: JSON.stringify(payload)\n        });\n\n        if (!audioResponse.ok) {\n          logging.error(`Audio generation failed for article ${article.id} (HTTP ${audioResponse.status}).`);\n          article.audioUrl = '';\n          article.audioGenerated = false;\n          article.processed = true;\n          processedArticles.push(article);\n          continue;\n        }\n\n        const audioBuffer = Buffer.from(await audioResponse.arrayBuffer());\n\n        // Try to upload to GCS (short public link)\n        if (bucketName) {\n          try {\n            const safeId = slug(article.id ?? article.title ?? 'article');\n            const key = `audio/${safeId}-${Date.now()}.${audioFormat}`;\n            const bucket = storage.bucket(bucketName);\n            const file = bucket.file(key);\n\n            await file.save(audioBuffer, {\n              resumable: true,\n              contentType: mime,\n              public: true,\n              timeout: 300000\n            });\n\n            const publicUrl = `https://storage.googleapis.com/${bucket.name}/${file.name}`;\n            logging.log(`Upload successful: ${publicUrl}`);\n\n            article.audioUrl = publicUrl;            // ✅ short link\n            article.audioKey = key;\n            article.audioFormat = audioFormat;\n            article.audioSizeBytes = audioBuffer.length;\n            article.audioGenerated = true;\n          } catch (uploadErr: any) {\n            logging.error(`GCS upload failed for ${article.id}: ${uploadErr?.message || uploadErr}`);\n            // Fallback to base64 data URL\n            const base64Audio = audioBuffer.toString('base64');\n            article.audioUrl = `data:${mime};base64,${base64Audio}`;\n            article.audioGenerated = true;\n          }\n        } else {\n          // No BUCKET set: fallback to base64 data URL\n          const base64Audio = audioBuffer.toString('base64');\n          article.audioUrl = `data:${mime};base64,${base64Audio}`;\n          article.audioGenerated = true;\n        }\n      } catch (error: any) {\n        logging.error(`Audio error for article ${article.id}: ${error?.message || error}`);\n        article.audioUrl = '';\n        article.audioGenerated = false;\n      }\n\n      article.processed = true;\n      processedArticles.push(article);\n    }\n\n    logging.log(`Successfully processed audio for ${processedArticles.length} articles`);\n\n    return {\n      articlesJson: JSON.stringify(processedArticles),\n      success: 'true',\n      totalProcessed: processedArticles.length.toString()\n    };\n  } catch (error: any) {\n    logging.error(`Audio generation process error: ${error?.message || error}`);\n    return {\n      articlesJson: articlesJson,\n      success: 'false',\n      error: error.message,\n      totalProcessed: '0'\n    };\n  }\n}\n"
  },
  {
    "label": "Skip Audio Generation",
    "id": "d4366ac1-df4f-4bd5-8f5f-32b29612017b",
    "type": "script",
    "inputs": {
      "sections": {},
      "type": "object",
      "properties": {
        "articlesJson": {
          "title": "Articles Json",
          "type": "string",
          "buildship": {
            "sensitive": false,
            "index": "0",
            "defaultExpressionType": "text"
          }
        }
      },
      "required": [],
      "structure": [
        {
          "depth": "0",
          "parentId": null,
          "index": "0",
          "id": "articlesJson"
        }
      ]
    },
    "script": "export default async function skipAudioGeneration({\n    articlesJson\n}: NodeInputs) {\n    return {\n        articlesJson: articlesJson,\n        success: 'true',\n        totalProcessed: '0'\n    };\n}",
    "meta": {
      "id": "d4366ac1-df4f-4bd5-8f5f-32b29612017b",
      "name": "Starter Script",
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)"
    },
    "output": {
      "properties": {
        "success": {
          "title": "success",
          "buildship": {
            "index": "1"
          },
          "type": "string"
        },
        "articlesJson": {
          "title": "articlesJson",
          "buildship": {
            "index": "0"
          },
          "type": "string",
          "format": "style"
        },
        "totalProcessed": {
          "buildship": {
            "index": "2"
          },
          "title": "totalProcessed",
          "format": "utc-millisec",
          "type": "string"
        }
      },
      "buildship": {
        "index": "0"
      },
      "type": "object"
    },
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)"
  },
  {
    "output": {
      "properties": {
        "totalProcessed": {
          "buildship": {
            "index": "2"
          },
          "type": "string",
          "title": "totalProcessed",
          "format": "utc-millisec"
        },
        "success": {
          "buildship": {
            "index": "1"
          },
          "type": "string",
          "title": "success"
        },
        "articlesJson": {
          "title": "articlesJson",
          "buildship": {
            "index": "0"
          },
          "type": "string",
          "format": "style"
        }
      },
      "type": "object",
      "buildship": {
        "index": "0"
      }
    },
    "meta": {
      "name": "Starter Script",
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
      "id": "a791c2f1-54cf-4fe5-821f-387ca7684584"
    },
    "script": "export default async function mergeFinalResults({\n    audioArticlesJson,\n    audioSuccess,\n    audioTotal,\n    skipAudioArticlesJson,\n    skipAudioSuccess,\n    skipAudioTotal\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    \n    const hasAudio = audioArticlesJson && audioArticlesJson !== '';\n    \n    if (hasAudio) {\n        return {\n            articlesJson: audioArticlesJson,\n            success: audioSuccess,\n            totalProcessed: audioTotal\n        };\n    } else {\n        return {\n            articlesJson: skipAudioArticlesJson,\n            success: skipAudioSuccess,\n            totalProcessed: skipAudioTotal\n        };\n    }\n}",
    "label": "Merge Final Results",
    "id": "a791c2f1-54cf-4fe5-821f-387ca7684584",
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
    "inputs": {
      "structure": [
        {
          "parentId": null,
          "depth": "0",
          "index": "0",
          "id": "audioArticlesJson"
        },
        {
          "id": "audioSuccess",
          "index": "1",
          "depth": "0",
          "parentId": null
        },
        {
          "depth": "0",
          "index": "2",
          "parentId": null,
          "id": "audioTotal"
        },
        {
          "parentId": null,
          "id": "skipAudioArticlesJson",
          "depth": "0",
          "index": "3"
        },
        {
          "index": "4",
          "parentId": null,
          "id": "skipAudioSuccess",
          "depth": "0"
        },
        {
          "id": "skipAudioTotal",
          "index": "5",
          "parentId": null,
          "depth": "0"
        }
      ],
      "sections": {},
      "type": "object",
      "properties": {
        "audioTotal": {
          "buildship": {
            "defaultExpressionType": "text",
            "sensitive": false,
            "index": "2"
          },
          "title": "Audio Total",
          "type": "string"
        },
        "skipAudioArticlesJson": {
          "buildship": {
            "defaultExpressionType": "text",
            "sensitive": false,
            "index": "3"
          },
          "title": "Skip Audio Articles Json",
          "type": "string"
        },
        "audioSuccess": {
          "buildship": {
            "index": "1",
            "defaultExpressionType": "text",
            "sensitive": false
          },
          "type": "string",
          "title": "Audio Success"
        },
        "audioArticlesJson": {
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "0"
          },
          "type": "string",
          "title": "Audio Articles Json"
        },
        "skipAudioTotal": {
          "type": "string",
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "5"
          },
          "title": "Skip Audio Total"
        },
        "skipAudioSuccess": {
          "title": "Skip Audio Success",
          "buildship": {
            "index": "4",
            "sensitive": false,
            "defaultExpressionType": "text"
          },
          "type": "string"
        }
      },
      "required": []
    },
    "type": "script"
  },
  {
    "meta": {
      "name": "Starter Script",
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
      "id": "8ebeb63a-9a88-4500-9bc4-f806c762bd95"
    },
    "inputs": {
      "structure": [
        {
          "id": "finalArticlesJson",
          "index": "0",
          "parentId": null,
          "depth": "0"
        },
        {
          "parentId": null,
          "depth": "0",
          "id": "success",
          "index": "1"
        },
        {
          "index": "2",
          "depth": "0",
          "id": "originalAction",
          "parentId": null
        },
        {
          "index": "3",
          "parentId": null,
          "depth": "0",
          "id": "targetLanguage"
        }
      ],
      "properties": {
        "finalArticlesJson": {
          "buildship": {
            "index": "0",
            "defaultExpressionType": "text",
            "sensitive": false
          },
          "type": "string",
          "title": "Final Articles Json"
        },
        "success": {
          "type": "string",
          "title": "Success",
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "1"
          }
        },
        "originalAction": {
          "type": "string",
          "title": "Original Action",
          "buildship": {
            "sensitive": false,
            "index": "2",
            "defaultExpressionType": "text"
          }
        },
        "targetLanguage": {
          "title": "Target Language",
          "type": "string",
          "buildship": {
            "index": "3",
            "defaultExpressionType": "text",
            "sensitive": false
          }
        }
      },
      "type": "object",
      "required": [],
      "sections": {}
    },
    "id": "8ebeb63a-9a88-4500-9bc4-f806c762bd95",
    "type": "script",
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
    "output": {
      "buildship": {
        "index": "0"
      },
      "properties": {
        "targetLanguage": {
          "type": "string",
          "title": "targetLanguage",
          "buildship": {
            "index": "4"
          }
        },
        "action": {
          "title": "action",
          "type": "string",
          "buildship": {
            "index": "3"
          }
        },
        "totalProcessed": {
          "type": "number",
          "buildship": {
            "index": "2"
          },
          "title": "totalProcessed"
        },
        "success": {
          "title": "success",
          "buildship": {
            "index": "0"
          },
          "type": "boolean"
        },
        "timestamp": {
          "buildship": {
            "index": "5"
          },
          "format": "date-time",
          "type": "string",
          "title": "timestamp"
        },
        "articles": {
          "type": "array",
          "title": "articles",
          "properties": {
            "object": {
              "type": "object",
              "properties": {
                "author": {
                  "buildship": {
                    "index": "6"
                  },
                  "title": "author",
                  "type": "string"
                },
                "content": {
                  "title": "content",
                  "buildship": {
                    "index": "2"
                  },
                  "type": "string"
                },
                "audioGenerated": {
                  "type": "boolean",
                  "buildship": {
                    "index": "15"
                  },
                  "title": "audioGenerated"
                },
                "imageUrl": {
                  "buildship": {
                    "index": "4"
                  },
                  "type": "string",
                  "title": "imageUrl"
                },
                "translatedContent": {
                  "type": "string",
                  "buildship": {
                    "index": "10"
                  },
                  "title": "translatedContent"
                },
                "category": {
                  "title": "category",
                  "buildship": {
                    "index": "3"
                  },
                  "type": "string"
                },
                "translatedTitle": {
                  "type": "string",
                  "title": "translatedTitle",
                  "buildship": {
                    "index": "11"
                  }
                },
                "processed": {
                  "title": "processed",
                  "type": "boolean",
                  "buildship": {
                    "index": "14"
                  }
                },
                "title": {
                  "title": "title",
                  "buildship": {
                    "index": "1"
                  },
                  "type": "string"
                },
                "videoId": {
                  "buildship": {
                    "index": "5"
                  },
                  "type": "string",
                  "title": "videoId"
                },
                "originalContent": {
                  "type": "string",
                  "buildship": {
                    "index": "9"
                  },
                  "title": "originalContent"
                },
                "id": {
                  "title": "id",
                  "type": "string",
                  "buildship": {
                    "index": "0"
                  }
                },
                "readTime": {
                  "type": "string",
                  "buildship": {
                    "index": "7"
                  },
                  "title": "readTime"
                },
                "lastUpdate": {
                  "buildship": {
                    "index": "8"
                  },
                  "type": "string",
                  "title": "lastUpdate"
                },
                "targetLanguage": {
                  "buildship": {
                    "index": "13"
                  },
                  "title": "targetLanguage",
                  "type": "string"
                },
                "audioUrl": {
                  "buildship": {
                    "index": "12"
                  },
                  "title": "audioUrl",
                  "type": "string",
                  "format": "uri"
                }
              },
              "title": "object",
              "buildship": {
                "index": "0"
              }
            }
          },
          "buildship": {
            "index": "1"
          }
        }
      },
      "type": "object"
    },
    "label": "Build Final Response",
    "script": "export default async function buildArticleProcessingResponse({\n    finalArticlesJson,\n    success,\n    originalAction,\n    targetLanguage\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    \n    const articles = JSON.parse(finalArticlesJson || '[]');\n    \n    logging.log(`Final response: ${articles.length} articles processed`);\n    \n    return {\n        success: success === 'true',\n        articles: articles,\n        totalProcessed: articles.length,\n        action: originalAction,\n        targetLanguage: targetLanguage,\n        timestamp: new Date().toISOString()\n    };\n}"
  },
  {
    "properties": {},
    "id": "21fe6d32-37aa-4056-8ce1-897a2ec95a2b",
    "required": [],
    "type": "output",
    "description": "The Output Node returns values from the flow and handles HTTP response codes.  \nThe default configuration is to return the previous node output. But you can specify any custom output to return variables from other nodes or JavaScript expressions. \n\nLearn more about the Output node: [Docs](https://docs.buildship.com/core-nodes/return)",
    "label": "Output"
  }
]