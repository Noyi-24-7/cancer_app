export type CallToolResult = never;

export async function executeToolProxy(): Promise<CallToolResult> {
  throw new Error("Remote BuildShip tool execution is disabled in this deployment.");
}
