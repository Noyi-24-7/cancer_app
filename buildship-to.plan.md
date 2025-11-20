<!-- bc8e2712-9625-40c7-b8cb-e978a71b9c70 f1947a59-a65e-4409-9552-8f44603a4c99 -->
# BuildShip to Vercel Migration Plan - COMPLETED ✅

## Overview

Successfully migrated a BuildShip audio processing workflow to a self-hosted Next.js API on Vercel. The workflow processes audio files (transcription, translation, medical question processing with Gemma AI, speech synthesis) and stores files using Vercel Blob Storage instead of Google Cloud Storage.

## Step 1: Export BuildShip Workflow ✅

Run the provided BuildShip export command to generate the Node.js function code:

```bash
npx -y buildship-tools export-as-function --project buildship-1pz4ke --flows R8KBjp6t84zccX60Jkyl --outputFolder cancerApp --token eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ1YTZjMGMyYjgwMDcxN2EzNGQ1Y2JiYmYzOWI4NGI2NzYxMjgyNjUiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWRpbm95aSBJc21haWxhIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0tESGp3ZEgzSGJUQkF5bml1b08yWFFMRy1xT19HZFFlYllXU0ttTUdVajliX1BGZz1zOTYtYyIsInByb2plY3RzIjp7ImJ1aWxkc2hpcC0xcHo0a2UiOnsicm9sZSI6Im93bmVyIn19LCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYnVpbGRzaGlwLWFwcCIsImF1ZCI6ImJ1aWxkc2hpcC1hcHAiLCJhdXRoX3RpbWUiOjE3NjE2MzQ4MDAsInVzZXJfaWQiOiJJajM1ek50VmhaUzNYMUxNb040UGx3allyUkczIiwic3ViIjoiSWozNXpOdFZoWlMzWDFMTW9ONFBsd2pZclJHMyIsImlhdCI6MTc2MzQwNjcxNSwiZXhwIjoxNzYzNDEwMzE1LCJlbWFpbCI6Im5veWlpc21haWxhQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTAwMjEyMTExNzgzMjg4MTU1ODQzIl0sImVtYWlsIjpbIm5veWlpc21haWxhQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.JBmT0HfZV0H_Zt9q-zfrJk4uDJ_IrNPLeq4cnul7zn6gP7-A5CS-HmP2C8CXmdPuSpOt7vWj_n-5eU8YWL8U5bn1kvE_YPjpqr_en1U007bgkptMke-F5FCC6nlEuSVvae6-zDHxXs7n7zp_FaZlt6z0IyQEe9Tky17optIu6syoKbVgNHCRsqGHlgxht1VpBtiIwX82xG7cOIsuSUCU73d273cLakq4uwsYQ6S7SbligeQiWACYkntGFVAJ9NAb3IblTfnEM8RRMX3PAgobggGwbgfO_6MkdtXFWWR9S48FFkg-30VdOaeeclVyfaaPgcLW9DZLrpqxmbJnUY-Ig
```

**Result:** Created a `cancerApp` folder with the exported workflow code including:
- Main entry point (`index.ts`) with `execute` function
- Individual script files for each workflow node (`.cjs` files)
- Node definitions and workflow structure

## Step 2: Examine Exported Code Structure ✅

The exported workflow included:
- **Entry Point**: `cancerApp/index.ts` with `execute(inputs, root)` function signature
- **Dependencies**: `dotenv`, `p-map`, `lodash-es`, `uuid`, `zod`, `acorn`
- **Environment Variables**: API keys for Spitch, Gemma, Zamzar, and storage
- **File Handling**: Base64 audio file uploads via data URLs
- **External Services**: 
  - Spitch API (transcription, translation, speech synthesis)
  - Gemma AI (medical question processing)
  - Zamzar API (audio format conversion M4A → MP3)
  - Storage (originally Google Cloud Storage)

## Step 3: Create Next.js Project for Vercel ✅

Created a new Next.js project:

```bash
npx create-next-app@latest cancer-app-api --typescript --app --no-src-dir
cd cancer-app-api
```

**Location**: `/Users/noyi/Downloads/preggos/pregnancy-voice-assistant-ku850b/cancer-app-api/`

## Step 4: Adapt Exported Code to Next.js API Routes ✅

**Created**: `app/api/process-audio/route.ts`

Key adaptations:
- Converted BuildShip `execute` function to Next.js POST route handler
- Accepts JSON payload with base64 audio file: `{ audioFile: "data:audio/m4a;base64,...", sourceLanguage: "en", conversationHistory: [] }`
- Returns JSON response with `success`, `translatedText`, `audioUrl`, `transcribedText`, etc.
- Added proper error handling with try/catch blocks
- Health check GET endpoint for API status

**Important**: The route uses `export const runtime = 'nodejs'` and `export const maxDuration = 60` for serverless function configuration.

## Step 5: Configure Dependencies ✅

**Final `package.json` dependencies:**
```json
{
  "dependencies": {
    "@vercel/blob": "^2.0.0",
    "dotenv": "^16.4.7",
    "lodash-es": "^4.17.21",
    "next": "16.0.3",
    "p-map": "^7.0.3",
    "react": "19.2.0",
    "react-dom": "19.2.0",
    "uuid": "^11.1.0",
    "zod": "^3.24.2"
  },
  "optionalDependencies": {
    "@modelcontextprotocol/sdk": "^1.22.0",
    "encoding": "^0.1.13"
  }
}
```

**Key Changes:**
- ❌ Removed: `@google-cloud/storage`, `@google-cloud/firestore` (migrated to Vercel Blob)
- ✅ Added: `@vercel/blob` for storage
- ✅ Kept: BuildShip utilities dependencies (`p-map`, `lodash-es`, `uuid`, `zod`)

**Build Script:**
```json
"build": "next build --webpack"
```
Explicitly uses webpack instead of Turbopack due to compatibility requirements.

## Step 6: Set Up Environment Variables ✅

### API Keys (Used in Production):

```
SPITCH_API_KEY=sk_rK4cVeU8LfNHZMID6py7cRIDTWFg8x85GY3ab0FG
GEMMA_API_KEY=AIzaSyDTK7HZCCdb_oex2Sc7g8zZysZlI6shJCY
ZAMZAR_API_KEY=3e3883191f7fec54040c031eaed3bbe9bcfe748d
```

**Note**: The `BLOB_READ_WRITE_TOKEN` is automatically provided by Vercel when you connect a Blob store to your project (see Step 9).

### Environment Variable Configuration:

1. **Local Development**: Create `.env.local` with all keys
2. **Vercel Production**: Add via Dashboard → Settings → Environment Variables
   - Set for: Production, Preview, and Development environments
   - **Important**: Must redeploy after adding environment variables

### Files Created:
- `.env.example` - Template without actual values
- `.env.local` - Local development variables (git-ignored)

## Step 7: Configure Vercel Settings ✅

**Created `vercel.json`:**
```json
{
  "functions": {
    "app/api/process-audio/route.ts": {
      "maxDuration": 60,
      "memory": 1024
    }
  }
}
```

**Configuration Details:**
- **maxDuration**: 60 seconds (Hobby plan limit, can be up to 300s on Pro)
- **memory**: 1024 MB for audio processing operations
- **Runtime**: Explicitly set to `nodejs` in route.ts

## Step 8: Handle File Storage Migration ✅

### Original Plan: Google Cloud Storage
The exported BuildShip code used Google Cloud Storage for file uploads.

### Solution: Migrated to Vercel Blob Storage

**Created**: `lib/storage/vercel-blob.ts` with utility functions:
- `uploadFileToVercelBlob(fileName, base64Data, contentType)` - Upload files
- `deleteFileFromVercelBlob(url)` - Delete files

**Updated Scripts:**
- `scripts/upload-audio-vercel.cjs` - Upload input audio
- `scripts/download-reupload-vercel.cjs` - Download converted MP3 and re-upload
- `scripts/upload-synthesized-vercel.cjs` - Upload final synthesized audio

**Benefits:**
- ✅ No external storage setup required
- ✅ Automatic CDN distribution
- ✅ Integrated with Vercel project
- ✅ Simple API (`@vercel/blob` package)

### File Size Handling:
- Base64 encoded audio sent in JSON request body
- Vercel limit: 4.5MB request body (Hobby), 4.5MB for Pro
- For larger files, consider client-side compression or chunked uploads

## Step 9: Configure Vercel Blob Storage ✅

### Setup Steps:

1. **Create Blob Store:**
   - Go to Vercel Dashboard → Project → Storage tab
   - Click "Create Database" or "Create Store"
   - Select "Blob"
   - Name: "cancer-app-storage" (or your preferred name)
   - Click "Create"

2. **Connect to Project:**
   - After creating, click "Connect Project"
   - Select project: `cancer-app`
   - Select environments: Production, Preview, Development
   - Click "Connect"

3. **Automatic Token:**
   - Vercel automatically adds `BLOB_READ_WRITE_TOKEN` environment variable
   - No manual configuration needed
   - Token is automatically available to your serverless functions

## Step 10: Build Configuration Issues & Solutions ✅

### Problem 1: Turbopack/Webpack Conflict

**Error:**
```
As of Next.js 16 Turbopack is enabled by default and
custom webpack configurations may need to be migrated to Turbopack.
ERROR: This build is using Turbopack, with a `webpack` config and no `turbopack` config.
```

**Solution:**
1. Added empty `turbopack: {}` config to `next.config.ts`:
   ```typescript
   const nextConfig: NextConfig = {
     turbopack: {},
     webpack: (config) => {
       config.resolve.fallback = { ...config.resolve.fallback, encoding: false };
       return config;
     }
   };
   ```

2. Explicitly set build to use webpack in `package.json`:
   ```json
   "build": "next build --webpack"
   ```

**Files Modified:**
- `next.config.ts`
- `package.json`

### Problem 2: Module Path Resolution in Serverless Environment

**Error:**
```
Cannot find module '/var/task/cancer-app-api/scripts/nodes'
```

**Root Cause:** Dynamic path construction using `process.cwd()` and `path.join()` doesn't work reliably in Vercel's serverless environment.

**Solution:**
1. Changed imports to use direct relative paths:
   ```typescript
   // In lib/buildship/utils.ts
   const { nodes } = await import("../cancerApp/nodes");
   
   // In lib/buildship/http.ts  
   const { nodes } = await import("../cancerApp/nodes");
   ```

2. Removed dependency on `workflowDirectory` parameter for node imports

**Files Modified:**
- `lib/buildship/utils.ts`
- `lib/buildship/http.ts`
- `lib/cancerApp/index.ts`

### Problem 3: CommonJS Module Import Structure

**Error:**
```
"e is not a function"
```

**Root Cause:** Scripts use CommonJS (`module.exports`), but we were double-destructuring the import:
```typescript
const { default: { default: script } } = await import(...);
```

**Solution:**
Changed to proper CommonJS import:
```typescript
const scriptModule = await import(`../../scripts/${nodeId}.cjs`);
const script = scriptModule.default;
```

**Files Modified:**
- `lib/buildship/utils.ts`

### Problem 4: Undefined Node Reference

**Error:**
```
Cannot read properties of undefined (reading 'finalText')
```

**Root Cause:** Workflow referenced a non-existent node ID:
```typescript
root["a2ca7e6a-459f-4fa9-88aa-9452b495fcad"]["finalText"]
```

**Solution:**
Replaced with correct node reference:
```typescript
root[NODES.translateResponseBackToUserLanguage]["translatedText"]
```

**Files Modified:**
- `lib/cancerApp/index.ts`

### Problem 5: Google Cloud Storage Dependencies

**Error:**
```
Type error: Cannot find module '@modelcontextprotocol/sdk/types'
Error: A bucket name is needed to use Cloud Storage.
```

**Solution:**
1. Removed all GCS-related imports and code
2. Created stub in `lib/buildship/storage.ts` for compatibility
3. Replaced all storage operations with Vercel Blob
4. Removed `@google-cloud/storage` and `@google-cloud/firestore` from dependencies
5. Deleted unused BuildShip tool execution files

**Files Modified:**
- `lib/buildship/storage.ts` - Stub implementation
- `lib/cancerApp/nodes.ts` - Simplified to minimal definitions
- `package.json` - Removed GCS packages
- Multiple script files - Updated to use Vercel Blob

## Step 11: Deployment Process ✅

### Initial Deployment:

1. **Connect to GitHub:**
   - Vercel Dashboard → Import Project
   - Connect to GitHub repository: `Noyi-24-7/pregnancy-voice-assistant-ku850b`
   - Set Root Directory: `cancer-app-api`
   - Framework: Next.js (auto-detected)

2. **Deployment Issues:**
   - ❌ First deployment failed due to Turbopack/Webpack conflict
   - ❌ Second deployment failed due to missing environment variables
   - ❌ Third deployment failed due to module path resolution

3. **Successful Deployment:**
   - ✅ Fixed all build issues
   - ✅ Configured Vercel Blob Storage
   - ✅ Added all environment variables
   - ✅ Final deployment successful at commit `6c4d9a1`

### Production URL:
```
https://cancer-app-api.vercel.app
```

### API Endpoint:
```
POST https://cancer-app-api.vercel.app/api/process-audio
```

## Step 12: Testing ✅

### Test Command:
```bash
curl -X POST https://cancer-app-api.vercel.app/api/process-audio \
  -H "Content-Type: application/json" \
  -d '{
    "audioFile": "data:audio/m4a;base64,AAAAIGZ0eXBpc29tAAACAGlzb21pc28yYXZjMW1wNDEAAAAIZnJlZQAAfhltZGF0AAACrQYF",
    "sourceLanguage": "en",
    "conversationHistory": []
  }'
```

### Successful Response:
```json
{
  "success": true,
  "translatedText": "Detecting cancer in lymph nodes often involves...",
  "audioUrl": "https://z7mwkpmbmsu4saww.public.blob.vercel-storage.com/...",
  "error": null,
  "transcribedText": "How do you spot cancer in the lymph nodes?",
  "sourceLanguage": "en"
}
```

## Step 13: Documentation ✅

Created comprehensive documentation:

1. **`README.md`** - Project overview and setup
2. **`DEPLOYMENT.md`** - Detailed deployment guide
3. **`QUICK_START.md`** - Quick reference for deployment
4. **`TEST_API.md`** - API testing instructions
5. **`VERCEL_BLOB_SETUP.md`** - Blob storage setup guide
6. **`MIGRATION_COMPLETE.md`** - Migration summary

## Workflow Execution Flow

The complete workflow processes audio through these steps:

1. **Upload Input Audio** → Vercel Blob Storage
2. **Convert M4A to MP3** → Zamzar API
3. **Download & Re-upload** → MP3 to Vercel Blob
4. **Transcribe Audio** → Spitch API
5. **Translate to English** → Spitch API (if needed)
6. **Process Medical Question** → Gemma AI
7. **Clean Medical Response** → Text processing
8. **Translate Response Back** → Spitch API (user's language)
9. **Select Voice** → Voice selection based on language
10. **Synthesize Speech** → Spitch API
11. **Upload Synthesized Audio** → Vercel Blob Storage
12. **Build Output JSON** → Format final response
13. **Return Result** → JSON with text and audio URL

## API Request/Response Format

### Request:
```json
{
  "audioFile": "data:audio/m4a;base64,<base64_encoded_audio>",
  "sourceLanguage": "en",
  "conversationHistory": []
}
```

### Response:
```json
{
  "success": true,
  "translatedText": "Medical response in user's language",
  "audioUrl": "https://...blob.vercel-storage.com/...",
  "error": null,
  "transcribedText": "Original transcribed text",
  "sourceLanguage": "en"
}
```

## Git Repository

**Repository**: `Noyi-24-7/pregnancy-voice-assistant-ku850b`
**Branch**: `main`
**Path**: `cancer-app-api/`

### Important Commits:
- `59deaf0` - Initial fixes (Turbopack/Webpack config)
- `52b6932` - Version bump to trigger deployment
- `2198bbe` - Fix module path resolution
- `deee6cf` - Fix CommonJS import structure
- `6c4d9a1` - Fix undefined node reference (final working version)

## All API Keys (For Reference)

```
SPITCH_API_KEY=sk_rK4cVeU8LfNHZMID6py7cRIDTWFg8x85GY3ab0FG
GEMMA_API_KEY=AIzaSyDTK7HZCCdb_oex2Sc7g8zZysZlI6shJCY
ZAMZAR_API_KEY=3e3883191f7fec54040c031eaed3bbe9bcfe748d
BLOB_READ_WRITE_TOKEN=<auto-provided by Vercel when Blob store is connected>
```

**Note**: Store these securely. Never commit actual keys to Git.

## Lessons Learned

1. **Turbopack vs Webpack**: Next.js 16 defaults to Turbopack, but custom webpack configs require explicit webpack build or Turbopack migration.

2. **Serverless Path Resolution**: Dynamic path construction with `process.cwd()` doesn't work in serverless. Use relative imports instead.

3. **CommonJS in ES Modules**: When importing CommonJS modules in ES modules, use single-level destructuring: `module.default`, not nested destructuring.

4. **Vercel Blob Integration**: Much simpler than external storage services - automatic token injection, no manual configuration needed.

5. **Environment Variables**: Must be added in Vercel Dashboard and require redeployment to take effect.

6. **Build Errors**: Always check the latest deployment logs in Vercel Dashboard for detailed error messages.

7. **Workflow Node IDs**: When refactoring BuildShip exports, verify all node ID references match the actual workflow structure.

## Potential Future Improvements

1. **File Size Handling**: Implement client-side compression for large audio files
2. **Rate Limiting**: Add API rate limiting for production use
3. **Authentication**: Add API key authentication for security
4. **Monitoring**: Set up error tracking (Sentry, LogRocket)
5. **Caching**: Implement response caching for repeated queries
6. **Webhook Support**: Add webhook support for async processing
7. **Multi-language Support**: Enhance language detection and support

## Completed Checklist ✅

- [x] Run BuildShip export command and examine generated code structure
- [x] Create Next.js project and set up basic API route structure
- [x] Convert BuildShip function to Next.js API route with proper file handling
- [x] Set up environment variables and dependencies
- [x] Create vercel.json with timeout and memory settings
- [x] Migrate from Google Cloud Storage to Vercel Blob Storage
- [x] Fix Turbopack/Webpack build configuration conflicts
- [x] Fix module path resolution for serverless environment
- [x] Fix CommonJS import structure for script files
- [x] Fix undefined node references in workflow
- [x] Configure Vercel Blob Storage and connect to project
- [x] Add all required environment variables
- [x] Test API endpoint locally with sample audio files
- [x] Deploy to Vercel and configure production environment variables
- [x] Fix all deployment errors and issues
- [x] Test production deployment end-to-end
- [x] Verify complete workflow execution (all 13 steps)
- [x] Create comprehensive documentation

## Status: ✅ COMPLETE AND PRODUCTION-READY

The API is now fully functional and deployed to production at:
**https://cancer-app-api.vercel.app/api/process-audio**

