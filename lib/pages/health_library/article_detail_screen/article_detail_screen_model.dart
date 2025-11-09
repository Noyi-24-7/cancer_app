import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
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
import 'article_detail_screen_widget.dart' show ArticleDetailScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ArticleDetailScreenModel
    extends FlutterFlowModel<ArticleDetailScreenWidget> {
  ///  Local state fields for this page.

  String? translatedContent = '';

  String? audioUrl = '';

  bool isGeneratingAudio = false;

  String selectedLanguage = 'en';

  bool isTranslating = false;

  String? translatedTitle;

  bool canViewAudio = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for languageDropdown widget.
  String? languageDropdownValue;
  FormFieldController<String>? languageDropdownValueController;
  // Stores action output result for [Custom Action - prepareArticleForAudio] action in languageDropdown widget.
  String? articleJsonString;
  // Stores action output result for [Backend Call - API (ContentProcessorAPI)] action in languageDropdown widget.
  ApiCallResponse? translationResponse;
  // Stores action output result for [Custom Action - extractTranslatedData] action in languageDropdown widget.
  dynamic? extractedData;
  // Stores action output result for [Custom Action - prepareArticleForAudio] action in IconButton widget.
  String? audioArticleJson;
  // Stores action output result for [Backend Call - API (ContentProcessorAPI)] action in IconButton widget.
  ApiCallResponse? audioResponse;
  // Stores action output result for [Custom Action - extractAudioUrl] action in IconButton widget.
  String? extractedAudioUrl;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
