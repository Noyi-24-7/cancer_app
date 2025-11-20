# Educational Content Processor – BuildShip ➜ Vercel Plan

## 0. Current State

- BuildShip export is available at `/Users/noyi/Downloads/cancer_app/educationalContentProcessor`.
- Workflow entry point is `src/educationalContentProcessor/index.ts`; it orchestrates validation, translation, optional audio generation, and response building.
- Audio generation script still targets Google Cloud Storage via the `BUCKET` env variable and `@google-cloud/storage` client (see `scripts/1a413c23-58cb-4ca2-9a17-6e06e8812f28.cjs`).
- Secrets required so far: `SPITCH_API_KEY` for translation + TTS, `BUCKET` for storage (to be replaced with Vercel Blob).

## 1. Create the Vercel/Next.js Project

```bash
cd /Users/noyi/Downloads/preggos/pregnancy-voice-assistant-ku850b
npx create-next-app@latest educational-content-api --typescript --app --no-src-dir
cd educational-content-api
```

Project root will host `app/api/process-articles/route.ts`.

## 2. Bring the BuildShip Runtime into the Next App

1. Copy the exported runtime folders:
   - `educationalContentProcessor/src/buildship` ➜ `educational-content-api/lib/buildship`
   - `educationalContentProcessor/src/educationalContentProcessor` ➜ `lib/educationalContentProcessor`
   - `educationalContentProcessor/scripts` ➜ `lib/scripts`
2. Update TypeScript paths if desired via `tsconfig.json` (`"paths": { "@buildship/*": ["lib/buildship/*"] }`).
3. Replace `process.cwd()`-based imports inside the copied runtime using direct relative paths (mirrors the pattern documented in `preggos/pregnancy-voice-assistant-ku850b/cancer-app-api`).

## 3. Expose the Execute Function as a Next.js Route

Create `app/api/process-articles/route.ts`:

```ts
export const runtime = "nodejs";
export const maxDuration = 60;

const workflow = createEducationalContentProcessor({
  scriptsDir: path.join(process.cwd(), "lib/scripts"),
});

export async function POST(req: NextRequest) {
  const payload = await req.json();
  const root = {};
  const result = await workflow(payload, root);
  return NextResponse.json(result);
}
```

Key differences from the exported runner:

- Convert the default export (`execute(inputs, root)`) into a function factory so each request runs in isolation.
- Surface validation errors as `return NextResponse.json({ success: false, error: message }, { status: 400 })`.
- Add a simple `GET` handler for health checks.

## 4. Fix Workflow Logic Before Shipping

1. **Branch conditions** – the BuildShip export uses `===` with `&&`, so both strings must match simultaneously:

```66:81:educationalContentProcessor/src/educationalContentProcessor/index.ts
    if (root[NODES.validateAndPrepareArticles]["action"] === "translate_only" && root[NODES.validateAndPrepareArticles]["action"] === "translate_and_audio") {
        await branch_then(root);
    } else {
        await branch_else(root);
    }
```

Replace both `&&` occurrences with `||` so each branch triggers correctly.

2. **Throw "STOP"** – remove the `throw "STOP";` at the end of `execute` and return `root[NODES.buildFinalResponse]` instead. This ensures the HTTP response resolves properly inside Vercel.

## 5. Replace Google Cloud Storage With Vercel Blob

The audio node currently imports `@google-cloud/storage` and depends on `BUCKET`:

```742:813:educationalContentProcessor/src/educationalContentProcessor/nodes.ts
import { Storage } from '@google-cloud/storage';
...
const bucketName = process.env.BUCKET;
const storage = new Storage();
...
const bucket = storage.bucket(bucketName);
const file = bucket.file(key);
await file.save(audioBuffer, { ... });
const publicUrl = `https://storage.googleapis.com/${bucket.name}/${file.name}`;
```

Steps:

1. Create `lib/storage/vercel-blob.ts` in the Next app with helpers that call `@vercel/blob`’s `put` and `del`.
2. Replace the GCS block with:
   ```ts
   const { url } = await uploadFileToBlob({
     fileName: key,
     buffer: audioBuffer,
     contentType: mime,
   });
   article.audioUrl = url;
   ```
3. Remove `@google-cloud/storage` from `package.json` and install `@vercel/blob`.
4. Delete `BUCKET` env usage—Vercel injects `BLOB_READ_WRITE_TOKEN` once the Blob store is attached (Dashboard → Storage → Blob → Connect Project).

## 6. Dependencies & Scripts

- Use the dependency list from the previous migration (`next`, `react`, `react-dom`, `p-map`, `lodash-es`, `uuid`, `zod`, `@vercel/blob`, `dotenv`).
- Add `"build": "next build --webpack"` plus an empty `turbopack` config in `next.config.ts` to avoid BuildShip’s webpack plugins from breaking builds.

## 7. Environment Variables

| Name              | Purpose                                | Notes                                    |
|-------------------|----------------------------------------|------------------------------------------|
| `SPITCH_API_KEY`  | Translation + TTS                      | Required in all environments             |
| `BLOB_READ_WRITE_TOKEN` | Managed by Vercel Blob store    | Auto-added when store is connected       |
| `NEXT_PUBLIC_API_BASE` (optional) | Client usage          | Configure if the Flutter app calls Vercel |

Create `.env.local` for dev and add the same variables in Vercel → Settings → Environment Variables.

## 8. Testing Matrix

1. **Unit** – run `ts-node` or a simple `node scripts/manual-test.mjs` to call `execute` with fixture data.
2. **API** – `curl -X POST http://localhost:3000/api/process-articles` with the JSON payload that matches `validateArticleProcessingInput`.
3. **Production** – re-run the `curl` test against `https://<project>.vercel.app/api/process-articles`.

## 9. Deployment Checklist

- [ ] `npm run lint && npm run build`
- [ ] Attach Blob store & confirm token injection
- [ ] Push to GitHub and import the repo into Vercel (Root Directory = `educational-content-api`)
- [ ] Monitor first deployment logs for bundling errors
- [ ] Add observability (e.g., `console.error` → Vercel logs, optional Sentry later)

Once deployed, record the production endpoint for the Flutter app and update any `.env` or backend configs that previously targeted BuildShip.

