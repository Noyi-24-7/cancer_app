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
  "success": true,
  "transcribedText": "What the user said",
  "translatedText": "AI assistant response",
  "audioUrl": "https://storage.example.com/audio/response.m4a",
  "sourceLanguage": "en",
  "error": null
}
```

## Where the App Extracts Data

The Flutter app uses these JSON paths:

1. **User's transcribed text**: `$.transcribedText`
2. **AI response text**: `$.translatedText`
3. **Audio URL**: `$.audioUrl` ⚠️ **This is critical!**

## Common Issues

### Issue 1: Missing Fields
If any of these fields are missing, the app won't work correctly:
- `transcribedText` - User won't see what they said
- `translatedText` - AI response text won't show
- `audioUrl` - **Audio player will be empty** 🚨

### Issue 2: Invalid Audio URL
The `audioUrl` must be a valid, publicly accessible audio file URL (typically .m4a format)

### Issue 3: API Endpoint Not Responding
If the API is down or not configured, you'll get:
- Connection timeout
- 404 Not Found
- 500 Server Error

## Code Location

The response data extraction happens here:

**File**: `lib/pages/medical_assistant/chat_screen/chat_screen.dart`

**Lines 133-150** (approximate):
```dart
// User's transcribed text
text: getJsonField(
  (apiResponse?.jsonBody ?? ''),
  r'''$.transcribedText''',
).toString(),

// AI response text
text: getJsonField(
  (apiResponse?.jsonBody ?? ''),
  r'''$.translatedText''',
).toString(),

// Audio URL
audioUrl: getJsonField(
  (apiResponse?.jsonBody ?? ''),
  r'''$.audioUrl''',
).toString(),
```

## Testing Checklist

- [x] API endpoint is accessible (returns 200 status) ✅
- [x] Response contains `success` field ✅
- [x] Response contains `transcribedText` ✅
- [x] Response contains `translatedText` ✅
- [x] Response contains `audioUrl` as a direct string ✅
- [x] The `audioUrl` is a valid audio file URL (.m4a format) ✅
- [ ] The audio file at the URL is accessible and playable (test in browser)

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

