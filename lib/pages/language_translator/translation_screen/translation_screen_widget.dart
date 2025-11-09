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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'translation_screen_model.dart';
export 'translation_screen_model.dart';

class TranslationScreenWidget extends StatefulWidget {
  const TranslationScreenWidget({super.key});

  static String routeName = 'TranslationScreen';
  static String routePath = '/translationScreen';

  @override
  State<TranslationScreenWidget> createState() =>
      _TranslationScreenWidgetState();
}

class _TranslationScreenWidgetState extends State<TranslationScreenWidget> {
  late TranslationScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TranslationScreenModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_model.isProcessing) {
              await stopAudioRecording(
                audioRecorder: _model.audioRecorder,
                audioName: 'recordedFileBytes',
                onRecordingComplete: (audioFilePath, audioBytes) {
                  _model.recordedAudio = audioFilePath;
                  _model.recordedFileBytes = audioBytes;
                },
              );

              await Future.delayed(
                Duration(
                  milliseconds: 500,
                ),
              );
              _model.isRecording = false;
              safeSetState(() {});
              _model.audioBase64 = await actions.audioToBase64(
                _model.recordedAudio!,
              );
              _model.isProcessing = false;
              safeSetState(() {});
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Processing translation...',
                    style: GoogleFonts.robotoCondensed(
                      color: FlutterFlowTheme.of(context).info,
                    ),
                  ),
                  duration: Duration(milliseconds: 4000),
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                ),
              );
              _model.apiResultf49 = await TranslateVoiceCall.call(
                audioFile: _model.audioBase64,
                sourceLanguage: _model.sourceLanguageDropdownValue,
                targetLanguage: _model.targetLanguageDropdownValue,
              );

              if ((_model.apiResultf49?.succeeded ?? true)) {
                _model.transcribedText = getJsonField(
                  (_model.apiResultf49?.jsonBody ?? ''),
                  r'''$.result.transcribedText''',
                ).toString();
                _model.translatedText = getJsonField(
                  (_model.apiResultf49?.jsonBody ?? ''),
                  r'''$.result.translatedText''',
                ).toString();
                _model.audioUrl = getJsonField(
                  (_model.apiResultf49?.jsonBody ?? ''),
                  r'''$.result.audioUrl.publicUrl''',
                ).toString();
                _model.isProcessing = false;
                safeSetState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      getJsonField(
                        (_model.apiResultf49?.jsonBody ?? ''),
                        r'''$.result.audioUrl.publicUrl''',
                      ).toString(),
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Gilroy',
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                          ),
                    ),
                    duration: Duration(milliseconds: 4000),
                    backgroundColor:
                        FlutterFlowTheme.of(context).micContainerBackground,
                  ),
                );
              } else {
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: Text('Translation Failed'),
                      content:
                          Text('Unable to process audio. Please try again.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(alertDialogContext),
                          child: Text('Ok'),
                        ),
                      ],
                    );
                  },
                );
                _model.isProcessing = false;
                safeSetState(() {});
              }
            } else {
              await requestPermission(microphonePermission);
              _model.isProcessing = true;
              safeSetState(() {});
              await startAudioRecording(
                context,
                audioRecorder: _model.audioRecorder ??= AudioRecorder(),
              );

              _model.isRecording = true;
              safeSetState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Recording... Release to stop',
                    style: GoogleFonts.robotoCondensed(
                      color: FlutterFlowTheme.of(context).info,
                      fontSize: 14.0,
                    ),
                  ),
                  duration: Duration(milliseconds: 10000),
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                ),
              );
            }

            safeSetState(() {});
          },
          backgroundColor: () {
            if (_model.isRecording == true) {
              return FlutterFlowTheme.of(context).darkMutedColor;
            } else if (_model.isRecording == false) {
              return FlutterFlowTheme.of(context).warning;
            } else {
              return FlutterFlowTheme.of(context).secondary;
            }
          }(),
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_model.isRecording == false)
                Icon(
                  Icons.mic,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
              if (_model.isRecording == true)
                Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).warning,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Voice Translator',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Clash Grotesk',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).aiChatBubble,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      width: 0.0,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 16.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'From',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        FlutterFlowDropDown<String>(
                          controller:
                              _model.sourceLanguageDropdownValueController ??=
                                  FormFieldController<String>(
                            _model.sourceLanguageDropdownValue ??= 'en',
                          ),
                          options: List<String>.from(['en', 'yo', 'ha', 'ig']),
                          optionLabels: ['English', 'Yoruba', 'Hausa', 'Igbo'],
                          onChanged: (val) => safeSetState(
                              () => _model.sourceLanguageDropdownValue = val),
                          width: 200.0,
                          height: 56.0,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                          hintText: 'Select...',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 0.0,
                          borderRadius: 8.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          hidesUnderline: true,
                          isOverButton: false,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).aiChatBubble,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 16.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'To',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        FlutterFlowDropDown<String>(
                          controller:
                              _model.targetLanguageDropdownValueController ??=
                                  FormFieldController<String>(
                            _model.targetLanguageDropdownValue ??= 'yo',
                          ),
                          options: List<String>.from(['en', 'yo', 'ha', 'ig']),
                          optionLabels: ['English', 'Yoruba', 'Hausa', 'Igbo'],
                          onChanged: (val) => safeSetState(
                              () => _model.targetLanguageDropdownValue = val),
                          width: 200.0,
                          height: 56.0,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                          hintText: 'Select...',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 0.0,
                          borderRadius: 8.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          hidesUnderline: true,
                          isOverButton: false,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 200.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).aiChatBubble,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          () {
                            if (_model.isRecording == false) {
                              return 'Tap Mic Button to Record';
                            } else if (_model.isRecording == true) {
                              return 'Listening, Tap Again to Stop';
                            } else if (_model.isProcessing == true) {
                              return 'AI Processing Response';
                            } else {
                              return 'Tap Mic Button to Record';
                            }
                          }(),
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            _model.translatedText,
                            'Translation will appear here',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        FlutterFlowAudioPlayer(
                          audio: Audio.network(
                            functions.stringToAudioPath(_model.audioUrl)!,
                            metas: Metas(
                              title: _model.targetLanguageDropdownValue,
                            ),
                          ),
                          titleTextStyle:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Clash Grotesk',
                                    fontSize: 0.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          playbackDurationTextStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Gilroy',
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                  ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          playbackButtonColor:
                              FlutterFlowTheme.of(context).warning,
                          activeTrackColor:
                              FlutterFlowTheme.of(context).warning,
                          inactiveTrackColor:
                              FlutterFlowTheme.of(context).alternate,
                          elevation: 0.0,
                          playInBackground:
                              PlayInBackground.disabledRestoreOnForeground,
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                ),
                if ((_model.isProcessing == true) &&
                    (_model.audioUrl == null || _model.audioUrl == ''))
                  Container(
                    width: double.infinity,
                    height: 160.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Lottie.asset(
                          'assets/jsons/Animation_-_1749020114150.json',
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.contain,
                          animate: true,
                        ),
                        Text(
                          'Processing...',
                          style:
                              FlutterFlowTheme.of(context).labelLarge.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ],
                    ),
                  ),
              ].divide(SizedBox(height: 24.0)),
            ),
          ),
        ),
      ),
    );
  }
}
