# BuildShip

This repository includes your workflows, converted into TypeScript functions. Each workflow is represented as a separate function and exported from `src/<workflowName>/index.ts`.

**Note:** The conversion process may not be flawless, and the resulting function might not behave as expected.

## Usage Guide

### Building the Project

Run the following command to build the project:

```bash
npm run build
```

You might encounter TypeScript-related errors in files under `src/buildship/*.ts`. These errors can be safely ignored, as they do not prevent the build process from completing.

### Executing a Workflow

To execute a workflow, create a new file and utilize the `executeWorkflow` utility:

```typescript
import { executeWorkflow } from "./utils.js";

const output = await executeWorkflow("workflowName", {
  input1: "value1",
  input2: "value2",
  // ... additional inputs
});
```

- Each exported workflow is assigned a unique camelCase name derived from the workflow's original name. Refer to the `src/` directory to see the available workflows.
- The second parameter is an object containing the workflow's input values. Ensure the keys align with the workflow's expected input keys.
