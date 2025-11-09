import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'vitals_monitor_screen_widget.dart' show VitalsMonitorScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class VitalsMonitorScreenModel
    extends FlutterFlowModel<VitalsMonitorScreenWidget> {
  ///  Local state fields for this page.

  bool vitalsMonitoringActive = false;

  DateTime? lastUpdateTime;

  String? connectionError;

  int pollingInterval = 5;

  String? vitalsHistoryString;

  bool historyLoading = false;

  String selectedTimeRange = '24h';

  String? patientId;

  String? deviceId;

  String? currentVitalsJson;

  dynamic currentVitals;

  bool isLoading = false;

  double? editHR;

  double? editTemp;

  double? editSys;

  double? editDia;

  double? editFHR;

  double? editWeight;

  bool isEditingHR = false;

  bool isEditingTemp = false;

  bool isEditingBP = false;

  bool isEditingFHR = false;

  bool isEditingWeight = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - normalizePatientId] action in VitalsMonitorScreen widget.
  String? normPid;
  // Stores action output result for [Custom Action - fetchCurrentRiskScore] action in VitalsMonitorScreen widget.
  dynamic? riskScore;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Custom Action - getCurrentVitalsREST] action in Column widget.
  String? refreshedVitalsData;
  // Stores action output result for [Custom Action - getCurrentVitalsREST] action in Button widget.
  String? initialVitalsData;
  // Stores action output result for [Custom Action - fetchCurrentRiskScore] action in Container widget.
  dynamic? result;
  // State field(s) for editHR widget.
  FocusNode? editHRFocusNode;
  TextEditingController? editHRTextController;
  String? Function(BuildContext, String?)? editHRTextControllerValidator;
  // Stores action output result for [Backend Call - API (PatchDeviceVitalValue)] action in Button widget.
  ApiCallResponse? patchHR;
  // State field(s) for editFHR widget.
  FocusNode? editFHRFocusNode;
  TextEditingController? editFHRTextController;
  String? Function(BuildContext, String?)? editFHRTextControllerValidator;
  // Stores action output result for [Backend Call - API (PatchDeviceVitalValue)] action in Button widget.
  ApiCallResponse? patchFHR;
  // State field(s) for editTemp widget.
  FocusNode? editTempFocusNode;
  TextEditingController? editTempTextController;
  String? Function(BuildContext, String?)? editTempTextControllerValidator;
  // Stores action output result for [Backend Call - API (PatchDeviceVitalValue)] action in Button widget.
  ApiCallResponse? patchTemp;
  // State field(s) for editSys widget.
  FocusNode? editSysFocusNode;
  TextEditingController? editSysTextController;
  String? Function(BuildContext, String?)? editSysTextControllerValidator;
  // State field(s) for editDia widget.
  FocusNode? editDiaFocusNode;
  TextEditingController? editDiaTextController;
  String? Function(BuildContext, String?)? editDiaTextControllerValidator;
  // Stores action output result for [Backend Call - API (PatchDeviceVitalValueSys)] action in Button widget.
  ApiCallResponse? patchSys;
  // Stores action output result for [Backend Call - API (PatchDeviceVitalValueDia)] action in Button widget.
  ApiCallResponse? patchDia;
  // State field(s) for editWeight widget.
  FocusNode? editWeightFocusNode;
  TextEditingController? editWeightTextController;
  String? Function(BuildContext, String?)? editWeightTextControllerValidator;
  // Stores action output result for [Backend Call - API (PatchDeviceVitalValue)] action in Button widget.
  ApiCallResponse? patchWeight;
  // Stores action output result for [Custom Action - getCurrentVitalsREST] action in Column widget.
  String? historyDataString;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    editHRFocusNode?.dispose();
    editHRTextController?.dispose();

    editFHRFocusNode?.dispose();
    editFHRTextController?.dispose();

    editTempFocusNode?.dispose();
    editTempTextController?.dispose();

    editSysFocusNode?.dispose();
    editSysTextController?.dispose();

    editDiaFocusNode?.dispose();
    editDiaTextController?.dispose();

    editWeightFocusNode?.dispose();
    editWeightTextController?.dispose();
  }
}
