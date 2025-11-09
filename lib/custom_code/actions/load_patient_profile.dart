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
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> loadPatientProfile() async {
  try {
    // Get current authenticated user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.phoneNumber == null) {
      return false;
    }

    // Create phone key for database lookup
    final phoneKey =
        'phone_${user.phoneNumber!.replaceAll('+', '').replaceAll(' ', '')}';

    // Fetch patient data from Firebase
    final response = await http.get(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/patients/$phoneKey.json'),
    );

    if (response.statusCode == 200) {
      final patientData = json.decode(response.body);

      if (patientData != null) {
        // Update app state with loaded data
        FFAppState().currentPatientData = patientData;
        FFAppState().currentUserPhone = user.phoneNumber!;
        FFAppState().isAuthenticated = true;

        return true;
      }
    }

    return false;
  } catch (e) {
    print('Error loading patient profile: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
