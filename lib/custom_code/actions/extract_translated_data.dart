// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> extractTranslatedData(dynamic translationResponse) async {
  // Add your function code here!

  try {
    // Handle Vercel API response structure (nested under 'result')
    dynamic responseData = translationResponse;
    
    // If response has 'result' key, extract it
    if (translationResponse != null && translationResponse['result'] != null) {
      responseData = translationResponse['result'];
    }
    
    // Check if responseData has articles
    if (responseData != null && responseData['articles'] != null) {
      final articles = responseData['articles'] as List<dynamic>;

      if (articles.isNotEmpty) {
        // Get the first article
        final firstArticle = articles[0] as Map<String, dynamic>;

        // Extract translated content and title
        return {
          'translatedContent': firstArticle['translatedContent'] ?? '',
          'translatedTitle': firstArticle['translatedTitle'] ?? '',
          'success': true
        };
      }
    }

    // Return empty values if no articles found
    return {'translatedContent': '', 'translatedTitle': '', 'success': false};
  } catch (e) {
    print('Error extracting translated data: $e');
    // Return empty values on error
    return {
      'translatedContent': '',
      'translatedTitle': '',
      'success': false,
      'error': e.toString()
    };
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
