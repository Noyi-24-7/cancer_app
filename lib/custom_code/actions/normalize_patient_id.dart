// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String normalizePatientId(String raw) {
  if (raw.isEmpty) return '';
  final s = raw.trim();

  if (s.startsWith('phone_')) return s;

  if (s.startsWith('+')) {
    final digits = s.replaceAll(RegExp(r'[^0-9]'), '');
    return 'phone_$digits';
  }

  final onlyDigits = RegExp(r'^[0-9]+$');
  if (onlyDigits.hasMatch(s) && s.startsWith('234')) {
    return 'phone_$s';
  }

  return s;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
