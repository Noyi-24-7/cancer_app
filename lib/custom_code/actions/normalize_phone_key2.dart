// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String normalizePhoneKey2(String phone) {
  if (phone == null || phone.isEmpty) return '';
  // strip non-digits, ensure we keep leading country digits only once
  final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
  // your RTDB uses phone_234... (no +)
  return 'phone_$digits';
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
