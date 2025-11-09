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

List<dynamic> parseJsonToList(String jsonString) {
  if (jsonString == null || jsonString.isEmpty || jsonString == 'null')
    return <dynamic>[];
  final decoded = json.decode(jsonString);
  if (decoded is List) return decoded;
  return <dynamic>[];
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
