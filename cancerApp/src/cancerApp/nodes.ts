export const nodes = [
  {
    "type": "script",
    "_groupInfo": {
      "description": "Nodes for storing your files in the built-in BuildShip Storage",
      "iconUrl": "https://firebasestorage.googleapis.com/v0/b/website-a1s39m.appspot.com/o/buildship-app-logos%2FIcon.png?alt=media&token=878ed11b-1cf2-45d8-9951-7e95a16d26af&_gl=1*1ld9l67*_ga*NzgyMDk5NjMxLjE2OTY4NzE3ODU.*_ga_CW55HF8NVT*MTY5NjkyMzc5OC4yLjEuMTY5NjkyMzgzMy4yNS4wLjA.",
      "uid": "buildship-file-storage",
      "name": "BuildShip File Storage"
    },
    "integrity": "v3:f7e21341f08a6999c9986bc8656455c1",
    "dependencies": {
      "stream": "0.0.2",
      "@google-cloud/storage": "7.6.0"
    },
    "script": "import { Storage } from '@google-cloud/storage';\nimport { Readable } from 'stream';\n\nasync function folderExists(bucket, folderPath) {\n  const [exists] = await bucket.file(folderPath + '/').exists();\n  return exists;\n}\n\nasync function createFolders(bucket, folders) {\n  let currentPath = '';\n  for (const folder of folders) {\n    currentPath += folder + '/';\n    const exists = await folderExists(bucket, currentPath);\n    if (!exists) {\n      const file = bucket.file(currentPath);\n      try {\n        await file.save('');\n        console.log(`Folder \"${currentPath}\" created successfully.`);\n      } catch (error) {\n        console.error(`Error creating folder \"${currentPath}\":`, error);\n        throw error;\n      }\n    }\n  }\n}\n\nexport default async function uploadBase64ToGcpStorage(\n  { base64, fileName }: NodeInputs,\n  { logging }\n: NodeScriptOptions) : NodeOutput  {\n  \n  // Add input validation\n  if (!base64) {\n    logging.error('base64 input is undefined or null');\n    throw new Error('base64 input is required');\n  }\n  \n  if (!fileName) {\n    logging.error('fileName input is undefined or null');\n    throw new Error('fileName input is required');\n  }\n  \n  logging.log(`Received base64 data length: ${base64.length}`);\n  logging.log(`Filename: ${fileName}`);\n  \n  // Handle different base64 formats more robustly\n  let base64Data;\n  if (base64.includes(';base64,')) {\n    // Handle data URLs like \"data:audio/wav;base64,UklGR...\"\n    base64Data = base64.split(';base64,').pop();\n  } else if (base64.includes(',')) {\n    // Handle simple prefixed base64 like \"data:audio/wav,UklGR...\"\n    base64Data = base64.split(',').pop();\n  } else {\n    // Already clean base64 data\n    base64Data = base64;\n  }\n  \n  const folders = fileName.split('/').slice(0, -1);\n  const storage = new Storage();\n  const bucket = storage.bucket(process.env.BUCKET);\n  const file = bucket.file(fileName);\n  const base64Decoded = Buffer.from(base64Data, 'base64');\n  \n  try {\n    if (folders.length > 0) {\n      await createFolders(bucket, folders);\n    }\n    \n    const writeStream = file.createWriteStream({\n      contentType: 'audio/x-m4a', // Specify audio content type instead of 'auto'\n      resumable: false,\n    });\n    \n    const readableStream = new Readable();\n    readableStream.push(base64Decoded);\n    readableStream.push(null);\n    readableStream.pipe(writeStream);\n    \n    await new Promise((resolve, reject) => {\n      writeStream.on('finish', resolve);\n      writeStream.on('error', reject);\n    });\n    \n    await file.makePublic();\n    \n    const publicUrl = `https://storage.googleapis.com/${bucket.name}/${file.name}`;\n    logging.log(`File uploaded successfully: ${publicUrl}`);\n    \n    // Return object with publicUrl property (not just the string)\n    return {\n      publicUrl: publicUrl\n    };\n  } catch (error) {\n    logging.error('Error uploading base64 data to GCP Storage:', error);\n    throw error;\n  }\n}",
    "groupInfo": "0IAjU2tekQHjibkvicpD",
    "inputs": {
      "properties": {
        "base64": {
          "buildship": {
            "sensitive": false,
            "placeholder": "data:image/png;base64,iVBORw0KGgoAAAANS...",
            "index": "0"
          },
          "properties": {},
          "type": "string",
          "title": "Base64 File",
          "description": "The Base64 string of the file to upload."
        },
        "fileName": {
          "description": "The name of the output file along with the file extension. (For Example: `output.png`)",
          "buildship": {
            "placeholder": "/folder-path/output.png",
            "sensitive": false,
            "index": "1"
          },
          "type": "string",
          "properties": {},
          "title": "File Name"
        }
      },
      "type": "object",
      "required": [
        "base64",
        "fileName"
      ]
    },
    "id": "e25c9a7a-7e2d-492f-90d8-6e1139f8a67f",
    "version": "5.0.0",
    "meta": {
      "description": "Uploads a Base64 file to BuildShip's in-built Google Cloud Storage Bucket and returns the public URL",
      "icon": {
        "type": "URL",
        "url": "https://firebasestorage.googleapis.com/v0/b/website-a1s39m.appspot.com/o/buildship-app-logos%2FIcon.png?alt=media&token=878ed11b-1cf2-45d8-9951-7e95a16d26af&_gl=1*1ld9l67*_ga*NzgyMDk5NjMxLjE2OTY4NzE3ODU.*_ga_CW55HF8NVT*MTY5NjkyMzc5OC4yLjEuMTY5NjkyMzgzMy4yNS4wLjA."
      },
      "name": "Upload Base64 File",
      "id": "buildship-gcp-storage-upload-base64"
    },
    "integrations": [],
    "src": "https://storage.googleapis.com/buildship-app-us-central1/publicLib/nodesV2/@buildship/buildship-gcp-storage-upload-base64/5.0.0/build.cjs",
    "label": "Upload Input Audio to Storage",
    "_libRef": {
      "isDirty": true,
      "src": "https://storage.googleapis.com/buildship-app-us-central1/publicLib/nodesV2/@buildship/buildship-gcp-storage-upload-base64/5.0.0/build.cjs",
      "integrity": "v3:f7e21341f08a6999c9986bc8656455c1",
      "libType": "public",
      "libNodeRefId": "@buildship/buildship-gcp-storage-upload-base64",
      "version": "5.0.0",
      "buildHash": "c8b3e3e7d67d74bf590bd72b2687c34d8f8ebd06f85072c3431b8aec3cf22ecd"
    },
    "output": {
      "buildship": {
        "index": "0"
      },
      "properties": {
        "publicUrl": {
          "type": "string",
          "buildship": {
            "index": "0"
          },
          "title": "publicUrl",
          "format": "uri"
        }
      },
      "type": "object"
    }
  },
  {
    "script": "export default async function convertAudioZamzar({\n    audioUrl,\n    apiKey\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    try {\n        logging.log(`Converting M4A to MP3 using Zamzar API`);\n        \n        // Parse URL if it's an object\n        let url = audioUrl;\n        if (typeof audioUrl === 'object' && audioUrl.publicUrl) {\n            url = audioUrl.publicUrl;\n        }\n        \n        logging.log(`Input URL: ${url}`);\n        \n        // Step 1: Submit conversion job with correct parameter format\n        const jobData = new FormData();\n        jobData.append('source_file', url);\n        jobData.append('target_format', 'mp3');\n        \n        const conversionResponse = await fetch('https://sandbox.zamzar.com/v1/jobs', {\n            method: 'POST',\n            headers: {\n                'Authorization': `Basic ${Buffer.from(apiKey + ':').toString('base64')}`\n                // Don't set Content-Type for FormData\n            },\n            body: jobData\n        });\n        \n        if (!conversionResponse.ok) {\n            const error = await conversionResponse.text();\n            throw new Error(`Zamzar API failed: ${conversionResponse.status} - ${error}`);\n        }\n        \n        const job = await conversionResponse.json();\n        const jobId = job.id;\n        \n        logging.log(`Conversion job started: ${jobId}`);\n        \n        // Step 2: Poll for completion\n        let attempts = 0;\n        const maxAttempts = 60; // 2 minutes\n        \n        while (attempts < maxAttempts) {\n            await new Promise(resolve => setTimeout(resolve, 2000));\n            attempts++;\n            \n            const statusResponse = await fetch(`https://sandbox.zamzar.com/v1/jobs/${jobId}`, {\n                headers: {\n                    'Authorization': `Basic ${Buffer.from(apiKey + ':').toString('base64')}`\n                }\n            });\n            \n            if (!statusResponse.ok) {\n                logging.error(`Status check failed: ${statusResponse.status}`);\n                continue;\n            }\n            \n            const status = await statusResponse.json();\n            logging.log(`Attempt ${attempts}: Status = ${status.status}`);\n            \n            if (status.status === 'successful') {\n                // Get the converted file\n                const fileId = status.target_files[0].id;\n                const downloadUrl = `https://sandbox.zamzar.com/v1/files/${fileId}/content`;\n                \n                logging.log(`✅ Conversion completed, file ID: ${fileId}`);\n                \n                return {\n                    publicUrl: downloadUrl,\n                    fileId: fileId,\n                    downloadHeaders: {\n                        'Authorization': `Basic ${Buffer.from(apiKey + ':').toString('base64')}`\n                    }\n                };\n            }\n            \n            if (status.status === 'failed') {\n                throw new Error(`Audio conversion failed: ${status.failure_reason || 'Unknown error'}`);\n            }\n        }\n        \n        throw new Error('Audio conversion timeout');\n        \n    } catch (error) {\n        logging.error(`Audio conversion failed: ${error.message}`);\n        throw error;\n    }\n}",
    "isCollapsed": false,
    "description": "Select translatedText if available, else fall back to original transcribedText.",
    "output": {
      "properties": {
        "publicUrl": {
          "type": "string",
          "title": "publicUrl",
          "buildship": {
            "index": "0"
          },
          "format": "uri"
        },
        "downloadHeaders": {
          "type": "object",
          "properties": {
            "Authorization": {
              "title": "Authorization",
              "type": "string",
              "buildship": {
                "index": "0"
              }
            }
          },
          "buildship": {
            "index": "2"
          },
          "title": "downloadHeaders"
        },
        "fileId": {
          "title": "fileId",
          "buildship": {
            "index": "1"
          },
          "type": "number"
        }
      },
      "type": "object",
      "buildship": {
        "index": "0"
      }
    },
    "id": "42b28296-d752-466b-83ce-c6de14f5b35b",
    "label": "Convert M4A to MP3",
    "inputs": {
      "properties": {
        "audioUrl": {
          "type": "string",
          "title": "audio Url",
          "description": "URL for M4a file",
          "buildship": {
            "sensitive": false,
            "index": "0",
            "defaultExpressionType": "text"
          }
        },
        "apiKey": {
          "buildship": {
            "index": "1",
            "defaultExpressionType": "text",
            "sensitive": false
          },
          "type": "string",
          "title": "Authorization"
        }
      },
      "sections": {},
      "type": "object",
      "structure": [
        {
          "index": "0",
          "parentId": null,
          "depth": "0",
          "id": "audioUrl"
        },
        {
          "depth": "0",
          "parentId": null,
          "index": "1",
          "id": "apiKey"
        }
      ],
      "required": [
        "authorization"
      ]
    },
    "type": "script",
    "plan": {
      "output": [
        {
          "name": "Final Text",
          "id": "finalText",
          "description": "Final text to synthesize (translated or original).",
          "type": "string"
        }
      ],
      "description": "Select translatedText if available, else fall back to original transcribedText.",
      "name": "Merge Final Text Output",
      "inputs": [
        {
          "_ai_instruction": "Use {{translate-text.translatedText}} if branch-translate.then ran, else {{passthrough-text.translatedText}}.",
          "name": "Translated Text",
          "id": "translatedText",
          "type": "string",
          "description": "The translated text from previous node."
        },
        {
          "id": "transcribedText",
          "_ai_instruction": "Set to {{transcribe-audio.transcribedText}}.",
          "description": "The original transcribed text.",
          "name": "Transcribed Text",
          "type": "string"
        }
      ]
    },
    "meta": {
      "id": "merge-final-text-output",
      "name": "Merge Final Text Output",
      "description": "Select translatedText if available, else fall back to original transcribedText.",
      "icon": {
        "type": "URL",
        "url": null
      }
    },
    "name": "Merge Final Text Output"
  },
  {
    "description": "Select translatedText if available, else fall back to original transcribedText.",
    "inputs": {
      "structure": [
        {
          "depth": "0",
          "index": "0",
          "id": "zamzarResponse",
          "parentId": null
        },
        {
          "id": "fileName",
          "parentId": null,
          "depth": "0",
          "index": "1"
        }
      ],
      "properties": {
        "fileName": {
          "type": "string",
          "title": "File Name",
          "buildship": {
            "index": "1",
            "sensitive": false,
            "defaultExpressionType": "text"
          }
        },
        "zamzarResponse": {
          "buildship": {
            "sensitive": false,
            "index": "0",
            "defaultExpressionType": "text"
          },
          "title": "Zamzar Response",
          "description": "URL for M4a file",
          "type": "object",
          "properties": {}
        }
      },
      "required": [
        "authorization"
      ],
      "sections": {},
      "type": "object"
    },
    "name": "Merge Final Text Output",
    "script": "import { Storage } from '@google-cloud/storage';\nimport { Readable } from 'stream';\n\nasync function folderExists(bucket, folderPath) {\n  const [exists] = await bucket.file(folderPath + '/').exists();\n  return exists;\n}\n\nasync function createFolders(bucket, folders) {\n  let currentPath = '';\n  for (const folder of folders) {\n    currentPath += folder + '/';\n    const exists = await folderExists(bucket, currentPath);\n    if (!exists) {\n      const file = bucket.file(currentPath);\n      try {\n        await file.save('');\n        console.log(`Folder \"${currentPath}\" created successfully.`);\n      } catch (error) {\n        console.error(`Error creating folder \"${currentPath}\":`, error);\n        throw error;\n      }\n    }\n  }\n}\n\nexport default async function downloadAndReuploadMP3({\n    zamzarResponse,\n    fileName\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    try {\n        logging.log(`Downloading MP3 from Zamzar and re-uploading to storage`);\n        \n        // Parse the Zamzar response\n        let zamzarData = zamzarResponse;\n        if (typeof zamzarResponse === 'string') {\n            zamzarData = JSON.parse(zamzarResponse);\n        }\n        \n        const zamzarUrl = zamzarData.publicUrl;\n        const authHeader = zamzarData.downloadHeaders.Authorization;\n        \n        logging.log(`Downloading from: ${zamzarUrl}`);\n        \n        // Download the MP3 file from Zamzar with authentication\n        const downloadResponse = await fetch(zamzarUrl, {\n            headers: {\n                'Authorization': authHeader\n            }\n        });\n        \n        if (!downloadResponse.ok) {\n            throw new Error(`Failed to download MP3 from Zamzar: ${downloadResponse.status}`);\n        }\n        \n        const mp3Buffer = await downloadResponse.arrayBuffer();\n        logging.log(`Downloaded MP3: ${mp3Buffer.byteLength} bytes`);\n        \n        // Upload to Google Cloud Storage\n        const folders = fileName.split('/').slice(0, -1);\n        const storage = new Storage();\n        const bucket = storage.bucket(process.env.BUCKET);\n        const file = bucket.file(fileName);\n        \n        if (folders.length > 0) {\n            await createFolders(bucket, folders);\n        }\n        \n        const writeStream = file.createWriteStream({\n            contentType: 'audio/mpeg', // Correct MIME type for MP3\n            resumable: false,\n        });\n        \n        const readableStream = new Readable();\n        readableStream.push(Buffer.from(mp3Buffer));\n        readableStream.push(null);\n        readableStream.pipe(writeStream);\n        \n        await new Promise((resolve, reject) => {\n            writeStream.on('finish', resolve);\n            writeStream.on('error', reject);\n        });\n        \n        await file.makePublic();\n        \n        const publicUrl = `https://storage.googleapis.com/${bucket.name}/${file.name}`;\n        logging.log(`MP3 uploaded successfully: ${publicUrl}`);\n        \n        return {\n            publicUrl: publicUrl\n        };\n        \n    } catch (error) {\n        logging.error(`Download and re-upload failed: ${error.message}`);\n        throw error;\n    }\n}",
    "output": {
      "properties": {
        "publicUrl": {
          "format": "uri",
          "type": "string",
          "buildship": {
            "index": "0"
          },
          "title": "publicUrl"
        },
        "downloadHeaders": {
          "title": "downloadHeaders",
          "buildship": {
            "index": "2"
          },
          "properties": {
            "Authorization": {
              "title": "Authorization",
              "type": "string",
              "buildship": {
                "index": "0"
              }
            }
          },
          "type": "object"
        },
        "fileId": {
          "buildship": {
            "index": "1"
          },
          "title": "fileId",
          "type": "number"
        }
      },
      "type": "object",
      "buildship": {
        "index": "0"
      }
    },
    "plan": {
      "output": [
        {
          "type": "string",
          "name": "Final Text",
          "description": "Final text to synthesize (translated or original).",
          "id": "finalText"
        }
      ],
      "inputs": [
        {
          "description": "The translated text from previous node.",
          "type": "string",
          "name": "Translated Text",
          "id": "translatedText",
          "_ai_instruction": "Use {{translate-text.translatedText}} if branch-translate.then ran, else {{passthrough-text.translatedText}}."
        },
        {
          "id": "transcribedText",
          "description": "The original transcribed text.",
          "name": "Transcribed Text",
          "type": "string",
          "_ai_instruction": "Set to {{transcribe-audio.transcribedText}}."
        }
      ],
      "name": "Merge Final Text Output",
      "description": "Select translatedText if available, else fall back to original transcribedText."
    },
    "label": "Download & Re-upload",
    "type": "script",
    "meta": {
      "name": "Merge Final Text Output",
      "icon": {
        "url": null,
        "type": "URL"
      },
      "description": "Select translatedText if available, else fall back to original transcribedText.",
      "id": "merge-final-text-output"
    },
    "id": "ba67b2a1-66c2-4144-9144-9914ffb7cff1"
  },
  {
    "id": "a4e5a4d6-d8d1-4840-b19c-e643c6355aba",
    "meta": {
      "name": "Transcribe Audio with Spitch",
      "icon": {
        "type": "URL",
        "url": null
      },
      "description": "Transcribe the uploaded audio using Spitch API. Uses Spitch REST API (api.spi-tch.com) with Bearer {{SPITCH_API_KEY}} authorization.",
      "id": "transcribe-audio-with-spitch"
    },
    "label": "Transcribe Audio with Spitch",
    "plan": {
      "description": "Transcribe the uploaded audio using Spitch API. Uses Spitch REST API (api.spi-tch.com) with Bearer {{SPITCH_API_KEY}} authorization.",
      "inputs": [
        {
          "type": "string",
          "description": "Spitch transcription endpoint.",
          "sampleValue": "https://api.spi-tch.com/v1/speech/transcribe",
          "id": "endpoint",
          "_ai_instruction": "Always use the api.spi-tch.com endpoint.",
          "name": "API Endpoint"
        },
        {
          "_ai_instruction": "Set to {{upload-audio.publicUrl}}.",
          "description": "URL of audio file to transcribe.",
          "name": "URL",
          "type": "string",
          "id": "url"
        },
        {
          "_ai_instruction": "Set to input sourceLanguage.",
          "id": "language",
          "name": "Language",
          "type": "string",
          "description": "Source language code."
        },
        {
          "name": "Authorization",
          "_ai_instruction": "Set to Bearer {{SPITCH_API_KEY}}.",
          "description": "Bearer token for Spitch.",
          "type": "string",
          "id": "authorization"
        },
        {
          "name": "Content-Type",
          "description": "Content type header.",
          "type": "string",
          "_ai_instruction": "Set to 'application/json'.",
          "id": "contentType",
          "sampleValue": "application/json"
        }
      ],
      "name": "Transcribe Audio with Spitch",
      "output": [
        {
          "id": "transcribedText",
          "name": "Transcribed Text",
          "type": "string",
          "description": "The transcribed text from Spitch API."
        },
        {
          "description": "The error message if transcription fails.",
          "type": "string",
          "id": "error",
          "name": "Error Message"
        }
      ]
    },
    "script": "export default async function spitchTranscription({\n    endpoint,\n    url,\n    language,\n    authorization,\n    contentType\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    try {\n        // Parse the URL if it's coming as an object\n        let audioUrl;\n        if (typeof url === 'string') {\n            audioUrl = url;\n        } else if (typeof url === 'object' && url.publicUrl) {\n            audioUrl = url.publicUrl;\n        } else if (typeof url === 'string' && url.startsWith('{')) {\n            // Handle case where object is passed as string\n            try {\n                const parsedUrl = JSON.parse(url);\n                audioUrl = parsedUrl.publicUrl;\n            } catch {\n                audioUrl = url;\n            }\n        } else {\n            throw new Error(\"Invalid URL format received\");\n        }\n        \n        // Validate required inputs\n        if (!audioUrl) {\n            throw new Error(\"Audio URL is required\");\n        }\n        if (!language) {\n            throw new Error(\"Language parameter is required\");\n        }\n        if (!authorization) {\n            throw new Error(\"Authorization token is required\");\n        }\n        \n        // Log inputs for debugging\n        logging.log(`Transcribing audio from URL: ${audioUrl}`);\n        logging.log(`Language: ${language}`);\n        logging.log(`Endpoint: ${endpoint}`);\n        \n        // Create FormData instead of JSON (this is the key fix)\n        const formData = new FormData();\n        formData.append('url', audioUrl);  // Use the parsed URL\n        formData.append('language', language);\n        \n        logging.log(`Sending FormData with url: ${audioUrl}, language: ${language}`);\n        \n        const response = await fetch(endpoint, {\n            method: 'POST',\n            headers: {\n                'Authorization': authorization,\n                // DO NOT set Content-Type - let FormData handle it automatically\n            },\n            body: formData  // Use FormData instead of JSON.stringify()\n        });\n        \n        if (!response.ok) {\n            const errorData = await response.text();\n            logging.error(`Transcription failed with status: ${response.status}`);\n            logging.error(`Error details: ${errorData}`);\n            return {\n                transcribedText: '',\n                error: `Transcription failed: ${response.status} ${response.statusText}. ${errorData}`\n            };\n        }\n        \n        const data = await response.json();\n        logging.log(`API Response: ${JSON.stringify(data)}`);\n        logging.log('Transcription completed successfully');\n        \n        return {\n            transcribedText: data.text || data.transcript || data.transcription || '',\n            error: null\n        };\n    } catch (error) {\n        logging.error(`Exception during transcription: ${error.message}`);\n        return {\n            transcribedText: '',\n            error: `Transcription failed: ${error.message}`\n        };\n    }\n}",
    "type": "script",
    "description": "Transcribe the uploaded audio using Spitch API. Uses Spitch REST API (api.spi-tch.com) with Bearer {{SPITCH_API_KEY}} authorization.",
    "output": {
      "buildship": {
        "index": "0"
      },
      "type": "object",
      "properties": {
        "transcribedText": {
          "title": "transcribedText",
          "buildship": {
            "index": "0"
          },
          "type": "string"
        },
        "error": {
          "type": "string",
          "format": "style",
          "buildship": {
            "index": "1"
          },
          "title": "error"
        }
      }
    },
    "inputs": {
      "properties": {
        "language": {
          "title": "Language",
          "description": "Language code for transcription (e.g., en, fr, de)",
          "type": "string",
          "buildship": {
            "index": "3",
            "userPromptHint": "Enter the language code for transcription"
          }
        },
        "endpoint": {
          "buildship": {
            "index": "1",
            "userPromptHint": "Enter the Spitch API endpoint URL"
          },
          "type": "string",
          "description": "Spitch API endpoint URL (e.g., https://api.spi-tch.com/transcribe)",
          "title": "Endpoint"
        },
        "authorization": {
          "description": "Bearer token for Spitch API (e.g., Bearer {{SPITCH_API_KEY}})",
          "type": "string",
          "title": "Authorization",
          "buildship": {
            "userPromptHint": "Enter your Spitch API Bearer token",
            "index": "0",
            "sensitive": true
          }
        },
        "url": {
          "type": "string",
          "description": "URL of the audio file to transcribe",
          "title": "Audio URL",
          "buildship": {
            "index": "2",
            "userPromptHint": "Enter the URL of the audio file to transcribe"
          }
        }
      },
      "type": "object",
      "required": [
        "authorization",
        "endpoint",
        "url",
        "language"
      ],
      "structure": [
        {
          "index": "0",
          "parentId": null,
          "id": "authorization",
          "depth": "0"
        },
        {
          "id": "endpoint",
          "depth": "0",
          "parentId": null,
          "index": "1"
        },
        {
          "parentId": null,
          "index": "2",
          "depth": "0",
          "id": "url"
        },
        {
          "parentId": null,
          "index": "3",
          "depth": "0",
          "id": "language"
        }
      ],
      "sections": {}
    }
  },
  {
    "script": "export default async function spitchTranslate({\n    endpoint,\n    text,\n    source,\n    target,\n    authorization,\n    contentType\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    try {\n        // Validate inputs\n        if (!text) {\n            throw new Error(\"No text provided for translation\");\n        }\n\n        if (!source) {\n            throw new Error(\"Source language not specified\");\n        }\n\n        if (!target) {\n            throw new Error(\"Target language not specified\");\n        }\n\n        // Prepare request payload\n        const payload = {\n            text,\n            source: source,\n            target: target\n        };\n\n        // Make the API request\n        logging.log(`Translating text from ${source} to ${target}`);\n\n        const response = await fetch(endpoint, {\n            method: 'POST',\n            headers: {\n                'Authorization': authorization,\n                'Content-Type': contentType || 'application/json'\n            },\n            body: JSON.stringify(payload)\n        });\n\n        const data = await response.json();\n\n        // Check for API errors\n        if (!response.ok) {\n            throw new Error(data.message || `API error: ${response.status} ${response.statusText}`);\n        }\n\n        // Return the translated text\n        return {\n            translatedText: data.translated_text || data.translation || data.text,\n            error: null\n        };\n    } catch (error) {\n        // Log and return the error\n        logging.error(`Translation error: ${error.message}`);\n\n        return {\n            translatedText: null,\n            error: error.message\n        };\n    }\n}",
    "name": "Translate Text with Spitch",
    "id": "df983403-6ae0-4c73-b3d9-ebd04bb4749e",
    "output": {
      "type": "object",
      "buildship": {
        "index": "0"
      },
      "properties": {
        "error": {
          "type": "null",
          "buildship": {
            "index": "1"
          },
          "title": "error"
        },
        "translatedText": {
          "buildship": {
            "index": "0"
          },
          "title": "translatedText",
          "type": "string"
        }
      }
    },
    "meta": {
      "icon": {
        "url": null,
        "type": "URL"
      },
      "name": "Translate Text with Spitch",
      "id": "translate-text-with-spitch",
      "description": "Translate text using Spitch Translation API (api.spi-tch.com) with Bearer {{SPITCH_API_KEY}}."
    },
    "plan": {
      "description": "Translate text using Spitch Translation API (api.spi-tch.com) with Bearer {{SPITCH_API_KEY}}.",
      "inputs": [
        {
          "id": "endpoint",
          "sampleValue": "https://api.spi-tch.com/v1/translate",
          "description": "Spitch translation endpoint.",
          "name": "API Endpoint",
          "_ai_instruction": "Always use the api.spi-tch.com endpoint.",
          "type": "string"
        },
        {
          "description": "Text to translate.",
          "name": "Text",
          "_ai_instruction": "Set to {{transcribe-audio.transcribedText}}.",
          "type": "string",
          "id": "text"
        },
        {
          "name": "Source",
          "_ai_instruction": "Set to input sourceLanguage.",
          "description": "Source language code.",
          "type": "string",
          "id": "source"
        },
        {
          "name": "Target",
          "id": "target",
          "type": "string",
          "_ai_instruction": "Set to input targetLanguage.",
          "description": "Target language code."
        },
        {
          "description": "Bearer token for Spitch.",
          "_ai_instruction": "Set to Bearer {{SPITCH_API_KEY}}.",
          "id": "authorization",
          "type": "string",
          "name": "Authorization"
        },
        {
          "_ai_instruction": "Set to 'application/json'.",
          "id": "contentType",
          "sampleValue": "application/json",
          "type": "string",
          "name": "Content-Type",
          "description": "Content type header."
        }
      ],
      "name": "Translate Text with Spitch",
      "output": [
        {
          "type": "string",
          "description": "The translated text from Spitch API.",
          "id": "translatedText",
          "name": "Translated Text"
        },
        {
          "type": "string",
          "id": "error",
          "description": "The error message if translation fails.",
          "name": "Error Message"
        }
      ]
    },
    "inputs": {
      "type": "object",
      "required": [
        "authorization",
        "endpoint",
        "text",
        "source",
        "target"
      ],
      "properties": {
        "source": {
          "title": "Source Language",
          "description": "Source language code (e.g., en, fr, de).",
          "buildship": {
            "index": "3",
            "userPromptHint": "Enter the source language code."
          },
          "type": "string"
        },
        "endpoint": {
          "buildship": {
            "index": "1",
            "userPromptHint": "Enter the Spitch API endpoint (e.g., https://api.spi-tch.com/translate)."
          },
          "description": "Spitch Translation API endpoint URL.",
          "type": "string",
          "title": "Endpoint"
        },
        "text": {
          "description": "Text to be translated.",
          "buildship": {
            "userPromptHint": "Enter the text you want to translate.",
            "index": "2"
          },
          "title": "Text",
          "type": "string"
        },
        "authorization": {
          "title": "Authorization",
          "description": "Bearer token for Spitch API authentication (e.g., Bearer {{SPITCH_API_KEY}}).",
          "type": "string",
          "buildship": {
            "index": "0",
            "userPromptHint": "Enter your Spitch API Bearer token.",
            "sensitive": true
          }
        },
        "target": {
          "title": "Target Language",
          "type": "string",
          "buildship": {
            "index": "4",
            "userPromptHint": "Enter the target language code."
          },
          "description": "Target language code (e.g., en, fr, de)."
        },
        "contentType": {
          "buildship": {
            "validationErrorMessage": "Content-Type must be a valid MIME type.",
            "userPromptHint": "Enter the Content-Type header value if different from application/json.",
            "index": "5"
          },
          "description": "Content-Type header value (defaults to application/json).",
          "title": "Content Type",
          "type": "string"
        }
      }
    },
    "type": "script",
    "label": "Translate Question to English",
    "description": "Translate text using Spitch Translation API (api.spi-tch.com) with Bearer {{SPITCH_API_KEY}}."
  },
  {
    "script": "// -------------------------------------------------------------\n//  SYSTEM PROMPT — Condensed, optimized, medically safe\n// -------------------------------------------------------------\nconst SYSTEM_PROMPT = `\nYou are a highly experienced oncologist providing clear, calm, supportive guidance.\nUse patient-friendly explanations grounded in evidence.\n\n### Cancer Knowledge (Use only when relevant)\n• Breast cancer signs: new lumps, skin dimpling, shape/size changes, nipple inversion/rash, unusual/bloody discharge, armpit swelling.\n• Cervical cancer: early silent; later → unusual bleeding, watery/bloody discharge, pain during sex.\n• Prostate cancer: early silent; later → weak stream, urgency, night urination, incomplete emptying; advanced → weight loss, bone pain, blood in urine/semen.\n• Screening: mammogram (40+ risk-based), Pap/HPV routine intervals, PSA requires shared decision-making.\n• Treatment categories: surgery, radiation, chemotherapy, immunotherapy.\n• Post-chemo tips: dental prep; nausea → small bland meals; fatigue → short naps + gentle exercise; neuropathy → padded shoes; mouth sores → baking soda + salt rinse.\n• Red flags: fever ≥ 38°C, persistent vomiting/diarrhea, chest pain, breathing difficulty, unusual bleeding, sudden severe pain, port-site infection.\n\n### Safety Rules\n• Do NOT diagnose. Clarify possibilities only.\n• Do NOT give medication dosages.\n• For red flags or severe symptoms, advise urgent in-person care.\n• Ask clarifying questions rather than guessing.\n\n### Style\n• Respond in **3–4 sentences max**, ≤80 words.\n• Warm, supportive, medically safe.\n• Use simple language.\n• Reference conversation history only if relevant.\n• End with a follow-up question when appropriate.\n\n### Memory Trimming\nYou will receive:\n1) Short summary of earlier conversation  \n2) Latest user message  \nUse both only for continuity.\n`;\n\n\n// -------------------------------------------------------------\n// SELF-DIAGNOSIS GUARDRAIL\n// -------------------------------------------------------------\nfunction isSelfDiagnosisRequest(message: string): boolean {\n  const text = message.toLowerCase();\n\n  const forbidden = [\n    /do i have cancer/,\n    /can you tell if i have/,\n    /does this mean i have/,\n    /confirm.*i have/,\n    /do you think i have/,\n    /diagnose me/\n  ];\n  if (forbidden.some((p) => p.test(text))) return true;\n\n  const allowed = [\n    /how would i know if i have/,\n    /how do i know if i have/,\n    /what are the signs/,\n    /what are the symptoms/,\n    /how is cancer diagnosed/,\n    /how do people find out/,\n  ];\n  if (allowed.some((p) => p.test(text))) return false;\n\n  return false;\n}\n\n\n\n// ====================================================================\n// MAIN FUNCTION — FIXED GEMMA-COMPATIBLE VERSION\n// ====================================================================\nexport default async function processCancerQuestion(\n  { question, originalLanguage, apiKey, conversationHistory }: NodeInputs,\n  { logging }: NodeScriptOptions\n) {\n  try {\n    logging.log(`Processing cancer question: ${question}`);\n\n    // -------------------------------------------------------------\n    // Self-diagnosis block\n    // -------------------------------------------------------------\n    if (isSelfDiagnosisRequest(question)) {\n      return {\n        medicalResponse:\n          \"I can’t determine whether you have cancer. A clinician would need to assess symptoms directly and may recommend imaging or lab tests. What changes or symptoms made you wonder about this?\",\n        success: true\n      };\n    }\n\n    // -------------------------------------------------------------\n    // Parse conversation history safely\n    // -------------------------------------------------------------\n    let historyArray = [];\n    try {\n      if (conversationHistory && conversationHistory !== \"[]\") {\n        historyArray = JSON.parse(conversationHistory);\n      }\n    } catch (err) {\n      logging.error(\"Failed to parse conversation history, resetting.\");\n      historyArray = [];\n    }\n\n    // -------------------------------------------------------------\n    // Hybrid memory trimming\n    // -------------------------------------------------------------\n    let conversationSummary = \"\";\n    let lastUserMessage = \"\";\n\n    if (historyArray.length > 0) {\n      // last user turn\n      for (let i = historyArray.length - 1; i >= 0; i--) {\n        if (historyArray[i].isUser) {\n          lastUserMessage = historyArray[i].text;\n          break;\n        }\n      }\n\n      // compressed summary (≤10 bullets)\n      const bullets = [];\n      for (const msg of historyArray.slice(0, -1)) {\n        if (bullets.length < 10) {\n          bullets.push(\n            msg.isUser\n              ? `• Patient noted: ${msg.text.slice(0, 140)}`\n              : `• Doctor responded: ${msg.text.slice(0, 140)}`\n          );\n        }\n      }\n      conversationSummary = bullets.join(\"\\n\");\n    }\n\n    // -------------------------------------------------------------\n    // Prepare final USER prompt (Gemma only reads user role)\n    // -------------------------------------------------------------\n    const finalPrompt = `\n${SYSTEM_PROMPT}\n\n### Previous Summary\n${conversationSummary || \"None\"}\n\n### Last User Message\n${lastUserMessage || \"None\"}\n\n### New Question\n${question}\n\nFollow all rules above.\n    `;\n\n    // -------------------------------------------------------------\n    // API CALL — FIXED (Gemma-compatible structure)\n    // -------------------------------------------------------------\n    const model = \"gemma-3n-e4b-it\";\n\n    const payload = {\n      contents: [\n        {\n          role: \"user\",\n          parts: [{ text: finalPrompt }]\n        }\n      ],\n      generationConfig: {\n        temperature: 0.3,\n        topP: 0.7,\n        topK: 10,\n        maxOutputTokens: 200\n      }\n    };\n\n    const response = await fetch(\n      `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${apiKey}`,\n      {\n        method: \"POST\",\n        headers: { \"Content-Type\": \"application/json\" },\n        body: JSON.stringify(payload)\n      }\n    );\n\n    const raw = await response.text();\n\n    if (!response.ok) {\n      throw new Error(`API error ${response.status}: ${raw}`);\n    }\n\n    const data = JSON.parse(raw);\n\n    const aiResponse =\n      data?.candidates?.[0]?.content?.parts?.[0]?.text?.trim() || \"\";\n\n    if (!aiResponse) {\n      throw new Error(\"Empty response from model\");\n    }\n\n    // -------------------------------------------------------------\n    // Guarantee follow-up question\n    // -------------------------------------------------------------\n    let finalAnswer = aiResponse;\n\n    if (!finalAnswer.includes(\"?\")) {\n      const followUps = [\n        \" What changes have you noticed?\",\n        \" When did these symptoms start?\",\n        \" Has anything made the symptoms better or worse?\",\n        \" Have you done any screening tests recently?\"\n      ];\n      finalAnswer += followUps[Math.floor(Math.random() * followUps.length)];\n    }\n\n    return {\n      medicalResponse: finalAnswer,\n      success: true\n    };\n\n  } catch (error) {\n    // NEVER let it crash — match pregnancy version behavior\n    return {\n      medicalResponse:\n        \"I wasn't able to process that. Please speak with an oncologist or healthcare provider for proper evaluation.\",\n      success: false\n    };\n  }\n}\n",
    "inputs": {
      "sections": {},
      "required": [],
      "structure": [
        {
          "index": "0",
          "parentId": null,
          "id": "question",
          "depth": "0"
        },
        {
          "id": "originalLanguage",
          "index": "1",
          "depth": "0",
          "parentId": null
        },
        {
          "index": "2",
          "id": "apiKey",
          "depth": "0",
          "parentId": null
        },
        {
          "index": "3",
          "id": "conversationHistory",
          "parentId": null,
          "depth": "0"
        }
      ],
      "type": "object",
      "properties": {
        "question": {
          "buildship": {
            "index": "0",
            "sensitive": false,
            "defaultExpressionType": "text"
          },
          "title": "Question",
          "type": "string"
        },
        "apiKey": {
          "buildship": {
            "defaultExpressionType": "text",
            "index": "2",
            "sensitive": false
          },
          "type": "string",
          "title": "Authorization"
        },
        "originalLanguage": {
          "title": "Original Language",
          "type": "string",
          "buildship": {
            "index": "1",
            "defaultExpressionType": "text",
            "sensitive": false
          }
        },
        "conversationHistory": {
          "type": "string",
          "title": "Conversation History",
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "3"
          }
        }
      }
    },
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
    "label": "Process Medical Question with Gemma",
    "name": "Starter Script",
    "type": "script",
    "meta": {
      "name": "Starter Script",
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
      "id": "109faef2-eb6c-40bc-ac2c-d8db178059d9"
    },
    "output": {
      "type": "object",
      "properties": {
        "medicalResponse": {
          "title": "medicalResponse",
          "type": "string",
          "buildship": {
            "index": "0"
          }
        },
        "success": {
          "type": "boolean",
          "buildship": {
            "index": "1"
          },
          "title": "success"
        }
      },
      "buildship": {
        "index": "0"
      }
    },
    "id": "7109623e-7391-4041-a33d-6b1df67b4dc8"
  },
  {
    "output": {
      "properties": {
        "cleanedResponse": {
          "buildship": {
            "index": "0"
          },
          "type": "string",
          "title": "cleanedResponse"
        }
      },
      "type": "object",
      "buildship": {
        "index": "0"
      }
    },
    "type": "script",
    "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)",
    "meta": {
      "name": "Starter Script",
      "id": "6a78e98b-76e7-472f-80b1-f0625a3c4bf6",
      "description": "The Starter Script, as the name suggests, provides a blank node for adding custom logic to your workflow. \n\nClick the “code” button to configure the node. The Node Editor will open up. \n\n**Node Logic**  \nDefine the custom behavior of the node. This logic is typically written in JavaScript/TypeScript. \n\n**Inputs**  \nDefine the inputs for the node. Later in the workflow, you can pass in the values for these inputs. \n\n**Output**  \nSpecify the output format of the node (String, number, boolean, Array, Object, File) \n\n**Metadata**  \nInfo about the node (Name, ID, description, icon) \n\nLearn more about the Starter Script: [Docs](https://docs.buildship.com/core-nodes/script)"
    },
    "id": "da94dcb4-fa62-4c27-a358-dea9442734d3",
    "label": "Clean Medical Response",
    "inputs": {
      "properties": {
        "medicalResponse": {
          "buildship": {
            "sensitive": false,
            "index": "0",
            "defaultExpressionType": "text"
          },
          "type": "string",
          "title": "Medical Response"
        }
      },
      "required": [],
      "sections": {},
      "structure": [
        {
          "parentId": null,
          "depth": "0",
          "index": "0",
          "id": "medicalResponse"
        }
      ],
      "type": "object"
    },
    "script": "export default async function cleanMedicalResponse({\n    medicalResponse\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    try {\n        if (!medicalResponse) {\n            return { cleanedResponse: \"\" };\n        }\n        \n        let cleanedText = medicalResponse;\n        \n        // Remove markdown formatting\n        cleanedText = cleanedText.replace(/\\*\\*(.*?)\\*\\*/g, '$1'); // Remove **bold**\n        cleanedText = cleanedText.replace(/\\*(.*?)\\*/g, '$1'); // Remove *italic*\n        cleanedText = cleanedText.replace(/__(.*?)__/g, '$1'); // Remove __underline__\n        \n        // Handle escaped newlines (\\\\n) and regular newlines (\\n)\n        cleanedText = cleanedText.replace(/\\\\n/g, ' '); // Replace escaped newlines with space\n        cleanedText = cleanedText.replace(/\\n/g, ' '); // Replace regular newlines with space\n        \n        // Clean up extra spaces\n        cleanedText = cleanedText.replace(/\\s{2,}/g, ' '); // Replace multiple spaces with single space\n        cleanedText = cleanedText.trim(); // Remove leading/trailing spaces\n        \n        // Ensure proper sentence spacing\n        cleanedText = cleanedText.replace(/\\.\\s+/g, '. '); // Normalize sentence spacing\n        cleanedText = cleanedText.replace(/\\?\\s+/g, '? '); // Normalize question spacing\n        cleanedText = cleanedText.replace(/!\\s+/g, '! '); // Normalize exclamation spacing\n        \n        // Remove any remaining problematic characters\n        cleanedText = cleanedText.replace(/[^\\w\\s.,!?;:()-]/g, ''); // Keep only safe characters\n        \n        logging.log(`Original length: ${medicalResponse.length}`);\n        logging.log(`Cleaned length: ${cleanedText.length}`);\n        logging.log(`Cleaned text preview: ${cleanedText.substring(0, 200)}...`);\n        \n        return {\n            cleanedResponse: cleanedText\n        };\n        \n    } catch (error) {\n        logging.error(`Text cleaning failed: ${error.message}`);\n        return {\n            cleanedResponse: medicalResponse // Return original if cleaning fails\n        };\n    }\n}"
  },
  {
    "description": "Translate text using Spitch Translation API (api.spi-tch.com) with Bearer {{SPITCH_API_KEY}}.",
    "type": "script",
    "name": "Translate Text with Spitch",
    "plan": {
      "description": "Translate text using Spitch Translation API (api.spi-tch.com) with Bearer {{SPITCH_API_KEY}}.",
      "output": [
        {
          "id": "translatedText",
          "type": "string",
          "description": "The translated text from Spitch API.",
          "name": "Translated Text"
        },
        {
          "type": "string",
          "id": "error",
          "name": "Error Message",
          "description": "The error message if translation fails."
        }
      ],
      "name": "Translate Text with Spitch",
      "inputs": [
        {
          "_ai_instruction": "Always use the api.spi-tch.com endpoint.",
          "sampleValue": "https://api.spi-tch.com/v1/translate",
          "name": "API Endpoint",
          "description": "Spitch translation endpoint.",
          "id": "endpoint",
          "type": "string"
        },
        {
          "type": "string",
          "id": "text",
          "_ai_instruction": "Set to {{transcribe-audio.transcribedText}}.",
          "description": "Text to translate.",
          "name": "Text"
        },
        {
          "name": "Source",
          "_ai_instruction": "Set to input sourceLanguage.",
          "description": "Source language code.",
          "id": "source",
          "type": "string"
        },
        {
          "name": "Target",
          "_ai_instruction": "Set to input targetLanguage.",
          "description": "Target language code.",
          "id": "target",
          "type": "string"
        },
        {
          "type": "string",
          "id": "authorization",
          "description": "Bearer token for Spitch.",
          "name": "Authorization",
          "_ai_instruction": "Set to Bearer {{SPITCH_API_KEY}}."
        },
        {
          "sampleValue": "application/json",
          "name": "Content-Type",
          "type": "string",
          "id": "contentType",
          "description": "Content type header.",
          "_ai_instruction": "Set to 'application/json'."
        }
      ]
    },
    "id": "926cd33f-5c23-400b-afd7-898c3ec80c45",
    "output": {
      "buildship": {
        "index": "0"
      },
      "type": "object",
      "properties": {
        "translatedText": {
          "buildship": {
            "index": "0"
          },
          "type": "string",
          "title": "translatedText"
        },
        "error": {
          "buildship": {
            "index": "1"
          },
          "title": "error",
          "type": "null"
        }
      }
    },
    "inputs": {
      "required": [
        "authorization",
        "endpoint",
        "text",
        "source",
        "target"
      ],
      "type": "object",
      "properties": {
        "authorization": {
          "type": "string",
          "title": "Authorization",
          "buildship": {
            "sensitive": true,
            "index": "0",
            "userPromptHint": "Enter your Spitch API Bearer token."
          },
          "description": "Bearer token for Spitch API authentication (e.g., Bearer {{SPITCH_API_KEY}})."
        },
        "text": {
          "description": "Text to be translated.",
          "buildship": {
            "userPromptHint": "Enter the text you want to translate.",
            "index": "2"
          },
          "type": "string",
          "title": "Text"
        },
        "source": {
          "buildship": {
            "userPromptHint": "Enter the source language code.",
            "index": "3"
          },
          "type": "string",
          "title": "Source Language",
          "description": "Source language code (e.g., en, fr, de)."
        },
        "contentType": {
          "title": "Content Type",
          "type": "string",
          "description": "Content-Type header value (defaults to application/json).",
          "buildship": {
            "validationErrorMessage": "Content-Type must be a valid MIME type.",
            "index": "5",
            "userPromptHint": "Enter the Content-Type header value if different from application/json."
          }
        },
        "endpoint": {
          "description": "Spitch Translation API endpoint URL.",
          "buildship": {
            "userPromptHint": "Enter the Spitch API endpoint (e.g., https://api.spi-tch.com/translate).",
            "index": "1"
          },
          "title": "Endpoint",
          "type": "string"
        },
        "target": {
          "title": "Target Language",
          "type": "string",
          "buildship": {
            "userPromptHint": "Enter the target language code.",
            "index": "4"
          },
          "description": "Target language code (e.g., en, fr, de)."
        }
      }
    },
    "meta": {
      "name": "Translate Text with Spitch",
      "icon": {
        "type": "URL",
        "url": null
      },
      "id": "translate-text-with-spitch",
      "description": "Translate text using Spitch Translation API (api.spi-tch.com) with Bearer {{SPITCH_API_KEY}}."
    },
    "script": "export default async function spitchTranslate({\n    endpoint,\n    text,\n    source,\n    target,\n    authorization,\n    contentType\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    try {\n        // Add detailed logging\n        logging.log(`=== TRANSLATION DEBUG INFO ===`);\n        logging.log(`Source language: ${source}`);\n        logging.log(`Target language: ${target}`);\n        logging.log(`Text to translate: ${text}`);\n        logging.log(`Endpoint: ${endpoint}`);\n        \n        // Validate inputs\n        if (!text) {\n            throw new Error(\"No text provided for translation\");\n        }\n        if (!source) {\n            throw new Error(\"Source language not specified\");\n        }\n        if (!target) {\n            throw new Error(\"Target language not specified\");\n        }\n        \n        // Skip translation if source and target are the same\n        if (source === target) {\n            logging.log(\"Source and target languages are the same, skipping translation\");\n            return {\n                translatedText: text, // Return original text unchanged\n                error: null\n            };\n        }\n        \n        // Prepare request payload\n        const payload = {\n            text,\n            source: source,\n            target: target\n        };\n        \n        // Make the API request\n        logging.log(`Making translation request from ${source} to ${target}`);\n        const response = await fetch(endpoint, {\n            method: 'POST',\n            headers: {\n                'Authorization': authorization,\n                'Content-Type': contentType || 'application/json'\n            },\n            body: JSON.stringify(payload)\n        });\n        \n        const data = await response.json();\n        logging.log(`Translation API response:`, JSON.stringify(data));\n        \n        // Check for API errors\n        if (!response.ok) {\n            throw new Error(data.message || `API error: ${response.status} ${response.statusText}`);\n        }\n        \n        // Return the translated text\n        const translatedResult = data.translated_text || data.translation || data.text;\n        logging.log(`Final translated text: ${translatedResult}`);\n        \n        return {\n            translatedText: translatedResult,\n            error: null\n        };\n        \n    } catch (error) {\n        // Log and return the error\n        logging.error(`Translation error: ${error.message}`);\n        return {\n            translatedText: text, // Return original text if translation fails\n            error: error.message\n        };\n    }\n}",
    "label": "Translate Response Back to User Language"
  },
  {
    "script": "export default async function selectSpitchVoice({\n    targetLanguage\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    // Map of language codes to Spitch voice names\n    const languageToVoiceMap = {\n        'en': 'lucy',      \n        'yo': 'sade',      \n        'ha': 'amina',     \n        'ig': 'ngozi',     \n        'am': 'hana',      \n        'ti': 'selam'      \n    };\n    \n    // Default to English lucy if language not found\n    const defaultVoice = 'lucy';\n    \n    // Get the voice for the target language, defaulting if not found\n    const selectedVoice = languageToVoiceMap[targetLanguage] || defaultVoice;\n    \n    logging.log(`Selected voice \"${selectedVoice}\" for language code \"${targetLanguage}\"`);\n    \n    // Return just the string, not an object\n    return selectedVoice;\n}",
    "inputs": {
      "type": "object",
      "properties": {
        "targetLanguage": {
          "buildship": {
            "index": "0",
            "userPromptHint": "Enter the target language code (e.g., 'en', 'fr', 'es')."
          },
          "type": "string",
          "title": "Target Language",
          "description": "The language code for which to select the Spitch voice."
        }
      },
      "required": [
        "targetLanguage"
      ]
    },
    "type": "script",
    "meta": {
      "description": "Selects the correct Spitch voice name for the target language. Never returns 'auto'.",
      "icon": {
        "type": "URL",
        "url": null
      },
      "id": "select-voice-for-synthesis",
      "name": "Select Voice for Synthesis"
    },
    "plan": {
      "output": [
        {
          "id": "voice",
          "description": "The correct voice for the language (never 'auto').",
          "name": "Voice",
          "type": "string"
        }
      ],
      "description": "Selects the correct Spitch voice name for the target language. Never returns 'auto'.",
      "inputs": [
        {
          "name": "Target Language",
          "description": "The target language code.",
          "_ai_instruction": "Set to input targetLanguage.",
          "type": "string",
          "id": "targetLanguage"
        }
      ],
      "name": "Select Voice for Synthesis"
    },
    "id": "10bbb0ce-10d6-4d2c-b336-3ca2b69a40c9",
    "label": "Select Voice for Synthesis",
    "description": "Selects the correct Spitch voice name for the target language. Never returns 'auto'.",
    "output": {
      "buildship": {
        "index": "0"
      },
      "description": "The Spitch voice identifier selected based on the target language code.",
      "type": "string",
      "title": "Selected Voice"
    }
  },
  {
    "type": "script",
    "label": "Synthesize Speech with Spitch",
    "id": "c501951c-0d3f-4e37-9480-6770735f2be3",
    "inputs": {
      "required": [
        "authorization",
        "endpoint",
        "text",
        "language",
        "voice",
        "contentType"
      ],
      "type": "object",
      "properties": {
        "language": {
          "buildship": {
            "index": "3",
            "userPromptHint": "Enter the language code (e.g., en-US)"
          },
          "type": "string",
          "title": "Language",
          "description": "Language code for the speech synthesis (e.g., en-US)"
        },
        "authorization": {
          "description": "Bearer token for Spitch API (e.g., Bearer {{SPITCH_API_KEY}})",
          "title": "Authorization",
          "buildship": {
            "index": "0",
            "sensitive": true,
            "userPromptHint": "Enter your Spitch API Bearer token"
          },
          "type": "string"
        },
        "voice": {
          "type": "string",
          "title": "Voice",
          "description": "Voice identifier for the speech synthesis",
          "buildship": {
            "userPromptHint": "Enter the voice identifier",
            "index": "4"
          }
        },
        "text": {
          "description": "Text to synthesize into speech",
          "type": "string",
          "buildship": {
            "userPromptHint": "Enter the text you want to convert to speech",
            "index": "2"
          },
          "title": "Text"
        },
        "endpoint": {
          "buildship": {
            "userPromptHint": "Enter the Spitch API endpoint URL",
            "index": "1"
          },
          "title": "Endpoint",
          "description": "Spitch API endpoint URL",
          "type": "string"
        },
        "contentType": {
          "description": "Content-Type header value (e.g., application/json)",
          "type": "string",
          "title": "Content Type",
          "buildship": {
            "index": "5",
            "userPromptHint": "Enter the Content-Type header value"
          }
        }
      }
    },
    "meta": {
      "id": "synthesize-speech-with-spitch",
      "name": "Synthesize Speech with Spitch",
      "icon": {
        "type": "URL",
        "url": null
      },
      "description": "Synthesize the final text to speech using Spitch API and return audio as base64. Uses Bearer {{SPITCH_API_KEY}} and selected voice."
    },
    "output": {
      "buildship": {
        "index": "0"
      },
      "properties": {
        "error": {
          "type": "null",
          "buildship": {
            "index": "1"
          },
          "title": "error"
        },
        "audioBase64": {
          "type": "string",
          "buildship": {
            "index": "0"
          },
          "title": "audioBase64"
        }
      },
      "type": "object"
    },
    "script": "export default async function spitchTextToSpeech({\n    endpoint,\n    text,\n    language,\n    voice,\n    authorization,\n    contentType\n}: NodeInputs, {\n    logging\n}: NodeScriptOptions) {\n    try {\n        logging.log(`Synthesizing text to speech with Spitch API...`);\n        logging.log(`Text: ${text.substring(0, 100)}${text.length > 100 ? '...' : ''}`);\n        logging.log(`Voice: ${voice}`);\n        logging.log(`Language: ${language}`);\n\n        const requestBody = {\n            text,\n            voice,\n            language\n        };\n\n        const response = await fetch(endpoint, {\n            method: 'POST',\n            headers: {\n                'Authorization': authorization,\n                'Content-Type': contentType\n            },\n            body: JSON.stringify(requestBody)\n        });\n\n        if (!response.ok) {\n            const errorData = await response.text();\n            logging.log(`Error from Spitch API: ${response.status} ${response.statusText}`);\n            logging.log(`Error details: ${errorData}`);\n            return {\n                audioBase64: null,\n                error: `Spitch API error: ${response.status} ${response.statusText} - ${errorData}`\n            };\n        }\n\n        // Get the audio data as an ArrayBuffer\n        const audioBuffer = await response.arrayBuffer();\n\n        // Convert ArrayBuffer to Base64\n        const base64Audio = Buffer.from(audioBuffer).toString('base64');\n\n        logging.log(`Successfully synthesized speech, returning base64 audio`);\n\n        return {\n            audioBase64: base64Audio,\n            error: null\n        };\n    } catch (error) {\n        logging.log(`Exception occurred during text-to-speech synthesis: ${error.message}`);\n        return {\n            audioBase64: null,\n            error: `Failed to synthesize speech: ${error.message}`\n        };\n    }\n}",
    "plan": {
      "name": "Synthesize Speech with Spitch",
      "inputs": [
        {
          "sampleValue": "https://api.spi-tch.com/v1/speech",
          "description": "Spitch TTS endpoint.",
          "_ai_instruction": "Always use the api.spi-tch.com endpoint.",
          "id": "endpoint",
          "type": "string",
          "name": "API Endpoint"
        },
        {
          "description": "Text to synthesize.",
          "_ai_instruction": "Set to {{merge-text.finalText}}.",
          "type": "string",
          "name": "Text",
          "id": "text"
        },
        {
          "name": "Language",
          "_ai_instruction": "Set to input targetLanguage.",
          "type": "string",
          "id": "language",
          "description": "Target language code for TTS."
        },
        {
          "id": "voice",
          "description": "Voice name for TTS.",
          "type": "string",
          "name": "Voice",
          "_ai_instruction": "Set to {{select-voice.voice}}."
        },
        {
          "_ai_instruction": "Set to Bearer {{SPITCH_API_KEY}}.",
          "name": "Authorization",
          "description": "Bearer token for Spitch.",
          "type": "string",
          "id": "authorization"
        },
        {
          "sampleValue": "application/json",
          "description": "Content type header.",
          "name": "Content-Type",
          "type": "string",
          "_ai_instruction": "Set to 'application/json'.",
          "id": "contentType"
        }
      ],
      "output": [
        {
          "name": "Audio Base64",
          "description": "The output synthesized audio in base64.",
          "type": "string",
          "id": "audioBase64"
        },
        {
          "name": "Error Message",
          "description": "The error message if synthesis fails.",
          "id": "error",
          "type": "string"
        }
      ],
      "description": "Synthesize the final text to speech using Spitch API and return audio as base64. Uses Bearer {{SPITCH_API_KEY}} and selected voice."
    },
    "description": "Synthesize the final text to speech using Spitch API and return audio as base64. Uses Bearer {{SPITCH_API_KEY}} and selected voice."
  },
  {
    "inputs": {
      "properties": {
        "fileName": {
          "description": "The name of the output file along with the file extension. (For Example: `output.png`)",
          "properties": {},
          "type": "string",
          "buildship": {
            "index": "1",
            "placeholder": "/folder-path/output.png",
            "sensitive": false
          },
          "title": "File Name"
        },
        "base64": {
          "type": "string",
          "title": "Base64 File",
          "properties": {},
          "buildship": {
            "sensitive": false,
            "placeholder": "data:image/png;base64,iVBORw0KGgoAAAANS...",
            "index": "0"
          },
          "description": "The Base64 string of the file to upload."
        }
      },
      "type": "object",
      "required": [
        "base64",
        "fileName"
      ]
    },
    "src": "https://storage.googleapis.com/buildship-app-us-central1/publicLib/nodesV2/@buildship/buildship-gcp-storage-upload-base64/5.0.0/build.cjs",
    "version": "5.0.0",
    "script": "import { Storage } from '@google-cloud/storage';\n\nexport default async function uploadBase64ToGcpStorage(\n  { base64, fileName }: NodeInputs,\n  { logging }: NodeScriptOptions\n) {\n  \n  try {\n    if (!base64 || !fileName) {\n      return { publicUrl: null, error: 'Missing inputs' };\n    }\n    \n    logging.log(`Base64 length: ${base64.length}`);\n    \n    // Handle base64 data\n    let base64Data = base64;\n    if (base64.includes(';base64,')) {\n      base64Data = base64.split(';base64,').pop();\n    } else if (base64.includes(',')) {\n      base64Data = base64.split(',').pop();\n    }\n    \n    const storage = new Storage();\n    const bucket = storage.bucket(process.env.BUCKET);\n    const file = bucket.file(fileName);\n    \n    // Use resumable upload for large files\n    const options = {\n      resumable: true, // Changed to true for large files\n      contentType: 'audio/mpeg',\n      public: true,\n      timeout: 300000, // 5 minute timeout\n    };\n    \n    const buffer = Buffer.from(base64Data, 'base64');\n    logging.log(`Buffer size: ${buffer.length} bytes`);\n    \n    await file.save(buffer, options);\n    \n    const publicUrl = `https://storage.googleapis.com/${bucket.name}/${file.name}`;\n    logging.log(`Upload successful: ${publicUrl}`);\n    \n    return { publicUrl };\n    \n  } catch (error) {\n    logging.error('Upload failed:', error);\n    return { publicUrl: null, error: error.message };\n  }\n}",
    "_groupInfo": {
      "description": "Nodes for storing your files in the built-in BuildShip Storage",
      "name": "BuildShip File Storage",
      "iconUrl": "https://firebasestorage.googleapis.com/v0/b/website-a1s39m.appspot.com/o/buildship-app-logos%2FIcon.png?alt=media&token=878ed11b-1cf2-45d8-9951-7e95a16d26af&_gl=1*1ld9l67*_ga*NzgyMDk5NjMxLjE2OTY4NzE3ODU.*_ga_CW55HF8NVT*MTY5NjkyMzc5OC4yLjEuMTY5NjkyMzgzMy4yNS4wLjA.",
      "uid": "buildship-file-storage"
    },
    "type": "script",
    "groupInfo": "0IAjU2tekQHjibkvicpD",
    "_libRef": {
      "libType": "public",
      "buildHash": "c8b3e3e7d67d74bf590bd72b2687c34d8f8ebd06f85072c3431b8aec3cf22ecd",
      "src": "https://storage.googleapis.com/buildship-app-us-central1/publicLib/nodesV2/@buildship/buildship-gcp-storage-upload-base64/5.0.0/build.cjs",
      "libNodeRefId": "@buildship/buildship-gcp-storage-upload-base64",
      "integrity": "v3:f7e21341f08a6999c9986bc8656455c1",
      "version": "5.0.0",
      "isDirty": true
    },
    "integrity": "v3:f7e21341f08a6999c9986bc8656455c1",
    "id": "5a085e0a-807a-49b2-804f-99feba62dd86",
    "dependencies": {
      "stream": "0.0.2",
      "@google-cloud/storage": "7.6.0"
    },
    "output": {
      "buildship": {
        "index": "0"
      },
      "type": "object",
      "properties": {
        "publicUrl": {
          "title": "publicUrl",
          "format": "uri",
          "buildship": {
            "index": "0"
          },
          "type": "string"
        }
      }
    },
    "label": "Upload Synthesized Audio to Storage",
    "integrations": [],
    "meta": {
      "id": "buildship-gcp-storage-upload-base64",
      "name": "Upload Base64 File",
      "description": "Uploads a Base64 file to BuildShip's in-built Google Cloud Storage Bucket and returns the public URL",
      "icon": {
        "type": "URL",
        "url": "https://firebasestorage.googleapis.com/v0/b/website-a1s39m.appspot.com/o/buildship-app-logos%2FIcon.png?alt=media&token=878ed11b-1cf2-45d8-9951-7e95a16d26af&_gl=1*1ld9l67*_ga*NzgyMDk5NjMxLjE2OTY4NzE3ODU.*_ga_CW55HF8NVT*MTY5NjkyMzc5OC4yLjEuMTY5NjkyMzgzMy4yNS4wLjA."
      }
    }
  },
  {
    "inputs": {
      "structure": [
        {
          "depth": "0",
          "parentId": null,
          "index": "0",
          "id": "transcribedText"
        },
        {
          "id": "medicalResponse",
          "depth": "0",
          "index": "1",
          "parentId": null
        },
        {
          "index": "2",
          "parentId": null,
          "id": "audioUrl",
          "depth": "0"
        },
        {
          "parentId": null,
          "index": "3",
          "depth": "0",
          "id": "sourceLanguage"
        }
      ],
      "required": [
        "file"
      ],
      "sections": {},
      "properties": {
        "audioUrl": {
          "buildship": {
            "defaultExpressionType": "text",
            "sensitive": false,
            "index": "2"
          },
          "title": "Audio Url",
          "type": "string"
        },
        "sourceLanguage": {
          "title": "Source Language",
          "buildship": {
            "defaultExpressionType": "text",
            "index": "3",
            "sensitive": false
          },
          "type": "string"
        },
        "medicalResponse": {
          "title": "Medical Response",
          "type": "string",
          "buildship": {
            "index": "1",
            "sensitive": false,
            "defaultExpressionType": "text"
          }
        },
        "transcribedText": {
          "buildship": {
            "sensitive": false,
            "defaultExpressionType": "text",
            "index": "0"
          },
          "type": "string",
          "title": "Transcribed Text"
        }
      },
      "type": "object"
    },
    "type": "script",
    "label": "Build Output JSON",
    "output": {
      "buildship": {}
    },
    "plan": {
      "description": "Construct the output JSON as specified.",
      "name": "Build Output JSON",
      "output": [
        {
          "description": "Final structured output.",
          "id": "outputJson",
          "type": "object",
          "name": "Output JSON"
        }
      ],
      "inputs": [
        {
          "type": "string",
          "_ai_instruction": "Set to {{transcribe-audio.transcribedText}}.",
          "name": "Transcribed Text",
          "id": "transcribedText",
          "description": "The transcribed text."
        },
        {
          "description": "The translated text (may be same as transcribedText if no translation needed).",
          "type": "string",
          "id": "translatedText",
          "_ai_instruction": "Use {{merge-text.finalText}}.",
          "name": "Translated Text"
        },
        {
          "description": "Public URL to the synthesized audio.",
          "id": "audioUrl",
          "type": "string",
          "_ai_instruction": "Set to {{upload-output-audio.finalAudioUrl}}.",
          "name": "Audio URL"
        },
        {
          "id": "sourceLanguage",
          "type": "string",
          "name": "Source Language",
          "_ai_instruction": "Set to input sourceLanguage.",
          "description": "Source language code."
        },
        {
          "name": "Target Language",
          "_ai_instruction": "Set to input targetLanguage.",
          "type": "string",
          "id": "targetLanguage",
          "description": "Target language code."
        }
      ]
    },
    "id": "ce5e43fd-fca6-4ce4-9178-886c5cec2bb7",
    "description": "Construct the output JSON as specified.",
    "meta": {
      "id": "build-output-json",
      "name": "Build Output JSON",
      "icon": {
        "type": "URL",
        "url": null
      },
      "description": "Construct the output JSON as specified."
    },
    "script": "export default async function constructOutputJson({\n    transcribedText,\n    medicalResponse,\n    audioUrl,\n    sourceLanguage\n}: NodeInputs) {\n    // Create the output JSON object for medical Q&A\n    const outputJson = {\n        success: true,\n        transcribedText,\n        translatedText: medicalResponse, // Medical response in user's language\n        audioUrl,\n        sourceLanguage,\n        targetLanguage: sourceLanguage // Same as source for Q&A\n    };\n    \n    return {\n        outputJson\n    };\n}"
  },
  {
    "label": "Outputs",
    "id": "67567c20-ac80-46aa-8234-b9c096ac81b6",
    "type": "output",
    "description": ""
  }
]