// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Connects to a discovered vitals device
Future<String> connectToVitalsDevice(String deviceId) async {
  try {
    // Find the device
    BluetoothDevice device = BluetoothDevice.fromId(deviceId);

    // Connect to device
    await device.connect(timeout: Duration(seconds: 15));

    // Discover services
    List<BluetoothService> services = await device.discoverServices();

    // Find our medical service
    const String MEDICAL_SERVICE_UUID = "12345678-1234-1234-1234-123456789abc";
    const String VITALS_CHARACTERISTIC_UUID =
        "87654321-4321-4321-4321-cba987654321";

    BluetoothService? medicalService;
    for (BluetoothService service in services) {
      if (service.uuid.toString().toLowerCase() ==
          MEDICAL_SERVICE_UUID.toLowerCase()) {
        medicalService = service;
        break;
      }
    }

    if (medicalService == null) {
      await device.disconnect();
      return 'error:service_not_found';
    }

    // Find vitals characteristic
    BluetoothCharacteristic? vitalsChar;
    for (BluetoothCharacteristic char in medicalService.characteristics) {
      if (char.uuid.toString().toLowerCase() ==
          VITALS_CHARACTERISTIC_UUID.toLowerCase()) {
        vitalsChar = char;
        break;
      }
    }

    if (vitalsChar == null) {
      await device.disconnect();
      return 'error:characteristic_not_found';
    }

    // Enable notifications
    await vitalsChar.setNotifyValue(true);

    return 'connected:${device.id.id}';
  } catch (e) {
    return 'error:$e';
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
