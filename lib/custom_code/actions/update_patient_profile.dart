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

Future<bool> updatePatientProfile(
  String name,
  int age,
  String gender,
  String language,
  String state,
  String lga,
  String allergies,
  String medications,
  String conditions,
  String bloodType,
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

    // Parse comma-separated strings into lists for medical data
    final allergiesList = allergies
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final medicationsList = medications
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final conditionsList = conditions
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // Prepare updated profile data
    final updatedProfileData = {
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
        'registrationDate': FFAppState().currentPatientData['profile']
            ['registrationDate'], // Keep original registration date
        'profileCompleted': true,
        'lastUpdated': currentTime,
      },
      'medical': {
        'allergies': allergiesList,
        'currentMedications': medicationsList,
        'chronicConditions': conditionsList,
        'bloodType': bloodType,
        'emergencyContacts': FFAppState().currentPatientData['medical']
            ['emergencyContacts'], // Keep existing emergency contacts
      },
      'assignedDoctor': FFAppState().currentPatientData[
          'assignedDoctor'], // Keep existing doctor assignment
      'assignmentDate': FFAppState()
          .currentPatientData['assignmentDate'], // Keep assignment date
      'preferences': FFAppState()
          .currentPatientData['preferences'], // Keep existing preferences
    };

    // Update Firebase Realtime Database
    // REPLACE 'YOUR_FIREBASE_DATABASE_URL' with your actual database URL
    final response = await http.put(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/patients/$phoneKey.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedProfileData),
    );

    if (response.statusCode == 200) {
      // Update app state with new data
      FFAppState().currentPatientData = updatedProfileData;

      // Optional: Update other related app state variables if needed
      FFAppState().update(() {
        // This triggers UI updates across the app
      });

      return true;
    }

    return false;
  } catch (e) {
    print('Error updating patient profile: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
