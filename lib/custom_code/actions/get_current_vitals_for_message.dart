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

Future<String> getCurrentVitalsForMessage() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.phoneNumber == null) {
      return '{}';
    }

    final phoneKey =
        'phone_${user.phoneNumber!.replaceAll('+', '').replaceAll(' ', '')}';

    // Get current vitals from your existing vitals system
    final response = await http.get(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/users/$phoneKey/currentVitals.json'),
    );

    if (response.statusCode == 200 && response.body != 'null') {
      final vitalsData = json.decode(response.body);

      // Simplify vitals data for message storage
      final simplifiedVitals = {
        'heartRate': vitalsData['heartRate']['value'] ?? 0,
        'bloodPressure':
            '${vitalsData['bloodPressure']['systolic']}/${vitalsData['bloodPressure']['diastolic']}',
        'temperature': vitalsData['temperature']['value'] ?? 0,
        'timestamp': DateTime.now().toIso8601String()
      };

      return json.encode(simplifiedVitals);
    }

    return '{}';
  } catch (e) {
    print('Error getting vitals: $e');
    return '{}';
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
