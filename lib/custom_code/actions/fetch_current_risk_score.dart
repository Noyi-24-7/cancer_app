// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Returns Map<String, dynamic> of currentRiskScore
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

Future<dynamic> fetchCurrentRiskScore(String patientId) async {
  final user = FirebaseAuth.instance.currentUser;
  final idToken = await user?.getIdToken();
  final dbUrl =
      'https://preggos-dea93-default-rtdb.firebaseio.com/riskPrediction/$patientId/currentRiskScore.json';

  final resp = await http.get(
    Uri.parse('$dbUrl?auth=$idToken'),
    headers: {'Accept': 'application/json'},
  );
  if (resp.statusCode == 200 && resp.body.isNotEmpty) {
    return json.decode(resp.body) as Map<String, dynamic>;
  }
  return {};
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
