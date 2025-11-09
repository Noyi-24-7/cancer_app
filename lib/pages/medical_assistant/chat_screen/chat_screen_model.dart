import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/comp_cont/voice_message_bubble/voice_message_bubble_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'chat_screen_widget.dart' show ChatScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class ChatScreenModel extends FlutterFlowModel<ChatScreenWidget> {
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

  ///  State fields for stateful widgets in this page.

  // State field(s) for ListView widget.
  ScrollController? listViewController;
  AudioRecorder? audioRecorder;
  String? recordedAudioPath;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  // Stores action output result for [Custom Action - audioToBase64] action in Container widget.
  String? audioBase64;
  // Stores action output result for [Custom Action - formatMessagesForAPI] action in Container widget.
  String? currentHistory;
  // Stores action output result for [Backend Call - API (PregnancyAssistant)] action in Container widget.
  ApiCallResponse? apiResponse;

  @override
  void initState(BuildContext context) {
    listViewController = ScrollController();
  }

  @override
  void dispose() {
    listViewController?.dispose();
  }
}
