import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/comp_cont/voice_message_bubble_doc/voice_message_bubble_doc_widget.dart';
import '/comp_cont/voice_message_bubble_patient/voice_message_bubble_patient_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'doctor_patient_chat_widget.dart' show DoctorPatientChatWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class DoctorPatientChatModel extends FlutterFlowModel<DoctorPatientChatWidget> {
  ///  Local state fields for this page.

  List<ChatMessageStruct> messages = [];
  void addToMessages(ChatMessageStruct item) => messages.add(item);
  void removeFromMessages(ChatMessageStruct item) => messages.remove(item);
  void removeAtIndexFromMessages(int index) => messages.removeAt(index);
  void insertAtIndexInMessages(int index, ChatMessageStruct item) =>
      messages.insert(index, item);
  void updateMessagesAtIndex(int index, Function(ChatMessageStruct) updateFn) =>
      messages[index] = updateFn(messages[index]);

  bool isRecording = false;

  bool isProcessing = false;

  String currentThreadId = '\"temp_thread\"';

  bool includeVitals = false;

  int messageCount = 0;

  bool pollingActive = false;

  String? uploadedAudioUrl;

  String? translatedText;

  String? currentVitalsJson;

  List<dynamic> parsedCurrentMessage = [];
  void addToParsedCurrentMessage(dynamic item) =>
      parsedCurrentMessage.add(item);
  void removeFromParsedCurrentMessage(dynamic item) =>
      parsedCurrentMessage.remove(item);
  void removeAtIndexFromParsedCurrentMessage(int index) =>
      parsedCurrentMessage.removeAt(index);
  void insertAtIndexInParsedCurrentMessage(int index, dynamic item) =>
      parsedCurrentMessage.insert(index, item);
  void updateParsedCurrentMessageAtIndex(
          int index, Function(dynamic) updateFn) =>
      parsedCurrentMessage[index] = updateFn(parsedCurrentMessage[index]);

  String? originalText;

  int? nowMs;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - normalizePatientId] action in DoctorPatientChat widget.
  String? normPid;
  // Stores action output result for [Backend Call - API (GetAssignedDoctor)] action in DoctorPatientChat widget.
  ApiCallResponse? assignmentBody;
  // Stores action output result for [Custom Action - buildThreadIdAct] action in DoctorPatientChat widget.
  String? threadIdVal;
  // Stores action output result for [Backend Call - API (GetThreadMessages)] action in DoctorPatientChat widget.
  ApiCallResponse? msgBody;
  // Stores action output result for [Custom Action - buildMessagesForUI] action in DoctorPatientChat widget.
  String? msgsJson;
  // Stores action output result for [Custom Action - parseJsonToList] action in DoctorPatientChat widget.
  List<dynamic>? msgsList;
  // Stores action output result for [Custom Action - parseJsonToList] action in DoctorPatientChat widget.
  List<dynamic>? emptyList;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  AudioRecorder? audioRecorder;
  String? recStop;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  // Stores action output result for [Custom Action - audioToBase64] action in Container widget.
  String? b64Audio;
  // Stores action output result for [Backend Call - API (TranslateVoice )] action in Container widget.
  ApiCallResponse? transText;
  // Stores action output result for [Backend Call - API (SavePatientMessage)] action in Container widget.
  ApiCallResponse? savePatient;
  // Stores action output result for [Backend Call - API (UpdateThread)] action in Container widget.
  ApiCallResponse? update;
  // Stores action output result for [Backend Call - API (LoadMessages)] action in Container widget.
  ApiCallResponse? loadMsgs;
  // Stores action output result for [Custom Action - buildMessagesForUI] action in Container widget.
  String? normalizedJson;
  // Stores action output result for [Custom Action - parseJsonToList] action in Container widget.
  List<dynamic>? parsedList;
  // Stores action output result for [Custom Action - parseJsonToList] action in Container widget.
  List<dynamic>? empty;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {
    listViewController = ScrollController();
  }

  @override
  void dispose() {
    listViewController?.dispose();
  }
}
