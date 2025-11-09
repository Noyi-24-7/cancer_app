// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> saveMessageToFirebase(
  String threadId,
  String sender,
  String text,
  String audioUrl,
  String vitalsData,
) async {
  try {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final messageId = 'msg_$timestamp';

    // Create message object
    Map<String, dynamic> messageData = {
      'sender': sender,
      'text': text,
      'audioUrl': audioUrl,
      'language': sender == 'patient'
          ? (FFAppState().currentPatientData['profile']['language'] ??
              'english')
          : 'english',
      'createdAt': timestamp,
    };

    // Add vitals if provided
    if (vitalsData.isNotEmpty && vitalsData != '{}') {
      messageData['vitalsSnapshot'] = json.decode(vitalsData);
    }

    // Save message
    final messageResponse = await http.put(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/medical_communications/$threadId/messages/$messageId.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(messageData),
    );

    if (messageResponse.statusCode != 200) {
      print('Failed to save message: ${messageResponse.body}');
      return false;
    }

    // Update thread metadata
    final threadData = {
      'threadId': threadId,
      'patientId': FFAppState().currentPatientData['profile']['phone'] ?? '',
      'doctorId': FFAppState().currentPatientData['assignedDoctor'] ?? '',
      'lastMessageAt': timestamp,
      'lastMessagePreview':
          text.length > 50 ? '${text.substring(0, 47)}...' : text,
      'messageCount': await getMessageCount(threadId) + 1,
      'status': 'active'
    };

    final threadResponse = await http.patch(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/medical_communications/$threadId.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(threadData),
    );

    // Notify doctor if message is from patient
    if (sender == 'patient' && threadResponse.statusCode == 200) {
      final patientName =
          FFAppState().currentPatientData['profile']['name'] ?? 'Patient';
      final doctorId = FFAppState().currentPatientData['assignedDoctor'] ?? '';
      await notifyDoctorOfNewMessage(doctorId, patientName, text);
    }

    return threadResponse.statusCode == 200;
  } catch (e) {
    print('Error saving message: $e');
    return false;
  }
}

// Helper function to get current message count
Future<int> getMessageCount(String threadId) async {
  try {
    final response = await http.get(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/medical_communications/$threadId/messages.json'),
    );

    if (response.statusCode == 200 && response.body != 'null') {
      final messagesMap = json.decode(response.body) as Map<String, dynamic>;
      return messagesMap.length;
    }

    return 0;
  } catch (e) {
    return 0;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
