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

String buildMessagesForUI(String rawMessagesJson) {
  if (rawMessagesJson == null ||
      rawMessagesJson.isEmpty ||
      rawMessagesJson == 'null') {
    return '[]';
  }
  final Map<String, dynamic> obj = json.decode(rawMessagesJson);
  final list = <Map<String, dynamic>>[];

  obj.forEach((k, v) {
    if (v is Map<String, dynamic>) {
      final text = (v['text']?.toString() ?? '');
      final audioUrl = (v['audioUrl']?.toString() ?? '');
      final sender = (v['sender']?.toString() ?? '');
      final ts = (v['createdAt'] is num) ? (v['createdAt'] as num).toInt() : 0;

      final isDoctor = sender.toLowerCase() == 'doctor';
      final isPatient = sender.toLowerCase() == 'patient';

      list.add({
        'messageId': k,
        'text': text.isEmpty || text == 'null' ? null : text,
        'audioUrl': audioUrl == '""' ? '' : audioUrl,
        'timestamp': ts,
        'sender': sender,
        'isDoctor': isDoctor,
        'isPatient': isPatient,
        'doctorFlag': isDoctor ? '1' : null, // <-- add
        'patientFlag': isPatient ? '1' : null, // <-- add
      });
    }
  });

  list.sort((a, b) => (a['timestamp'] as int).compareTo(b['timestamp'] as int));
  return json.encode(list);
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
