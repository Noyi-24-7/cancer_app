// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> notifyDoctorOfNewMessage(
  String doctorId,
  String patientName,
  String messagePreview,
) async {
  try {
    // For Phase 1: Store notification in Firebase for doctor dashboard
    // In production: Send push notification or email
    final notificationId =
        'notification_${DateTime.now().millisecondsSinceEpoch}';
    final notificationData = {
      'doctorId': doctorId,
      'patientName': patientName,
      'messagePreview': messagePreview.length > 50
          ? '${messagePreview.substring(0, 47)}...'
          : messagePreview,
      'timestamp': DateTime.now().toIso8601String(),
      'type': 'new_patient_message',
      'read': false
    };

    final response = await http.put(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/doctor_notifications/$doctorId/$notificationId.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(notificationData),
    );

    return response.statusCode == 200;
  } catch (e) {
    print('Error notifying doctor: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
