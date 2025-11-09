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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'doctor_patient_chat_model.dart';
export 'doctor_patient_chat_model.dart';

class DoctorPatientChatWidget extends StatefulWidget {
  const DoctorPatientChatWidget({super.key});

  static String routeName = 'DoctorPatientChat';
  static String routePath = '/doctorPatientChat';

  @override
  State<DoctorPatientChatWidget> createState() =>
      _DoctorPatientChatWidgetState();
}

class _DoctorPatientChatWidgetState extends State<DoctorPatientChatWidget> {
  late DoctorPatientChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DoctorPatientChatModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().currentPatientId = currentPhoneNumber;
      safeSetState(() {});
      _model.normPid = await actions.normalizePatientId(
        FFAppState().currentPatientId,
      );
      _model.assignmentBody = await GetAssignedDoctorCall.call(
        patientKey: _model.normPid,
      );

      if ((_model.assignmentBody?.succeeded ?? true)) {
        FFAppState().assignedDoctorId = getJsonField(
          (_model.assignmentBody?.jsonBody ?? ''),
          r'''$.doctorId''',
        ).toString();
        FFAppState().selectedLanguage = valueOrDefault<String>(
          getJsonField(
            FFAppState().currentPatientData,
            r'''$.profile.language''',
          )?.toString(),
          'English',
        );
        safeSetState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Couldn’t find assigned doctor.',
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
        context.safePop();
      }

      _model.threadIdVal = await actions.buildThreadIdAct(
        _model.normPid!,
        FFAppState().assignedDoctorId,
      );
      _model.currentThreadId = _model.threadIdVal!;
      safeSetState(() {});
      _model.msgBody = await GetThreadMessagesCall.call(
        threadId: _model.currentThreadId,
      );

      if ((_model.msgBody?.succeeded ?? true)) {
        _model.msgsJson = await actions.buildMessagesForUI(
          (_model.msgBody?.bodyText ?? ''),
        );
        _model.msgsList = await actions.parseJsonToList(
          _model.msgsJson!,
        );
        _model.parsedCurrentMessage = _model.msgsList!.toList().cast<dynamic>();
        safeSetState(() {});
      } else {
        _model.emptyList = await actions.parseJsonToList(
          '[]',
        );
        _model.parsedCurrentMessage =
            _model.emptyList!.toList().cast<dynamic>();
        safeSetState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No messages yet.',
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
      }
    });
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
                                  'Contact Doctor',
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
                                    getJsonField(
                                      FFAppState().currentPatientData,
                                      r'''$.profile.language''',
                                    )?.toString(),
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
                    if ((_model.parsedCurrentMessage.isNotEmpty) == true) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Builder(
                            builder: (context) {
                              final messageItem =
                                  _model.parsedCurrentMessage.toList();

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: messageItem.length,
                                itemBuilder: (context, messageItemIndex) {
                                  final messageItemItem =
                                      messageItem[messageItemIndex];
                                  return Builder(
                                    builder: (context) {
                                      if (getJsonField(
                                            messageItemItem,
                                            r'''$.doctorFlag''',
                                          ) !=
                                          null) {
                                        return VoiceMessageBubbleDocWidget(
                                          key: Key(
                                              'Keytaj_${messageItemIndex}_of_${messageItem.length}'),
                                          messageData: getJsonField(
                                            messageItemItem,
                                            r'''$''',
                                          ),
                                        );
                                      } else {
                                        return VoiceMessageBubblePatientWidget(
                                          key: Key(
                                              'Keybzi_${messageItemIndex}_of_${messageItem.length}'),
                                          messageData: getJsonField(
                                            messageItemItem,
                                            r'''$''',
                                          ),
                                        );
                                      }
                                    },
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
                                        32.0, 0.0, 32.0, 0.0),
                                    child: Text(
                                      'Talk to Your Assigned Doctor',
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
                                    'No messages yet',
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
                          await startAudioRecording(
                            context,
                            audioRecorder: _model.audioRecorder ??=
                                AudioRecorder(),
                          );

                          _model.isRecording = true;
                          safeSetState(() {});
                          HapticFeedback.lightImpact();
                        } else {
                          await stopAudioRecording(
                            audioRecorder: _model.audioRecorder,
                            audioName: 'recordedFileBytes',
                            onRecordingComplete: (audioFilePath, audioBytes) {
                              _model.recStop = audioFilePath;
                              _model.recordedFileBytes = audioBytes;
                            },
                          );

                          _model.isRecording = false;
                          _model.isProcessing = true;
                          safeSetState(() {});
                          _model.b64Audio = await actions.audioToBase64(
                            _model.recStop!,
                          );
                          _model.nowMs =
                              getCurrentTimestamp.millisecondsSinceEpoch;
                          safeSetState(() {});
                          _model.transText = await TranslateVoiceCall.call(
                            audioFile: _model.b64Audio,
                            sourceLanguage: FFAppState().selectedLanguage,
                            targetLanguage: 'en',
                          );

                          if ((_model.transText?.succeeded ?? true)) {
                            _model.translatedText = getJsonField(
                              (_model.transText?.jsonBody ?? ''),
                              r'''$.result.finalText''',
                            ).toString();
                            safeSetState(() {});
                            _model.savePatient =
                                await SavePatientMessageCall.call(
                              threadId: _model.currentThreadId,
                              text: _model.translatedText,
                              audioUrl: getJsonField(
                                (_model.transText?.jsonBody ?? ''),
                                r'''$.result.audioUrl.publicUrl''',
                              ).toString(),
                              sender: 'patient',
                              language: FFAppState().selectedLanguage,
                              createdAt: _model.nowMs?.toString(),
                            );

                            if ((_model.savePatient?.succeeded ?? true)) {
                              _model.update = await UpdateThreadCall.call(
                                lastMessageAt: _model.nowMs?.toString(),
                                lastMessagePreview: _model.translatedText,
                                status: 'active',
                              );

                              if ((_model.update?.succeeded ?? true)) {
                                _model.loadMsgs = await LoadMessagesCall.call(
                                  threadId: _model.currentThreadId,
                                );

                                if ((_model.loadMsgs?.succeeded ?? true)) {
                                  _model.normalizedJson =
                                      await actions.buildMessagesForUI(
                                    (_model.loadMsgs?.bodyText ?? ''),
                                  );
                                  _model.parsedList =
                                      await actions.parseJsonToList(
                                    _model.normalizedJson!,
                                  );
                                  _model.parsedCurrentMessage = _model
                                      .parsedList!
                                      .toList()
                                      .cast<dynamic>();
                                  safeSetState(() {});
                                  await _model.listViewController?.animateTo(
                                    _model.listViewController!.position
                                        .maxScrollExtent,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.ease,
                                  );
                                  _model.isProcessing = false;
                                  safeSetState(() {});
                                } else {
                                  _model.empty = await actions.parseJsonToList(
                                    '[]',
                                  );
                                  _model.parsedCurrentMessage =
                                      _model.empty!.toList().cast<dynamic>();
                                  safeSetState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Couldn’t load messages.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'Gilroy',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .micContainerBackground,
                                    ),
                                  );
                                }
                              } else {
                                _model.isProcessing = false;
                                safeSetState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Error During Update',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Gilroy',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .micContainerBackground,
                                  ),
                                );
                              }
                            } else {
                              _model.isProcessing = false;
                              safeSetState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Error During Save',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Gilroy',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .micContainerBackground,
                                ),
                              );
                            }
                          } else {
                            _model.isProcessing = false;
                            safeSetState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Error, Failed to Translate',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Gilroy',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .micContainerBackground,
                              ),
                            );
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
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Theme(
                            data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              unselectedWidgetColor:
                                  FlutterFlowTheme.of(context).micStroke,
                            ),
                            child: Checkbox(
                              value: _model.checkboxValue ??=
                                  _model.includeVitals,
                              onChanged: (newValue) async {
                                safeSetState(
                                    () => _model.checkboxValue = newValue!);
                              },
                              side: (FlutterFlowTheme.of(context).micStroke !=
                                      null)
                                  ? BorderSide(
                                      width: 2,
                                      color: FlutterFlowTheme.of(context)
                                          .micStroke!,
                                    )
                                  : null,
                              activeColor: FlutterFlowTheme.of(context).primary,
                              checkColor: FlutterFlowTheme.of(context).info,
                            ),
                          ),
                          Text(
                            'Include current vitals with message',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: 'Gilroy',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ].divide(SizedBox(width: 4.0)),
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
