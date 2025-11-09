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

Future<List<dynamic>> loadNewDoctorResponses() async {
  try {
    final threadId = FFAppState().currentThreadId;
    if (threadId.isEmpty) {
      return [];
    }

    // Get all messages from thread
    final response = await http.get(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/medical_communications/$threadId/messages.json'),
    );

    if (response.statusCode == 200 && response.body != 'null') {
      final messagesMap = json.decode(response.body) as Map<String, dynamic>;
      List<dynamic> allMessages = [];

      // Convert to list format
      messagesMap.forEach((messageId, messageData) {
        final data = messageData as Map<String, dynamic>;
        final messageMap = {
          'text': data['text'] ?? '',
          'audioUrl': data['audioUrl'] ?? '',
          'isUser': data['sender'] == 'patient',
          'timestamp':
              DateTime.fromMillisecondsSinceEpoch(data['createdAt'] ?? 0),
          'language': data['language'] ?? 'english'
        };
        allMessages.add(messageMap);
      });

      // Sort by timestamp
      allMessages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
      return allMessages;
    }

    return [];
  } catch (e) {
    print('Error loading new responses: $e');
    return [];
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
