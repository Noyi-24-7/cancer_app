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
import 'package:permission_handler/permission_handler.dart';

/// Scans for medical vitals monitoring device
Future<String> scanForVitalsDevice() async {
  try {
    // Request Bluetooth permissions
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();

    // Check if Bluetooth is supported
    if (await FlutterBluePlus.isSupported == false) {
      return 'error:bluetooth_not_supported';
    }

    var adapterState = await FlutterBluePlus.adapterState.first;
    if (adapterState != BluetoothAdapterState.on) {
      return 'error:bluetooth_disabled';
    }

    // Start scanning for devices
    await FlutterBluePlus.startScan(
        timeout: Duration(seconds: 10), withNames: ["VitalsMonitor"]);

    // Listen for scan results
    await for (List<ScanResult> scanResults in FlutterBluePlus.scanResults) {
      for (ScanResult result in scanResults) {
        if (result.device.name == "VitalsMonitor") {
          await FlutterBluePlus.stopScan();
          return 'found:${result.device.id.id}';
        }
      }
    }

    await FlutterBluePlus.stopScan();
    return 'not_found';
  } catch (e) {
    return 'error:$e';
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
