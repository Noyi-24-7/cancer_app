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

Future<bool> checkForNewDoctorResponses(int currentMessageCount) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.phoneNumber == null) {
      return false;
    }

    final threadId = FFAppState().currentThreadId;
    if (threadId.isEmpty) {
      return false;
    }

    // Check thread for new messages
    final response = await http.get(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/medical_communications/$threadId.json'),
    );

    if (response.statusCode == 200 && response.body != 'null') {
      final threadData = json.decode(response.body) as Map<String, dynamic>;
      final serverMessageCount = threadData['messageCount'] ?? 0;

      // Compare with the passed current count
      if (serverMessageCount > currentMessageCount) {
        print(
            'New doctor responses detected: $serverMessageCount vs $currentMessageCount');
        return true;
      }
    }

    return false;
  } catch (e) {
    print('Error checking for doctor responses: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
