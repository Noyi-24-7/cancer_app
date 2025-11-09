import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'voice_message_bubble_doc_model.dart';
export 'voice_message_bubble_doc_model.dart';

/// Creating a reusable component for chat messages that shows only audio
/// players.
class VoiceMessageBubbleDocWidget extends StatefulWidget {
  const VoiceMessageBubbleDocWidget({
    super.key,
    required this.messageData,
  });

  final dynamic messageData;

  @override
  State<VoiceMessageBubbleDocWidget> createState() =>
      _VoiceMessageBubbleDocWidgetState();
}

class _VoiceMessageBubbleDocWidgetState
    extends State<VoiceMessageBubbleDocWidget> {
  late VoiceMessageBubbleDocModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoiceMessageBubbleDocModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200.0,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (getJsonField(
                        widget!.messageData,
                        r'''$.vitalsSnapshot''',
                      ) !=
                      null)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.medical_services_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 16.0,
                        ),
                        Text(
                          'Vitals included with message',
                          style:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  Container(
                    width: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: FlutterFlowAudioPlayer(
                      audio: Audio.network(
                        functions.stringToAudioPath(getJsonField(
                          widget!.messageData,
                          r'''$.audioUrl''',
                        ).toString())!,
                        metas: Metas(
                          title: 'Doc',
                        ),
                      ),
                      titleTextStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Gilroy',
                                letterSpacing: 0.0,
                              ),
                      playbackDurationTextStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Gilroy',
                                color: FlutterFlowTheme.of(context).primary,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                      fillColor: FlutterFlowTheme.of(context).aiChatBubble,
                      playbackButtonColor: FlutterFlowTheme.of(context).primary,
                      activeTrackColor: FlutterFlowTheme.of(context).primary,
                      inactiveTrackColor: FlutterFlowTheme.of(context).accent2,
                      elevation: 0.0,
                      playInBackground:
                          PlayInBackground.disabledRestoreOnForeground,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          getJsonField(
                            widget!.messageData,
                            r'''$.timestamp''',
                          ).toString(),
                          style:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ].divide(SizedBox(height: 8.0)),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: 60.0,
                ),
                decoration: BoxDecoration(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
