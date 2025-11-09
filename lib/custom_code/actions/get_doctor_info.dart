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

Future<dynamic> getDoctorInfo(String doctorId) async {
  try {
    final response = await http.get(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/doctors/$doctorId.json'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    return {};
  } catch (e) {
    print('Error getting doctor info: $e');
    return {};
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
