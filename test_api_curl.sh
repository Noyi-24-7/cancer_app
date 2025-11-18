#!/bin/bash

# Test script for Cancer Assistant API using curl
# Make executable with: chmod +x test_api_curl.sh
# Run with: ./test_api_curl.sh

echo "🧪 Testing Cancer Assistant API Endpoint"
echo "========================================"
echo ""
echo "Endpoint: https://cancer-app-api.vercel.app/api/process-audio"
echo ""

# Sample base64 audio (minimal sample)
AUDIO_BASE64="AAAAHGZ0eXBNNEEgAAACAE00QSBpc29taXNvMgAAAAhmcmVlAAFgCW1kYXQ="

echo "📤 Sending POST request..."
echo ""

# Make the API call and save response
RESPONSE=$(curl -X POST \
  -H "Content-Type: application/json" \
  -d "{
    \"audioFile\": \"$AUDIO_BASE64\",
    \"sourceLanguage\": \"en\",
    \"targetLanguage\": \"en\",
    \"conversationHistory\": \"[]\"
  }" \
  -w "\nHTTP_STATUS:%{http_code}" \
  https://cancer-app-api.vercel.app/api/process-audio 2>&1)

# Extract status code
HTTP_STATUS=$(echo "$RESPONSE" | grep "HTTP_STATUS:" | cut -d: -f2)
BODY=$(echo "$RESPONSE" | sed '/HTTP_STATUS:/d')

echo "📥 Response:"
echo "Status Code: $HTTP_STATUS"
echo ""

if [ "$HTTP_STATUS" = "200" ]; then
    echo "✅ Success! Response body:"
    echo "$BODY" | jq '.' 2>/dev/null || echo "$BODY"
    echo ""
    echo "🔍 Checking for required fields:"
    
    # Check for transcribedText
    if echo "$BODY" | jq -e '.result.transcribedText' > /dev/null 2>&1; then
        TRANSCRIBED=$(echo "$BODY" | jq -r '.result.transcribedText')
        echo "  ✅ transcribedText: $TRANSCRIBED"
    else
        echo "  ❌ transcribedText field missing"
    fi
    
    # Check for translatedText
    if echo "$BODY" | jq -e '.result.translatedText' > /dev/null 2>&1; then
        TRANSLATED=$(echo "$BODY" | jq -r '.result.translatedText')
        echo "  ✅ translatedText: $TRANSLATED"
    else
        echo "  ❌ translatedText field missing"
    fi
    
    # Check for audioUrl.publicUrl
    if echo "$BODY" | jq -e '.result.audioUrl.publicUrl' > /dev/null 2>&1; then
        AUDIO_URL=$(echo "$BODY" | jq -r '.result.audioUrl.publicUrl')
        echo "  ✅ audioUrl.publicUrl: $AUDIO_URL"
    else
        echo "  ❌ audioUrl.publicUrl field missing"
        # Check if audioUrl exists as a string instead
        if echo "$BODY" | jq -e '.result.audioUrl' > /dev/null 2>&1; then
            AUDIO_URL=$(echo "$BODY" | jq -r '.result.audioUrl')
            echo "  ⚠️  audioUrl exists but not in expected format: $AUDIO_URL"
            echo "     Expected: {\"publicUrl\": \"url\"}"
            echo "     Got: \"$AUDIO_URL\""
        fi
    fi
else
    echo "❌ Request failed!"
    echo "Response body:"
    echo "$BODY"
fi

echo ""
echo "========================================"
echo "Expected Response Format:"
echo '
{
  "result": {
    "transcribedText": "user question",
    "translatedText": "AI response",
    "audioUrl": {
      "publicUrl": "https://audio-url.mp3"
    }
  }
}
'
echo "========================================"

