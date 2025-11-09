// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> startVitalsMonitoringREST(
  String deviceId,
  String apiUrl,
  int intervalSeconds,
) async {
  try {
    print('Starting vitals monitoring for device: $deviceId');
    print('Polling interval: ${intervalSeconds} seconds');

    // Start periodic monitoring
    Timer.periodic(
      Duration(seconds: intervalSeconds),
      (timer) async {
        try {
          // Check if monitoring should continue
          if (FFAppState().vitalsConnectionStatus == 'disconnected') {
            timer.cancel();
            print('Timer cancelled - monitoring stopped');
            return;
          }

          final String url = '$apiUrl/devices/$deviceId/currentVitals.json';
          final response = await http.get(Uri.parse(url));

          if (response.statusCode == 200) {
            final String responseBody = response.body;

            if (responseBody != 'null' && responseBody.isNotEmpty) {
              // Parse the JSON string to check for alerts
              Map<String, dynamic> vitalsData = json.decode(responseBody);

              // Update app state with JSON string (not parsed object)
              FFAppState().update(() {
                FFAppState().currentVitalsData =
                    responseBody; // Store as string
                FFAppState().vitalsConnectionStatus = 'connected';
              });

              // Check for emergency alerts
              List<dynamic> alerts = vitalsData['alerts'] ?? [];
              if (alerts.isNotEmpty) {
                List<Map<String, dynamic>> criticalAlerts = [];

                for (var alert in alerts) {
                  if (alert['type'] == 'critical') {
                    criticalAlerts.add(Map<String, dynamic>.from(alert));
                  }
                }

                if (criticalAlerts.isNotEmpty) {
                  FFAppState().update(() {
                    FFAppState().vitalsAlerts =
                        json.encode(criticalAlerts); // Store as JSON string
                  });
                }
              }

              print('Vitals updated successfully');
            } else {
              print('No vitals data available');
              FFAppState().update(() {
                FFAppState().vitalsConnectionStatus = 'no_data';
              });
            }
          } else {
            print('Failed to fetch vitals. Status: ${response.statusCode}');
            FFAppState().update(() {
              FFAppState().vitalsConnectionStatus = 'error';
            });
          }
        } catch (e) {
          print('Error in vitals monitoring: $e');
          FFAppState().update(() {
            FFAppState().vitalsConnectionStatus = 'error';
          });
        }
      },
    );
  } catch (e) {
    print('Error starting vitals monitoring: $e');
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
