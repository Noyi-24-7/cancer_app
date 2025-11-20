export type CallToolResult = never;

export async function executeTool(): Promise<CallToolResult> {
  throw new Error("Local BuildShip tool execution is disabled in this deployment.");
}
