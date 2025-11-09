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

Future<bool> saveMedicalData(
  String allergies,
  String medications,
  String conditions,
  String bloodType,
) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.phoneNumber == null) return false;

    final phoneKey =
        'phone_${user.phoneNumber!.replaceAll('+', '').replaceAll(' ', '')}';

    // Parse comma-separated strings into lists
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

    final medicalData = {
      'medical': {
        'allergies': allergiesList,
        'currentMedications': medicationsList,
        'chronicConditions': conditionsList,
        'bloodType': bloodType,
        'emergencyContacts': [], // Will be added in next step
      }
    };

    final response = await http.patch(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/patients/$phoneKey.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(medicalData),
    );

    return response.statusCode == 200;
  } catch (e) {
    print('Error saving medical data: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
