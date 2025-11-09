import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'registration_complete_screen_model.dart';
export 'registration_complete_screen_model.dart';

class RegistrationCompleteScreenWidget extends StatefulWidget {
  const RegistrationCompleteScreenWidget({super.key});

  static String routeName = 'RegistrationCompleteScreen';
  static String routePath = '/registrationCompleteScreen';

  @override
  State<RegistrationCompleteScreenWidget> createState() =>
      _RegistrationCompleteScreenWidgetState();
}

class _RegistrationCompleteScreenWidgetState
    extends State<RegistrationCompleteScreenWidget> {
  late RegistrationCompleteScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegistrationCompleteScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.assignDoctorToPatient = await actions.assignDoctorToPatient();
      if (_model.assignDoctorToPatient != null &&
          _model.assignDoctorToPatient != '') {
        _model.getDoctorInfo = await actions.getDoctorInfo(
          _model.assignDoctorToPatient!,
        );
        _model.assignedDoctorInfo = _model.getDoctorInfo;
        safeSetState(() {});
        _model.assignmentComplete = true;
        safeSetState(() {});
        await Future.delayed(
          Duration(
            milliseconds: 3000,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Unable to assign doctor. Please try again.',
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
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
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'REGISTRATION COMPLETE',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Clash Grotesk',
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    'We’re assigning you a doctor...',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Gilroy',
                                          letterSpacing: 0.0,
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                          if (_model.assignmentComplete == false)
                            CircularPercentIndicator(
                              percent: 1.0,
                              radius: 20.0,
                              lineWidth: 4.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor:
                                  FlutterFlowTheme.of(context).primary,
                              backgroundColor:
                                  FlutterFlowTheme.of(context).accent4,
                            ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Text(
                                  'This may take a few moments while we find the best doctor for your location and language preferences.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Gilroy',
                                        letterSpacing: 0.0,
                                        lineHeight: 1.5,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 64.0)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (_model.assignmentComplete == true)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getJsonField(
                                  _model.getDoctorInfo,
                                  r'''$.profile.name''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'Clash Grotesk',
                                      letterSpacing: 0.0,
                                      lineHeight: 1.5,
                                    ),
                              ),
                              Text(
                                getJsonField(
                                  _model.assignedDoctorInfo,
                                  r'''$.profile.specialization''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Gilroy',
                                      letterSpacing: 0.0,
                                      lineHeight: 1.5,
                                    ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ),
                      ),
                    if (_model.assignmentComplete == true)
                      FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(HomeScreenWidget.routeName);
                        },
                        text: 'START USING PREGGOS',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 43.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Clash Grotesk',
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.2,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
              if (_model.assignmentComplete == false)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.assignDoctorToPatientBtn =
                          await actions.assignDoctorToPatient();
                      if (_model.assignDoctorToPatientBtn != null &&
                          _model.assignDoctorToPatientBtn != '') {
                        _model.getDoctorInfoBtn = await actions.getDoctorInfo(
                          _model.assignDoctorToPatient!,
                        );
                        _model.assignedDoctorInfo = _model.getDoctorInfoBtn;
                        safeSetState(() {});
                        _model.assignmentComplete = true;
                        safeSetState(() {});
                        await Future.delayed(
                          Duration(
                            milliseconds: 3000,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Unable to assign doctor. Please try again.',
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

                      safeSetState(() {});
                    },
                    text: 'RETRY',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 43.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleLarge.override(
                                fontFamily: 'Clash Grotesk',
                                color: FlutterFlowTheme.of(context).info,
                                letterSpacing: 0.0,
                                lineHeight: 1.2,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
            ].divide(SizedBox(height: 40.0)),
          ),
        ),
      ),
    );
  }
}
