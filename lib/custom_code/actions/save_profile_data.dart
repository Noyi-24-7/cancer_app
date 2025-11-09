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

Future<bool> saveProfileData(
  String name,
  int age,
  String gender,
  String language,
  String state,
  String lga,
) async {
  try {
    // Get current user phone number from Firebase Auth
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.phoneNumber == null) {
      return false;
    }

    final phoneKey =
        'phone_${user.phoneNumber!.replaceAll('+', '').replaceAll(' ', '')}';
    final currentTime = DateTime.now().toIso8601String();

    // Prepare profile data
    final profileData = {
      'profile': {
        'name': name,
        'age': age,
        'gender': gender,
        'location': {
          'state': state,
          'lga': lga,
        },
        'language': language,
        'phone': user.phoneNumber,
        'registrationDate': currentTime,
        'profileCompleted': false, // Will be true after all steps
      },
      'preferences': {
        'receiveReminders': true,
        'emergencyNotifications': true,
        'shareDataWithDoctor': true,
      }
    };

    // Save to Firebase Realtime Database
    // REPLACE 'YOUR_FIREBASE_DATABASE_URL' with your actual database URL
    final response = await http.patch(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/patients/$phoneKey.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profileData),
    );

    if (response.statusCode == 200) {
      // Update app state
      FFAppState().currentPatientData = profileData;
      FFAppState().currentUserPhone = user.phoneNumber!;
      return true;
    }

    return false;
  } catch (e) {
    print('Error saving profile: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
