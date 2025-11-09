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

String articlesToJsonString(List<dynamic> articles) {
  // MODIFY CODE ONLY BELOW THIS LINE

  try {
    // Convert the articles list to JSON string
    return jsonEncode(articles);
  } catch (e) {
    // If encoding fails, return empty array
    print('Error encoding articles: $e');
    return '[]';
  }

  // MODIFY CODE ONLY ABOVE THIS LINE
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
