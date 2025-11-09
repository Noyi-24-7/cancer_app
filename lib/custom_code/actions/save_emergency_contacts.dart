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

Future<bool> saveEmergencyContacts(
  String primaryName,
  String primaryRelationship,
  String primaryPhone,
  String? secondaryName,
  String? secondaryRelationship,
  String? secondaryPhone,
) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.phoneNumber == null) return false;

    final phoneKey =
        'phone_${user.phoneNumber!.replaceAll('+', '').replaceAll(' ', '')}';

    final emergencyContacts = <Map<String, dynamic>>[
      {
        'name': primaryName,
        'relationship': primaryRelationship,
        'phone': primaryPhone,
        'isPrimary': true,
      }
    ];

    // Add secondary contact if provided
    if (secondaryName != null && secondaryName.isNotEmpty) {
      emergencyContacts.add({
        'name': secondaryName,
        'relationship': secondaryRelationship ?? 'Other',
        'phone': secondaryPhone ?? '',
        'isPrimary': false,
      });
    }

    // Update medical data with emergency contacts
    final response = await http.patch(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/patients/$phoneKey/medical.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'emergencyContacts': emergencyContacts}),
    );

    // Mark profile as completed
    if (response.statusCode == 200) {
      await http.patch(
        Uri.parse(
            'https://preggos-dea93-default-rtdb.firebaseio.com/patients/$phoneKey/profile.json'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'profileCompleted': true}),
      );

      return true;
    }

    return false;
  } catch (e) {
    print('Error saving emergency contacts: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
