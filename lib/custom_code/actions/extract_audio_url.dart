// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String extractAudioUrl(dynamic audioResponse) {
  try {
    // Handle Vercel API response structure (nested under 'result')
    dynamic responseData = audioResponse;
    
    // If response has 'result' key, extract it
    if (audioResponse != null && audioResponse['result'] != null) {
      responseData = audioResponse['result'];
    }
    
    // Check if responseData has articles
    if (responseData != null && responseData['articles'] != null) {
      final articles = responseData['articles'] as List<dynamic>;

      if (articles.isNotEmpty) {
        // Get the first article
        final firstArticle = articles[0] as Map<String, dynamic>;

        // Extract audio URL
        return firstArticle['audioUrl'] ?? '';
      }
    }
  } catch (e) {
    print('Error extracting audio URL: $e');
  }
  return '';
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
