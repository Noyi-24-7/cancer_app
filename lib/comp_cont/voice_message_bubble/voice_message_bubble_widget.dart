import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'voice_message_bubble_model.dart';
export 'voice_message_bubble_model.dart';

/// Creating a reusable component for chat messages that shows only audio
/// players.
class VoiceMessageBubbleWidget extends StatefulWidget {
  const VoiceMessageBubbleWidget({
    super.key,
    bool? isUser,
    required this.audioUrl,
    required this.timestamp,
  }) : this.isUser = isUser ?? false;

  final bool isUser;
  final String? audioUrl;
  final DateTime? timestamp;

  @override
  State<VoiceMessageBubbleWidget> createState() =>
      _VoiceMessageBubbleWidgetState();
}

class _VoiceMessageBubbleWidgetState extends State<VoiceMessageBubbleWidget> {
  late VoiceMessageBubbleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoiceMessageBubbleModel());
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
            if (widget!.isUser == true)
              Expanded(
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 60.0,
                  ),
                  decoration: BoxDecoration(),
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Visibility(
                    visible: widget!.audioUrl != null && widget!.audioUrl != '',
                    child: FlutterFlowAudioPlayer(
                      audio: Audio.network(
                        functions.stringToAudioPath(widget!.audioUrl)!,
                        metas: Metas(),
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
                                color: () {
                                  if (widget!.isUser == false) {
                                    return FlutterFlowTheme.of(context).primary;
                                  } else if (widget!.isUser == true) {
                                    return FlutterFlowTheme.of(context).info;
                                  } else {
                                    return Color(0x00000000);
                                  }
                                }(),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                      fillColor: () {
                        if (widget!.isUser == false) {
                          return FlutterFlowTheme.of(context).aiChatBubble;
                        } else if (widget!.isUser == true) {
                          return FlutterFlowTheme.of(context).primary;
                        } else {
                          return Color(0x00000000);
                        }
                      }(),
                      playbackButtonColor: () {
                        if (widget!.isUser == false) {
                          return FlutterFlowTheme.of(context).primary;
                        } else if (widget!.isUser == true) {
                          return FlutterFlowTheme.of(context).accent1;
                        } else {
                          return Color(0x00000000);
                        }
                      }(),
                      activeTrackColor: () {
                        if (widget!.isUser == false) {
                          return FlutterFlowTheme.of(context).primary;
                        } else if (widget!.isUser == true) {
                          return FlutterFlowTheme.of(context).info;
                        } else {
                          return Color(0x00000000);
                        }
                      }(),
                      inactiveTrackColor: () {
                        if (widget!.isUser == false) {
                          return FlutterFlowTheme.of(context).accent2;
                        } else if (widget!.isUser == true) {
                          return FlutterFlowTheme.of(context).accent3;
                        } else {
                          return Color(0x00000000);
                        }
                      }(),
                      elevation: 0.0,
                      playInBackground:
                          PlayInBackground.disabledRestoreOnForeground,
                    ),
                  ),
                ),
                Text(
                  dateTimeFormat("Hm", widget!.timestamp),
                  style: FlutterFlowTheme.of(context).labelSmall.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
                ),
              ].divide(SizedBox(height: 8.0)),
            ),
            if (widget!.isUser == false)
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
