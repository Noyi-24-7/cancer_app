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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'chat_screen_model.dart';
export 'chat_screen_model.dart';

class ChatScreenWidget extends StatefulWidget {
  const ChatScreenWidget({super.key});

  static String routeName = 'ChatScreen';
  static String routePath = '/chatScreen';

  @override
  State<ChatScreenWidget> createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends State<ChatScreenWidget> {
  late ChatScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatScreenModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(HomeScreenWidget.routeName);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.chevron_left_rounded,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Medical Assistant',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Gilroy',
                                        letterSpacing: 0.0,
                                        lineHeight: 1.3,
                                      ),
                                ),
                                Text(
                                  'Language - ${valueOrDefault<String>(
                                    FFAppState().selectedLanguageName,
                                    'English',
                                  )}',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Gilroy',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(height: 4.0)),
                            ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                      ),
                      Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: BoxDecoration(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if ((_model.messages.isNotEmpty) == true) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Builder(
                            builder: (context) {
                              final messageItem = _model.messages.toList();

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: messageItem.length,
                                itemBuilder: (context, messageItemIndex) {
                                  final messageItemItem =
                                      messageItem[messageItemIndex];
                                  return VoiceMessageBubbleWidget(
                                    key: Key(
                                        'Keyyrc_${messageItemIndex}_of_${messageItem.length}'),
                                    isUser: messageItemItem.isUser,
                                    audioUrl: messageItemItem.audioUrl,
                                    timestamp: messageItemItem.timestamp!,
                                  );
                                },
                                controller: _model.listViewController,
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFC0BEC8),
                                borderRadius: BorderRadius.circular(1000.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/Covid_pregnant_woman.gif',
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  51.0, 0.0, 51.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        36.0, 0.0, 36.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        functions.getEmptyStateText(
                                            FFAppState().selectedLanguage,
                                            'welcome'),
                                        'WELCOME TO YOUR MEDICAL ASSISTANT',
                                      ),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            fontFamily: 'Clash Grotesk',
                                            letterSpacing: 0.0,
                                            lineHeight: 1.2,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      functions.getEmptyStateText(
                                          FFAppState().selectedLanguage,
                                          'instruction'),
                                      'Ask any health question in English',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Gilroy',
                                          letterSpacing: 0.0,
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 280.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).micContainerBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                      color: Color(0x0B000000),
                      offset: Offset(
                        0.0,
                        -2.0,
                      ),
                      spreadRadius: 2.0,
                    )
                  ],
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).accent4,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        functions.getRecordingText(
                            FFAppState().selectedLanguage, () {
                          if (_model.isProcessing == true) {
                            return 'processing';
                          } else if (_model.isRecording == true) {
                            return 'listening';
                          } else {
                            return 'tap';
                          }
                        }()),
                        'Tap to record a voice message',
                      ),
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'Gilroy',
                            letterSpacing: 0.0,
                          ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (_model.isRecording == false) {
                          await requestPermission(microphonePermission);
                          _model.isRecording = true;
                          safeSetState(() {});
                          await startAudioRecording(
                            context,
                            audioRecorder: _model.audioRecorder ??=
                                AudioRecorder(),
                          );

                          HapticFeedback.lightImpact();
                        } else {
                          await stopAudioRecording(
                            audioRecorder: _model.audioRecorder,
                            audioName: 'recordedFileBytes',
                            onRecordingComplete: (audioFilePath, audioBytes) {
                              _model.recordedAudioPath = audioFilePath;
                              _model.recordedFileBytes = audioBytes;
                            },
                          );

                          _model.isRecording = false;
                          safeSetState(() {});
                          _model.isProcessing = true;
                          safeSetState(() {});
                          HapticFeedback.mediumImpact();
                          _model.audioBase64 = await actions.audioToBase64(
                            _model.recordedAudioPath!,
                          );
                          await actions.getCurrentVitalsREST(
                            '',
                            '',
                          );
                          _model.currentHistory =
                              await actions.formatMessagesForAPI(
                            _model.messages.toList(),
                          );
                          _model.apiResponse =
                              await PregnancyAssistantCall.call(
                            audioFile: _model.audioBase64,
                            sourceLanguage: FFAppState().selectedLanguage,
                            targetLanguage: FFAppState().selectedLanguage,
                            conversationHistory: _model.currentHistory,
                          );

                          if ((_model.apiResponse?.succeeded ?? true)) {
                            _model.addToMessages(ChatMessageStruct(
                              text: getJsonField(
                                (_model.apiResponse?.jsonBody ?? ''),
                                r'''$.result.transcribedText''',
                              ).toString(),
                              audioUrl: '\"\"',
                              isUser: true,
                              timestamp: getCurrentTimestamp,
                            ));
                            safeSetState(() {});
                            await Future.delayed(
                              Duration(
                                milliseconds: 1500,
                              ),
                            );
                            _model.addToMessages(ChatMessageStruct(
                              text: getJsonField(
                                (_model.apiResponse?.jsonBody ?? ''),
                                r'''$.result.translatedText''',
                              ).toString(),
                              audioUrl: getJsonField(
                                (_model.apiResponse?.jsonBody ?? ''),
                                r'''$.result.audioUrl.publicUrl''',
                              ).toString(),
                              isUser: false,
                              timestamp: getCurrentTimestamp,
                            ));
                            safeSetState(() {});
                            _model.isProcessing = false;
                            safeSetState(() {});
                            await _model.listViewController?.animateTo(
                              _model
                                  .listViewController!.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text(
                                      'Unable to process your question. Please try again.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            _model.isProcessing = false;
                            safeSetState(() {});
                          }
                        }

                        safeSetState(() {});
                      },
                      child: Container(
                        width: 136.0,
                        height: 136.0,
                        decoration: BoxDecoration(
                          color: () {
                            if (_model.isRecording == false) {
                              return FlutterFlowTheme.of(context).primary;
                            } else if (_model.isRecording == true) {
                              return FlutterFlowTheme.of(context).tertiary;
                            } else {
                              return FlutterFlowTheme.of(context).info;
                            }
                          }(),
                          borderRadius: BorderRadius.circular(1000.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_model.isRecording == false)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/adwiu_.png',
                                  width: 48.0,
                                  height: 48.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            if (_model.isRecording == true)
                              Container(
                                width: 32.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).info,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            if (_model.isProcessing == true)
                              CircularPercentIndicator(
                                percent: 1.0,
                                radius: 16.0,
                                lineWidth: 8.0,
                                animation: true,
                                animateFromLastPercent: true,
                                progressColor:
                                    FlutterFlowTheme.of(context).primary,
                                backgroundColor:
                                    FlutterFlowTheme.of(context).accent4,
                                startAngle: 16.0,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
