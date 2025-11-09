// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

List<dynamic> filterContentByCategory(List<dynamic> articles, String category) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  List<Map<String, dynamic>> filtered = [];

  for (var item in articles) {
    if (item is Map<String, dynamic>) {
      // If category is "all", include everything
      if (category == 'all') {
        filtered.add(item);
      } else {
        // Filter by specific category
        String articleCategory = item['category']?.toLowerCase() ?? '';
        if (articleCategory == category.toLowerCase()) {
          filtered.add(item);
        }
      }
    }
  }

  // Sort by title alphabetically
  filtered.sort((a, b) {
    String titleA = a['title'] ?? '';
    String titleB = b['title'] ?? '';
    return titleA.compareTo(titleB);
  });

  return filtered;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
