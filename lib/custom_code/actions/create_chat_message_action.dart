// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Returns a ChatMessageStruct constructed from inputs.
Future<ChatMessageStruct> createChatMessageAction(
  String text,
  String audioUrl,
  bool isUser,
  DateTime timestamp,
  String? language, // <-- nullable
  String? vitalsData, // <-- add vitals parameter
) async {
  /// MODIFY CODE ONLY BELOW THIS LINE
  final msg = ChatMessageStruct(
    text: text.trim(),
    audioUrl: audioUrl.trim(),
    isUser: isUser,
    timestamp: timestamp.toUtc(),
    // Only include language if ChatMessageStruct has this field
    language: (language != null && language.trim().isNotEmpty)
        ? language.trim()
        : null,
    // Only include vitalsData if ChatMessageStruct has this field
    vitalsData: (vitalsData != null && vitalsData.trim().isNotEmpty)
        ? vitalsData.trim()
        : null,
  );
  return msg;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
