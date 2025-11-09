import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'profile_screen_widget.dart' show ProfileScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreenModel extends FlutterFlowModel<ProfileScreenWidget> {
  ///  Local state fields for this page.

  dynamic doctorInfo;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getDoctorInfo] action in ProfileScreen widget.
  dynamic? getDoctorInfo;
  // Stores action output result for [Custom Action - performLogout] action in Button widget.
  bool? performLogout;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
