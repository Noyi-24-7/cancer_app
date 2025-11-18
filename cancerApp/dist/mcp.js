import "dotenv/config";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { executeTool } from "./buildship/execute-tool.js";
import { z } from "zod";
const server = new McpServer({ name: "cancerApp", version: "1.0.0" });
server.tool("voiceTranslationRestApi", "The Tool Trigger creates an API endpoint that your Agent can use to perform specific tasks. When the Agent detects a request that matches the tool\u2019s function, it automatically triggers the API, sends the necessary inputs, and processes the response.", { sourceLanguage: z.string().describe("The language code of the input audio (en, yo, ha, ig)."), audioFile: z.string().describe("The input audio file as a base64-encoded string."), conversationHistory: z.string().regex(new RegExp("")).default("[]") }, async (inputs) => { return await executeTool("cancerApp", inputs); });
const transport = new StdioServerTransport();
await server.connect(transport);
