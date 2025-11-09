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
import 'dart:math' as math;

String formatMessagesForAPI(List<ChatMessageStruct>? messages) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (messages == null || messages.isEmpty) {
    return '[]';
  }

  // Take last 8 messages to avoid token limits
  final recentMessages =
      messages.length > 8 ? messages.sublist(messages.length - 8) : messages;

  List<Map<String, dynamic>> formattedMessages = [];

  for (var message in recentMessages) {
    formattedMessages.add({
      'text': message.text ?? '',
      'isUser': message.isUser ?? false,
    });
  }

  // Convert to JSON string
  return json.encode(formattedMessages);

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
