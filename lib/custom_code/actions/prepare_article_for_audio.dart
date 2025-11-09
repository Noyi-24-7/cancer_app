// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

String prepareArticleForAudio(
  dynamic article,
  String? translatedContent,
  String? translatedTitle,
) {
  // MODIFY CODE ONLY BELOW THIS LINE

  // Create a mutable copy of the article
  final Map<String, dynamic> articleCopy;

  if (article is Map<String, dynamic>) {
    articleCopy = Map<String, dynamic>.from(article);
  } else {
    // If article is not a map, create a basic structure
    articleCopy = {
      'id': 'unknown',
      'title': 'Article',
      'content': 'No content available',
    };
  }

  // Add translated content if available
  if (translatedContent != null && translatedContent.isNotEmpty) {
    articleCopy['translatedContent'] = translatedContent;
  }

  // Add translated title if available
  if (translatedTitle != null && translatedTitle.isNotEmpty) {
    articleCopy['translatedTitle'] = translatedTitle;
  }

  // Convert to JSON string array with single article
  return jsonEncode([articleCopy]);

  // MODIFY CODE ONLY ABOVE THIS LINE
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
