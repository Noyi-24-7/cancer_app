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

Future<String?> getVitalsHistoryREST(
  String deviceId,
  String apiUrl,
) async {
  try {
    final String url = '$apiUrl/devices/$deviceId/vitalsHistory.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final String responseBody = response.body;

      if (responseBody == 'null' || responseBody.isEmpty) {
        print('No history data found for device: $deviceId');
        return null;
      }

      // Parse to create list format, then return as JSON string
      Map<String, dynamic> historyData = json.decode(responseBody);
      List<Map<String, dynamic>> historyList = [];

      historyData.forEach((timestamp, data) {
        Map<String, dynamic> entry = Map<String, dynamic>.from(data as Map);
        entry['timestamp'] = timestamp;
        historyList.add(entry);
      });

      // Sort by timestamp (most recent first)
      historyList.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

      print('Successfully fetched ${historyList.length} history entries');
      return json.encode(historyList); // Return as JSON string
    } else {
      print('Failed to fetch history. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching vitals history: $e');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
