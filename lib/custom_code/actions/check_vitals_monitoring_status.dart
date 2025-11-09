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

Future<String> checkVitalsMonitoringStatus() async {
  try {
    String status = FFAppState().vitalsConnectionStatus;
    String lastData = FFAppState().currentVitalsData;

    Map<String, dynamic> statusInfo = {
      'status': status,
      'hasData': lastData.isNotEmpty,
      'timestamp': DateTime.now().toIso8601String(),
    };

    return json.encode(statusInfo);
  } catch (e) {
    print('Error checking monitoring status: $e');
    return json.encode({'status': 'error', 'hasData': false, 'timestamp': ''});
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
