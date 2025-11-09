import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'emergency_contacts_screen_widget.dart'
    show EmergencyContactsScreenWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmergencyContactsScreenModel
    extends FlutterFlowModel<EmergencyContactsScreenWidget> {
  ///  Local state fields for this page.
  /// Controls visibility of secondary contact fields
  bool showSecondaryContact = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for primaryName widget.
  FocusNode? primaryNameFocusNode;
  TextEditingController? primaryNameTextController;
  String? Function(BuildContext, String?)? primaryNameTextControllerValidator;
  // State field(s) for primaryRelationship widget.
  String? primaryRelationshipValue;
  FormFieldController<String>? primaryRelationshipValueController;
  // State field(s) for primaryPhone widget.
  FocusNode? primaryPhoneFocusNode;
  TextEditingController? primaryPhoneTextController;
  String? Function(BuildContext, String?)? primaryPhoneTextControllerValidator;
  // Stores action output result for [Custom Action - saveEmergencyContacts] action in Button widget.
  bool? saveEmergencyContacts;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    primaryNameFocusNode?.dispose();
    primaryNameTextController?.dispose();

    primaryPhoneFocusNode?.dispose();
    primaryPhoneTextController?.dispose();
  }
}
