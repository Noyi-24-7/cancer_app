# API Testing Guide for Cancer Assistant

## Problem
The medical assistant shows an empty audio player with nothing to play after recording a voice message.

## Current Endpoint
```
https://cancer-app-api.vercel.app/api/process-audio
```

## How to Test the Endpoint

### Option 1: Using the Shell Script (Easiest)
```bash
cd /Users/noyi/Downloads/cancer_app
./test_api_curl.sh
```

### Option 2: Using the Dart Test Script
```bash
cd /Users/noyi/Downloads/cancer_app
dart test_api_endpoint.dart
```

### Option 3: Using curl directly
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "audioFile": "AAAAHGZ0eXBNNEEgAAACAE00QSBpc29taXNvMgAAAAhmcmVl",
    "sourceLanguage": "en",
    "targetLanguage": "en",
    "conversationHistory": "[]"
  }' \
  https://cancer-app-api.vercel.app/api/process-audio
```

## Expected Response Format

The app expects the API to return JSON in this exact structure:

```json
{
  "result": {
    "transcribedText": "What the user said",
    "translatedText": "AI assistant response",
    "audioUrl": {
      "publicUrl": "https://storage.example.com/audio/response.mp3"
    }
  }
}
```

## Where the App Extracts Data

The Flutter app uses these JSON paths:

1. **User's transcribed text**: `$.result.transcribedText`
2. **AI response text**: `$.result.translatedText`
3. **Audio URL**: `$.result.audioUrl.publicUrl` ⚠️ **This is critical!**

## Common Issues

### Issue 1: Audio URL Format
❌ **Wrong format** (will cause empty audio player):
```json
{
  "result": {
    "audioUrl": "https://audio-url.mp3"
  }
}
```

✅ **Correct format**:
```json
{
  "result": {
    "audioUrl": {
      "publicUrl": "https://audio-url.mp3"
    }
  }
}
```

### Issue 2: Missing Fields
If any of these fields are missing, the app won't work correctly:
- `result.transcribedText` - User won't see what they said
- `result.translatedText` - AI response text won't show
- `result.audioUrl.publicUrl` - **Audio player will be empty** 🚨

### Issue 3: API Endpoint Not Responding
If the API is down or not configured, you'll get:
- Connection timeout
- 404 Not Found
- 500 Server Error

## How to Fix

### If the API returns the wrong format:
You need to update either:

**Option A**: Fix the API to return the correct format
- Update the API at `https://cancer-app-api.vercel.app/api/process-audio`
- Ensure it returns `audioUrl` as an object with `publicUrl` field

**Option B**: Update the Flutter app to match the API's format
- Modify `lib/pages/medical_assistant/chat_screen/chat_screen.dart`
- Change the JSON path from `$.result.audioUrl.publicUrl` to match your API

## Code Location

The audio URL extraction happens here:

**File**: `lib/pages/medical_assistant/chat_screen/chat_screen.dart`

**Lines 147-150**:
```dart
audioUrl: getJsonField(
  (apiResponse?.jsonBody ?? ''),
  r'''$.result.audioUrl.publicUrl''',
).toString(),
```

## Testing Checklist

- [ ] API endpoint is accessible (returns 200 status)
- [ ] Response contains `result` object
- [ ] Response contains `result.transcribedText`
- [ ] Response contains `result.translatedText`
- [ ] Response contains `result.audioUrl.publicUrl` (not just `result.audioUrl`)
- [ ] The `publicUrl` is a valid audio file URL (mp3, wav, etc.)
- [ ] The audio file at `publicUrl` is accessible and playable

## Next Steps

1. Run one of the test scripts above
2. Check the response format
3. If the format is wrong, update the API or the Flutter app accordingly
4. Test again

## Questions?

If you need help:
1. Share the test script output
2. Share the actual API response you're getting
3. We can then update either the API or the Flutter app to match

