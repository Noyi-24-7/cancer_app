// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

String generateThreadId() {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.phoneNumber == null) {
      return '';
    }

    final patientId =
        'phone_${user.phoneNumber!.replaceAll('+', '').replaceAll(' ', '')}';
    final doctorId =
        FFAppState().currentPatientData['assignedDoctor'] ?? 'doctor_001';

    return 'thread_${patientId}_$doctorId';
  } catch (e) {
    print('Error generating thread ID: $e');
    return '';
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
