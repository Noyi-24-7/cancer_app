// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getCurrentVitalsREST(
  String deviceId,
  String apiUrl,
) async {
  try {
    final String url = '$apiUrl/devices/$deviceId/currentVitals.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final String responseBody = response.body;

      if (responseBody == 'null' || responseBody.isEmpty) {
        print('No vitals data found for device: $deviceId');
        return null;
      }

      print('Successfully fetched vitals data');
      return responseBody; // Return the raw JSON string
    } else {
      print('Failed to fetch vitals. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching current vitals: $e');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
