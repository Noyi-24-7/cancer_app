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

Future<List<dynamic>> processLoadedMessages(String messagesJson) async {
  try {
    if (messagesJson.isEmpty || messagesJson == 'null') {
      return [];
    }

    final messagesMap = json.decode(messagesJson) as Map<String, dynamic>;
    List<dynamic> messagesList = [];

    // Convert Firebase messages to ChatMessage-compatible maps
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

      messagesList.add(messageMap);
    });

    // Sort by timestamp (oldest first)
    messagesList.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

    return messagesList;
  } catch (e) {
    print('Error processing loaded messages: $e');
    return [];
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
