import 'dart:convert';
import 'dart:io';

/// Test script for the Cancer Assistant API endpoint
/// 
/// This script sends a test request to the API to verify:
/// 1. The endpoint is accessible
/// 2. The response format is correct
/// 3. The audio URL is being returned properly
///
/// Run with: dart test_api_endpoint.dart

void main() async {
  print('🧪 Testing Cancer Assistant API Endpoint\n');
  print('Endpoint: https://cancer-app-api.vercel.app/api/process-audio\n');

  // Sample base64 audio data (very short sample)
  const sampleAudioBase64 = 'AAAAHGZ0eXBNNEEgAAACAE00QSBpc29taXNvMgAAAAhmcmVlAAFgCW1kYXQ=';

  final requestBody = {
    'audioFile': sampleAudioBase64,
    'sourceLanguage': 'en',
    'targetLanguage': 'en',
    'conversationHistory': '[]'
  };

  print('📤 Sending request...');
  print('Request body keys: ${requestBody.keys.join(", ")}\n');

  try {
    final client = HttpClient();
    final request = await client.postUrl(
      Uri.parse('https://cancer-app-api.vercel.app/api/process-audio'),
    );

    request.headers.set('Content-Type', 'application/json');
    request.write(jsonEncode(requestBody));

    print('⏳ Waiting for response...\n');
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    print('📥 Response received!');
    print('Status Code: ${response.statusCode}\n');

    if (response.statusCode == 200) {
      print('✅ Success! Parsing response...\n');
      
      try {
        final jsonResponse = jsonDecode(responseBody);
        print('Response structure:');
        print(JsonEncoder.withIndent('  ').convert(jsonResponse));
        print('\n');

        // Check for expected fields
        print('🔍 Checking expected fields:');
        
        if (jsonResponse.containsKey('result')) {
          print('  ✅ "result" field found');
          final result = jsonResponse['result'];
          
          if (result is Map) {
            if (result.containsKey('transcribedText')) {
              print('  ✅ "transcribedText" field found: ${result['transcribedText']}');
            } else {
              print('  ❌ "transcribedText" field NOT found');
            }

            if (result.containsKey('translatedText')) {
              print('  ✅ "translatedText" field found: ${result['translatedText']}');
            } else {
              print('  ❌ "translatedText" field NOT found');
            }

            if (result.containsKey('audioUrl')) {
              final audioUrl = result['audioUrl'];
              if (audioUrl is Map && audioUrl.containsKey('publicUrl')) {
                print('  ✅ "audioUrl.publicUrl" field found: ${audioUrl['publicUrl']}');
              } else if (audioUrl is String) {
                print('  ⚠️  "audioUrl" is a string, not an object: $audioUrl');
                print('     Expected: {"publicUrl": "url"}');
                print('     Got: "$audioUrl"');
              } else {
                print('  ❌ "audioUrl.publicUrl" field NOT found');
                print('     audioUrl value: $audioUrl');
              }
            } else {
              print('  ❌ "audioUrl" field NOT found');
            }
          } else {
            print('  ❌ "result" is not an object');
          }
        } else {
          print('  ❌ "result" field NOT found in response');
          print('  Available top-level keys: ${jsonResponse.keys.join(", ")}');
        }

      } catch (e) {
        print('❌ Error parsing JSON response: $e');
        print('Raw response body:\n$responseBody');
      }
    } else {
      print('❌ Request failed with status ${response.statusCode}');
      print('Response body:\n$responseBody');
    }

    client.close();
  } catch (e) {
    print('❌ Error making request: $e');
    print('\nPossible issues:');
    print('  1. Network connectivity problems');
    print('  2. API endpoint is down or unreachable');
    print('  3. Firewall or security restrictions');
  }

  print('\n' + '=' * 60);
  print('Expected Response Format:');
  print('''
{
  "result": {
    "transcribedText": "user's question text",
    "translatedText": "AI response text",
    "audioUrl": {
      "publicUrl": "https://url-to-audio-file.mp3"
    }
  }
}
''');
  print('=' * 60);
}

