import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'registration_complete_screen_widget.dart'
    show RegistrationCompleteScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class RegistrationCompleteScreenModel
    extends FlutterFlowModel<RegistrationCompleteScreenWidget> {
  ///  Local state fields for this page.
  /// Stores assigned doctor information
  dynamic assignedDoctorInfo;

  /// Tracks if doctor assignment is complete
  bool assignmentComplete = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - assignDoctorToPatient] action in RegistrationCompleteScreen widget.
  String? assignDoctorToPatient;
  // Stores action output result for [Custom Action - getDoctorInfo] action in RegistrationCompleteScreen widget.
  dynamic? getDoctorInfo;
  // Stores action output result for [Custom Action - assignDoctorToPatient] action in Button widget.
  String? assignDoctorToPatientBtn;
  // Stores action output result for [Custom Action - getDoctorInfo] action in Button widget.
  dynamic? getDoctorInfoBtn;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
