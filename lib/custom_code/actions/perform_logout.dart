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

Future<bool> performLogout() async {
  try {
    // Sign out from Firebase Auth
    await FirebaseAuth.instance.signOut();

    // Clear all app state variables
    FFAppState().isAuthenticated = false;
    FFAppState().currentUserPhone = "";
    FFAppState().currentPatientData = {};
    FFAppState().registrationStep = 0;

    // Force app state update
    FFAppState().update(() {});

    return true;
  } catch (e) {
    print('Error during logout: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
