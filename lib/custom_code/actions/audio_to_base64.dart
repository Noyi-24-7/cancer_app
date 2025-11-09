// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'dart:convert';

Future<String> audioToBase64(String audioPath) async {
  try {
    print('audioToBase64 called with path: $audioPath');

    if (audioPath.isEmpty) {
      print('Audio path is empty');
      return '';
    }

    final File audioFile = File(audioPath);

    if (!audioFile.existsSync()) {
      print('File does not exist at path: $audioPath');
      return '';
    }

    // Check file size
    final fileSize = audioFile.lengthSync();
    print('File size: $fileSize bytes');

    if (fileSize == 0) {
      print('File is empty!');
      return '';
    }

    final bytes = await audioFile.readAsBytes();
    print('Read ${bytes.length} bytes');

    // Check if bytes are all zeros (common issue)
    final nonZeroBytes = bytes.where((b) => b != 0).length;
    print('Non-zero bytes: $nonZeroBytes');

    // Print first few bytes to see file signature
    if (bytes.length > 10) {
      print('First 10 bytes: ${bytes.take(10).toList()}');
    }

    final base64String = base64Encode(bytes);
    print('First 50 chars of base64: ${base64String.substring(0, 50)}');

    return base64String;
  } catch (e) {
    print('Error converting audio to base64: $e');
    return '';
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
