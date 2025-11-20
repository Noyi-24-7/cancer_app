## Educational Content Processor API

This project hosts the BuildShip **Educational Content Processor** workflow on Vercel.  
It translates medical articles, optionally generates localized audio using Spitch, and
stores synthesized files in Vercel Blob Storage.

### Requirements

- Node.js 18+
- Vercel Blob store connected to the project (injects `BLOB_READ_WRITE_TOKEN`)
- Secrets:
  - `SPITCH_API_KEY`

### Local Development

```bash
npm install
SPITCH_API_KEY=sk_your_key_here npm run dev
```

The API lives at `POST /api/process-articles`. Use the sample body below when testing:

```bash
curl -X POST http://localhost:3000/api/process-articles \
  -H "Content-Type: application/json" \
  -d '{
    "articles": [{
      "id": "intro",
      "title": "Understanding lymph nodes",
      "content": "How do clinicians detect cancer in lymph nodes?"
    }],
    "targetLanguage": "en",
    "action": "translate_and_audio"
  }'
```

### Deployment Checklist

1. `npm run lint && npm run build`
2. Create/attach a Blob store in the Vercel dashboard and connect it to this project  
   (the `BLOB_READ_WRITE_TOKEN` variable is injected automatically)
3. Add `SPITCH_API_KEY` to **Production**, **Preview**, and **Development** environments
4. Deploy via GitHub or `vercel --prod`

### Endpoint

- `GET /api/process-articles` – health check
- `POST /api/process-articles` – runs the BuildShip workflow and returns translated text +
  audio metadata:

```json
{
  "success": true,
  "result": {
    "articlesJson": "[...]",
    "success": "true",
    "targetLanguage": "yo"
  }
}
```

Errors are reported with `success: false` and an HTTP 4xx/5xx status so clients can retry or
surface actionable feedback.
