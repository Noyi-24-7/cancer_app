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
import 'dart:math';

Future<String?> assignDoctorToPatient() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.phoneNumber == null) return null;

    final phoneKey =
        'phone_${user.phoneNumber!.replaceAll('+', '').replaceAll(' ', '')}';

    // Get patient data
    final patientResponse = await http.get(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/patients/$phoneKey.json'),
    );

    if (patientResponse.statusCode != 200) return null;

    final patientData = json.decode(patientResponse.body);
    final patientState = patientData['profile']['location']['state'];
    final patientLanguage = patientData['profile']['language'];

    // Get all doctors
    final doctorsResponse = await http.get(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/doctors.json'),
    );

    if (doctorsResponse.statusCode != 200) return null;

    final doctorsData =
        json.decode(doctorsResponse.body) as Map<String, dynamic>;

    // Filter available doctors
    final availableDoctors = <String>[];

    doctorsData.forEach((doctorId, doctorInfo) {
      final capacity = doctorInfo['capacity'];
      final profile = doctorInfo['profile'];
      final availability = doctorInfo['availability'];

      // Check if doctor is available and has capacity
      if (availability['online'] == true &&
          capacity['currentPatients'] < capacity['maxPatients']) {
        // Prefer doctors in same region (optimal assignment)
        if (profile['region'] == patientState) {
          availableDoctors.insert(0, doctorId); // Add to beginning (priority)
        } else {
          availableDoctors.add(doctorId); // Add to end (fallback)
        }

        // Note: For Phase 0, only Lagos region has a matching doctor
        // Patients from other states will get assigned the Lagos doctor as fallback
      }
    });

    if (availableDoctors.isEmpty) return null;

    // Select first available doctor (prioritized by region)
    final selectedDoctorId = availableDoctors.first;
    final currentTime = DateTime.now().toIso8601String();

    // Create assignment record
    final assignmentData = {
      'doctorId': selectedDoctorId,
      'assignmentDate': currentTime,
      'assignmentReason': 'automatic_assignment',
      'status': 'active',
    };

    // Save assignment
    await http.put(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/patient_doctor_assignments/$phoneKey.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(assignmentData),
    );

    // Update patient record with assigned doctor
    await http.patch(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/patients/$phoneKey.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'assignedDoctor': selectedDoctorId,
        'assignmentDate': currentTime,
      }),
    );

    // Update doctor's patient count
    final doctorInfo = doctorsData[selectedDoctorId];
    final newPatientCount =
        (doctorInfo['capacity']['currentPatients'] as int) + 1;

    await http.patch(
      Uri.parse(
          'https://preggos-dea93-default-rtdb.firebaseio.com/doctors/$selectedDoctorId/capacity.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'currentPatients': newPatientCount}),
    );

    return selectedDoctorId;
  } catch (e) {
    print('Error assigning doctor: $e');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
