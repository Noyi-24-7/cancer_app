import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'medical_history_screen_widget.dart' show MedicalHistoryScreenWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MedicalHistoryScreenModel
    extends FlutterFlowModel<MedicalHistoryScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for allergies widget.
  FocusNode? allergiesFocusNode;
  TextEditingController? allergiesTextController;
  String? Function(BuildContext, String?)? allergiesTextControllerValidator;
  // State field(s) for medications widget.
  FocusNode? medicationsFocusNode;
  TextEditingController? medicationsTextController;
  String? Function(BuildContext, String?)? medicationsTextControllerValidator;
  // State field(s) for conditions widget.
  FocusNode? conditionsFocusNode;
  TextEditingController? conditionsTextController;
  String? Function(BuildContext, String?)? conditionsTextControllerValidator;
  // State field(s) for bloodType widget.
  String? bloodTypeValue;
  FormFieldController<String>? bloodTypeValueController;
  // Stores action output result for [Custom Action - saveMedicalData] action in Button widget.
  bool? saveMedicalData;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    allergiesFocusNode?.dispose();
    allergiesTextController?.dispose();

    medicationsFocusNode?.dispose();
    medicationsTextController?.dispose();

    conditionsFocusNode?.dispose();
    conditionsTextController?.dispose();
  }
}
