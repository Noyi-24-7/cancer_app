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

Future<String?> getEmergencyAlertsREST(
  String deviceId,
  String apiUrl,
) async {
  try {
    final String url = '$apiUrl/emergencyAlerts/active.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final String responseBody = response.body;

      if (responseBody == 'null' || responseBody.isEmpty) {
        return json.encode([]); // Return empty array as JSON string
      }

      Map<String, dynamic> alertsData = json.decode(responseBody);
      List<Map<String, dynamic>> alerts = [];

      alertsData.forEach((key, value) {
        Map<String, dynamic> alert = Map<String, dynamic>.from(value as Map);
        if (alert['deviceId'] == deviceId && alert['resolved'] == false) {
          alert['alertId'] = key;
          alerts.add(alert);
        }
      });

      print('Found ${alerts.length} active emergency alerts');
      return json.encode(alerts); // Return as JSON string
    } else {
      print('Failed to fetch emergency alerts. Status: ${response.statusCode}');
      return json.encode([]); // Return empty array as JSON string
    }
  } catch (e) {
    print('Error fetching emergency alerts: $e');
    return json.encode([]); // Return empty array as JSON string
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
