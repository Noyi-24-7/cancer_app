import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'translation_screen_widget.dart' show TranslationScreenWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class TranslationScreenModel extends FlutterFlowModel<TranslationScreenWidget> {
  ///  Local state fields for this page.

  String? transcribedText;

  String? translatedText;

  String? audioUrl =
      'https://storage.googleapis.com/buildship-1pz4ke-us-central1/voice-translations/output/translation-1754378489422.m4a';

  bool isProcessing = false;

  bool isRecording = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for sourceLanguageDropdown widget.
  String? sourceLanguageDropdownValue;
  FormFieldController<String>? sourceLanguageDropdownValueController;
  // State field(s) for targetLanguageDropdown widget.
  String? targetLanguageDropdownValue;
  FormFieldController<String>? targetLanguageDropdownValueController;
  String? recordedAudio;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  // Stores action output result for [Custom Action - audioToBase64] action in FloatingActionButton widget.
  String? audioBase64;
  // Stores action output result for [Backend Call - API (TranslateVoice )] action in FloatingActionButton widget.
  ApiCallResponse? apiResultf49;
  AudioRecorder? audioRecorder;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
