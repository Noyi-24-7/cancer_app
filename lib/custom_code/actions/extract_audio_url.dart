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
    // Check if response has articles
    if (audioResponse != null && audioResponse['articles'] != null) {
      final articles = audioResponse['articles'] as List<dynamic>;

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
