import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'edit_profile_screen_widget.dart' show EditProfileScreenWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfileScreenModel extends FlutterFlowModel<EditProfileScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for age widget.
  FocusNode? ageFocusNode;
  TextEditingController? ageTextController;
  String? Function(BuildContext, String?)? ageTextControllerValidator;
  // State field(s) for gender widget.
  String? genderValue;
  FormFieldController<String>? genderValueController;
  // State field(s) for language widget.
  String? languageValue;
  FormFieldController<String>? languageValueController;
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
  // State field(s) for state widget.
  String? stateValue;
  FormFieldController<String>? stateValueController;
  // State field(s) for lga widget.
  String? lgaValue;
  FormFieldController<String>? lgaValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    ageFocusNode?.dispose();
    ageTextController?.dispose();

    allergiesFocusNode?.dispose();
    allergiesTextController?.dispose();

    medicationsFocusNode?.dispose();
    medicationsTextController?.dispose();

    conditionsFocusNode?.dispose();
    conditionsTextController?.dispose();
  }
}
