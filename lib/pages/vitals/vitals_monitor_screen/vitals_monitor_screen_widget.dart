import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'vitals_monitor_screen_model.dart';
export 'vitals_monitor_screen_model.dart';

class VitalsMonitorScreenWidget extends StatefulWidget {
  const VitalsMonitorScreenWidget({super.key});

  static String routeName = 'VitalsMonitorScreen';
  static String routePath = '/vitalsMonitorScreen';

  @override
  State<VitalsMonitorScreenWidget> createState() =>
      _VitalsMonitorScreenWidgetState();
}

class _VitalsMonitorScreenWidgetState extends State<VitalsMonitorScreenWidget>
    with TickerProviderStateMixin {
  late VitalsMonitorScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VitalsMonitorScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().patientPhoneId = currentPhoneNumber;
      safeSetState(() {});
      _model.normPid = await actions.normalizePatientId(
        FFAppState().patientPhoneId,
      );
      FFAppState().patientPhoneId = _model.normPid!;
      safeSetState(() {});
      _model.riskScore = await actions.fetchCurrentRiskScore(
        FFAppState().patientPhoneId,
      );
      FFAppState().currentRiskData = _model.riskScore!;
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.editHRTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      functions.parseVitalsDataString(
          FFAppState().currentVitalsData, 'heartRate'),
      '--',
    ));
    _model.editHRFocusNode ??= FocusNode();

    _model.editFHRTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      functions.parseVitalsDataString(
          FFAppState().currentVitalsData, 'fetalHeartRate'),
      '--',
    ));
    _model.editFHRFocusNode ??= FocusNode();

    _model.editTempTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      functions.parseVitalsDataString(
          FFAppState().currentVitalsData, 'temperature'),
      '--',
    ));
    _model.editTempFocusNode ??= FocusNode();

    _model.editSysTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      functions.parseVitalsDataString(
          FFAppState().currentVitalsData, 'systolic'),
      '--',
    ));
    _model.editSysFocusNode ??= FocusNode();

    _model.editDiaTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      functions.parseVitalsDataString(
          FFAppState().currentVitalsData, 'diastolic'),
      '--',
    ));
    _model.editDiaFocusNode ??= FocusNode();

    _model.editWeightTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      getJsonField(
        _model.currentVitals,
        r'''$.vitals.weight.value''',
      )?.toString(),
      '--',
    ));
    _model.editWeightFocusNode ??= FocusNode();
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
                                  'Vitals Monitor',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Gilroy',
                                        letterSpacing: 0.0,
                                        lineHeight: 1.3,
                                      ),
                                ),
                                Text(
                                  FFAppState().vitalsConnectionStatus ==
                                          'connected'
                                      ? 'Live Monitoring Active'
                                      : 'Not Monitoring',
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
                      Builder(
                        builder: (context) {
                          if (FFAppState().vitalsConnectionStatus ==
                              'connected') {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/Wifi_Connected.png',
                                width: 36.0,
                                height: 36.0,
                                fit: BoxFit.contain,
                              ),
                            );
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/Wifi_Not_Connected.png',
                                width: 36.0,
                                height: 36.0,
                                fit: BoxFit.contain,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(0.0, 0),
                      child: TabBar(
                        labelColor: FlutterFlowTheme.of(context).primaryText,
                        unselectedLabelColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        labelStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Gilroy',
                                  letterSpacing: 0.0,
                                ),
                        unselectedLabelStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Gilroy',
                                  letterSpacing: 0.0,
                                ),
                        indicatorColor: FlutterFlowTheme.of(context).primary,
                        tabs: [
                          Tab(
                            text: 'Live Vitals',
                          ),
                          Tab(
                            text: 'History',
                          ),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}][i]();
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    _model.refreshedVitalsData =
                                        await actions.getCurrentVitalsREST(
                                      FFAppState().vitalsDeviceId,
                                      FFAppState().firebaseRestApiUrl,
                                    );
                                    if (_model.refreshedVitalsData != null &&
                                        _model.refreshedVitalsData != '') {
                                      FFAppState().currentVitalsData =
                                          _model.refreshedVitalsData!;
                                      safeSetState(() {});
                                      _model.lastUpdateTime =
                                          getCurrentTimestamp;
                                      safeSetState(() {});
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'No new vitals data available',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Gilroy',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .micContainerBackground,
                                        ),
                                      );
                                    }
                                  },
                                  child: SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .micContainerBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        1000.0),
                                                            child: Image.asset(
                                                              'assets/images/Covid_pregnant_woman_1.png',
                                                              width: 80.0,
                                                              height: 80.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Device Status',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            letterSpacing:
                                                                                0.0,
                                                                            lineHeight:
                                                                                1.5,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      'PREGGOS KIT',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Clash Grotesk',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            lineHeight:
                                                                                1.2,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    if (FFAppState()
                                                                            .vitalsConnectionStatus ==
                                                                        'connected') {
                                                                      return Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/Wifi_Connected_Small.png',
                                                                              width: 16.0,
                                                                              height: 16.0,
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Connected',
                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                  fontFamily: 'Gilroy',
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  letterSpacing: 0.0,
                                                                                  lineHeight: 1.2,
                                                                                ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 4.0)),
                                                                      );
                                                                    } else if (FFAppState()
                                                                            .vitalsConnectionStatus ==
                                                                        'connecting') {
                                                                      return Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/Wifi_Disconnected_Small.png',
                                                                              width: 16.0,
                                                                              height: 16.0,
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Connecting...',
                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                  fontFamily: 'Gilroy',
                                                                                  letterSpacing: 0.0,
                                                                                  lineHeight: 1.2,
                                                                                ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 4.0)),
                                                                      );
                                                                    } else {
                                                                      return Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/Wifi_Disconnected_Small.png',
                                                                              width: 16.0,
                                                                              height: 16.0,
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Disconnected',
                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                  fontFamily: 'Gilroy',
                                                                                  letterSpacing: 0.0,
                                                                                  lineHeight: 1.2,
                                                                                ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 4.0)),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      12.0)),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 16.0)),
                                                      ),
                                                      Builder(
                                                        builder: (context) {
                                                          if (_model
                                                                  .vitalsMonitoringActive ==
                                                              true) {
                                                            return FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                await actions
                                                                    .stopVitalsMonitoringREST();
                                                                _model.vitalsMonitoringActive =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                _model.lastUpdateTime =
                                                                    null;
                                                                _model.connectionError =
                                                                    '';
                                                                safeSetState(
                                                                    () {});
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Stopped vitals monitoring.',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .micContainerBackground,
                                                                  ),
                                                                );
                                                              },
                                                              text:
                                                                  'DISCONNECT',
                                                              options:
                                                                  FFButtonOptions(
                                                                width: double
                                                                    .infinity,
                                                                height: 30.0,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            );
                                                          } else {
                                                            return FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                _model.vitalsMonitoringActive =
                                                                    true;
                                                                safeSetState(
                                                                    () {});
                                                                FFAppState()
                                                                        .vitalsConnectionStatus =
                                                                    'connecting';
                                                                safeSetState(
                                                                    () {});
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Starting vitals monitoring...',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .micContainerBackground,
                                                                  ),
                                                                );
                                                                _model.initialVitalsData =
                                                                    await actions
                                                                        .getCurrentVitalsREST(
                                                                  FFAppState()
                                                                      .vitalsDeviceId,
                                                                  FFAppState()
                                                                      .firebaseRestApiUrl,
                                                                );
                                                                if (_model.initialVitalsData !=
                                                                        null &&
                                                                    _model.initialVitalsData !=
                                                                        '') {
                                                                  FFAppState()
                                                                          .currentVitalsData =
                                                                      _model
                                                                          .initialVitalsData!;
                                                                  safeSetState(
                                                                      () {});
                                                                  FFAppState()
                                                                          .vitalsConnectionStatus =
                                                                      'connected';
                                                                  safeSetState(
                                                                      () {});
                                                                  _model.lastUpdateTime =
                                                                      getCurrentTimestamp;
                                                                  safeSetState(
                                                                      () {});
                                                                  _model.connectionError =
                                                                      '';
                                                                  safeSetState(
                                                                      () {});
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .hideCurrentSnackBar();
                                                                } else {
                                                                  FFAppState()
                                                                          .vitalsConnectionStatus =
                                                                      'no_data';
                                                                  safeSetState(
                                                                      () {});
                                                                  _model.connectionError =
                                                                      'No vitals data found.';
                                                                  safeSetState(
                                                                      () {});
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .hideCurrentSnackBar();
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            'No vitals data'),
                                                                        content:
                                                                            Text('No vitals data was found for this device. Make sure the device is online and uploading data to Firebase.'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                            child:
                                                                                Text('Ok'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                }

                                                                await actions
                                                                    .startVitalsMonitoringREST(
                                                                  FFAppState()
                                                                      .vitalsDeviceId,
                                                                  FFAppState()
                                                                      .firebaseRestApiUrl,
                                                                  _model
                                                                      .pollingInterval,
                                                                );

                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              text: 'CONNECT',
                                                              options:
                                                                  FFButtonOptions(
                                                                width: double
                                                                    .infinity,
                                                                height: 30.0,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 16.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: GridView(
                                                      padding: EdgeInsets.zero,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 16.0,
                                                        mainAxisSpacing: 16.0,
                                                        childAspectRatio: 0.7,
                                                      ),
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .micContainerBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Maternal HR',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            functions.parseVitalsDataString(FFAppState().currentVitalsData,
                                                                                'heartRate'),
                                                                            '--',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Clash Grotesk',
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          'bpm',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .override(
                                                                                fontFamily: 'Gilroy',
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'normal') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).success,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'high') {
                                                                              return Icon(
                                                                                Icons.warning_rounded,
                                                                                color: FlutterFlowTheme.of(context).warning,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'low') {
                                                                              return Icon(
                                                                                Icons.error_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'critical') {
                                                                              return Icon(
                                                                                Icons.dangerous_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'default') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            } else {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 2.0)),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Maternal_HR.png',
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        104.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.isEditingHR =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text:
                                                                      'INPUT VALUES',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        30.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Clash Grotesk',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .micContainerBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Fetal HR',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            functions.parseVitalsDataString(FFAppState().currentVitalsData,
                                                                                'fetalHeartRate'),
                                                                            '--',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Clash Grotesk',
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          'bpm',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .override(
                                                                                fontFamily: 'Gilroy',
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'normal') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).success,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'high') {
                                                                              return Icon(
                                                                                Icons.warning_rounded,
                                                                                color: FlutterFlowTheme.of(context).warning,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'low') {
                                                                              return Icon(
                                                                                Icons.error_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'critical') {
                                                                              return Icon(
                                                                                Icons.dangerous_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'default') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            } else {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 2.0)),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Fetal_HR.png',
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        104.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.isEditingFHR =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text:
                                                                      'INPUT VALUES',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        30.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Clash Grotesk',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .micContainerBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Fetal Movement',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            functions.parseVitalsDataString(FFAppState().currentVitalsData,
                                                                                'fetalMovement'),
                                                                            '--',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Clash Grotesk',
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          'bpm',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .override(
                                                                                fontFamily: 'Gilroy',
                                                                                color: Color(0x00A2A2A2),
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'normal') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).success,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'high') {
                                                                              return Icon(
                                                                                Icons.warning_rounded,
                                                                                color: FlutterFlowTheme.of(context).warning,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'low') {
                                                                              return Icon(
                                                                                Icons.error_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'critical') {
                                                                              return Icon(
                                                                                Icons.dangerous_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'default') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            } else {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 2.0)),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Fetal_HR.png',
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        104.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .micContainerBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Temprature',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            functions.parseVitalsDataString(FFAppState().currentVitalsData,
                                                                                'temperature'),
                                                                            '--',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Clash Grotesk',
                                                                                color: Color(0xFFD07F22),
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          '°F',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .override(
                                                                                fontFamily: 'Gilroy',
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'normal') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).success,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'high') {
                                                                              return Icon(
                                                                                Icons.warning_rounded,
                                                                                color: FlutterFlowTheme.of(context).warning,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'low') {
                                                                              return Icon(
                                                                                Icons.error_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'critical') {
                                                                              return Icon(
                                                                                Icons.dangerous_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'default') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            } else {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 2.0)),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Temprature.png',
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        104.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.isEditingTemp =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text:
                                                                      'INPUT VALUES',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        30.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Clash Grotesk',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .micContainerBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Blood Pressure',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            '${valueOrDefault<String>(
                                                                              functions.parseVitalsDataString(FFAppState().currentVitalsData, 'systolic'),
                                                                              '160',
                                                                            )}/${valueOrDefault<String>(
                                                                              functions.parseVitalsDataString(FFAppState().currentVitalsData, 'diastolic'),
                                                                              '95',
                                                                            )}',
                                                                            '--/--',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Clash Grotesk',
                                                                                color: Color(0xFF22D096),
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          'mmHg',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .override(
                                                                                fontFamily: 'Gilroy',
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'normal') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).success,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'high') {
                                                                              return Icon(
                                                                                Icons.warning_rounded,
                                                                                color: FlutterFlowTheme.of(context).warning,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'low') {
                                                                              return Icon(
                                                                                Icons.error_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'critical') {
                                                                              return Icon(
                                                                                Icons.dangerous_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'default') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            } else {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 2.0)),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Blood_Pressure.png',
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        104.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.isEditingBP =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text:
                                                                      'INPUT VALUES',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        30.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Clash Grotesk',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .micContainerBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Weight',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            functions.parseVitalsDataString(FFAppState().currentVitalsData,
                                                                                'weight'),
                                                                            '--',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Clash Grotesk',
                                                                                color: Color(0xFF22D096),
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          'kg',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .override(
                                                                                fontFamily: 'Gilroy',
                                                                                letterSpacing: 0.0,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'normal') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).success,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'high') {
                                                                              return Icon(
                                                                                Icons.warning_rounded,
                                                                                color: FlutterFlowTheme.of(context).warning,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'low') {
                                                                              return Icon(
                                                                                Icons.error_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'critical') {
                                                                              return Icon(
                                                                                Icons.dangerous_rounded,
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                size: 20.0,
                                                                              );
                                                                            } else if (functions.parseVitalsDataString(FFAppState().currentVitalsData, 'heartRate') ==
                                                                                'default') {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            } else {
                                                                              return Icon(
                                                                                Icons.check_rounded,
                                                                                color: FlutterFlowTheme.of(context).micContainerBackground,
                                                                                size: 20.0,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 2.0)),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          4.0)),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Blood_Pressure.png',
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        104.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.isEditingWeight =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text:
                                                                      'INPUT VALUES',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        30.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Clash Grotesk',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Last updated:',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Gilroy',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      _model.lastUpdateTime !=
                                                              null
                                                          ? dateTimeFormat(
                                                              "jms",
                                                              getCurrentTimestamp)
                                                          : 'Never',
                                                      'Never',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Gilroy',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (_model.vitalsMonitoringActive ==
                                                true)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 12.0,
                                                      height: 12.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .success,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    1000.0),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Monitoring...',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily:
                                                                'Gilroy',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 8.0)),
                                                ),
                                              ),
                                          ].divide(SizedBox(height: 8.0)),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .micContainerBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/Med_Icon.png',
                                                      width: 40.0,
                                                      height: 40.0,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            getJsonField(
                                                              FFAppState()
                                                                  .currentRiskData,
                                                              r'''$.level''',
                                                            )?.toString(),
                                                            'No data for today',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            getJsonField(
                                                              FFAppState()
                                                                  .currentRiskData,
                                                              r'''$.overall''',
                                                            )?.toString(),
                                                            '0',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Clash Grotesk',
                                                                fontSize: 20.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight: 1.2,
                                                              ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 4.0)),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.result = await actions
                                                          .fetchCurrentRiskScore(
                                                        FFAppState()
                                                            .patientPhoneId,
                                                      );
                                                      FFAppState()
                                                              .currentRiskData =
                                                          _model.result!;
                                                      safeSetState(() {});

                                                      safeSetState(() {});
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Icon(
                                                              Icons.cached,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                          .divide(SizedBox(height: 16.0))
                                          .addToEnd(SizedBox(height: 40.0)),
                                    ),
                                  ),
                                ),
                              ),
                              if (functions.shouldShowEmergencyAlert(
                                  FFAppState().vitalsAlerts))
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 1.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFDF7F7),
                                      border: Border.all(
                                        color: Color(0xFFF4CDCD),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 24.0, 16.0, 24.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                child: Image.asset(
                                                  'assets/images/Critical_Warning.png',
                                                  width: 56.0,
                                                  height: 56.0,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'CRITICAL VITALS DETECTED',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              'Clash Grotesk',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.2,
                                                        ),
                                                  ),
                                                  Text(
                                                    'Contact medical assistance',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily: 'Gilroy',
                                                          letterSpacing: 0.0,
                                                          lineHeight: 1.5,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(height: 4.0)),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              FFAppState().vitalsAlerts =
                                                  false.toString();
                                              safeSetState(() {});
                                            },
                                            text: 'CLOSE',
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 51.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleLarge
                                                  .override(
                                                    fontFamily: 'Clash Grotesk',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    lineHeight: 1.2,
                                                  ),
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              if (_model.isEditingHR == true)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0x652E2E2F),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 1.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .micStroke,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 24.0, 16.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'UPDATE HEART RATE VITAL',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Clash Grotesk',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.2,
                                                                ),
                                                          ),
                                                          Text(
                                                            'Enter patient\'s measurement',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 4.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Maternal HR',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyLarge
                                                            .override(
                                                              fontFamily:
                                                                  'Gilroy',
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.5,
                                                            ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          controller: _model
                                                              .editHRTextController,
                                                          focusNode: _model
                                                              .editHRFocusNode,
                                                          autofocus: false,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: false,
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            hintText:
                                                                'Enter your heart rate',
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            filled: true,
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        12.0,
                                                                        12.0,
                                                                        12.0),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight: 1.5,
                                                              ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          cursorColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          enableInteractiveSelection:
                                                              true,
                                                          validator: _model
                                                              .editHRTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.isEditingHR =
                                                                false;
                                                            safeSetState(() {});
                                                          },
                                                          text: 'CANCEL',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.editHR = double
                                                                .tryParse(_model
                                                                    .editHRTextController
                                                                    .text);
                                                            safeSetState(() {});
                                                            _model.patchHR =
                                                                await PatchDeviceVitalValueCall
                                                                    .call(
                                                              deviceId:
                                                                  'VITALS_001',
                                                              jsonPath:
                                                                  'vitals/heartRate',
                                                              newValue:
                                                                  _model.editHR,
                                                            );

                                                            if ((_model.patchHR
                                                                    ?.succeeded ??
                                                                true)) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Added Successfully',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Failed to Add',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text: 'SAVE',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (_model.isEditingFHR == true)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0x652E2E2F),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 1.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .micStroke,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 24.0, 16.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'UPDATE FETAL HEART RATE VITAL',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Clash Grotesk',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.2,
                                                                ),
                                                          ),
                                                          Text(
                                                            'Enter baby\'s measurement',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 4.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Fetal HR',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyLarge
                                                            .override(
                                                              fontFamily:
                                                                  'Gilroy',
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.5,
                                                            ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          controller: _model
                                                              .editFHRTextController,
                                                          focusNode: _model
                                                              .editFHRFocusNode,
                                                          autofocus: false,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: false,
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            hintText:
                                                                'Enter your baby\'s heart rate',
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            filled: true,
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        12.0,
                                                                        12.0,
                                                                        12.0),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight: 1.5,
                                                              ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          cursorColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          enableInteractiveSelection:
                                                              true,
                                                          validator: _model
                                                              .editFHRTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.isEditingFHR =
                                                                false;
                                                            safeSetState(() {});
                                                          },
                                                          text: 'CANCEL',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.editFHR = double
                                                                .tryParse(_model
                                                                    .editFHRTextController
                                                                    .text);
                                                            safeSetState(() {});
                                                            _model.patchFHR =
                                                                await PatchDeviceVitalValueCall
                                                                    .call(
                                                              deviceId:
                                                                  'VITALS_001',
                                                              jsonPath:
                                                                  'vitals/fetalHeartRate',
                                                              newValue: _model
                                                                  .editFHR,
                                                            );

                                                            if ((_model.patchFHR
                                                                    ?.succeeded ??
                                                                true)) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Added Successfully',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Failed to Add',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text: 'SAVE',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (_model.isEditingTemp == true)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0x652E2E2F),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 1.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .micStroke,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 24.0, 16.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'UPDATE TEMPERATURE VITAL',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Clash Grotesk',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.2,
                                                                ),
                                                          ),
                                                          Text(
                                                            'Enter patient\'s measurement',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 4.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Temperature',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyLarge
                                                            .override(
                                                              fontFamily:
                                                                  'Gilroy',
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.5,
                                                            ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          controller: _model
                                                              .editTempTextController,
                                                          focusNode: _model
                                                              .editTempFocusNode,
                                                          autofocus: false,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: false,
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            hintText:
                                                                'Enter your temprature',
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            filled: true,
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        12.0,
                                                                        12.0,
                                                                        12.0),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight: 1.5,
                                                              ),
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
                                                          cursorColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          enableInteractiveSelection:
                                                              true,
                                                          validator: _model
                                                              .editTempTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.isEditingTemp =
                                                                false;
                                                            safeSetState(() {});
                                                          },
                                                          text: 'CANCEL',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.editTemp =
                                                                double.tryParse(
                                                                    _model
                                                                        .editTempTextController
                                                                        .text);
                                                            safeSetState(() {});
                                                            _model.patchTemp =
                                                                await PatchDeviceVitalValueCall
                                                                    .call(
                                                              deviceId:
                                                                  'VITALS_001',
                                                              jsonPath:
                                                                  'vitals/temperature',
                                                              newValue: _model
                                                                  .editTemp,
                                                            );

                                                            if ((_model
                                                                    .patchTemp
                                                                    ?.succeeded ??
                                                                true)) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Added Successfully',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Failed to Add',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text: 'SAVE',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (_model.isEditingBP == true)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0x652E2E2F),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 1.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .micStroke,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 24.0, 16.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'UPDATE BLOOD PRESSURE VITAL',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Clash Grotesk',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.2,
                                                                ),
                                                          ),
                                                          Text(
                                                            'Enter patient\'s measurement',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 4.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Blood Pressure',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyLarge
                                                            .override(
                                                              fontFamily:
                                                                  'Gilroy',
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.5,
                                                            ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          controller: _model
                                                              .editSysTextController,
                                                          focusNode: _model
                                                              .editSysFocusNode,
                                                          autofocus: false,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: false,
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            hintText:
                                                                'Enter your systolic',
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            filled: true,
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        12.0,
                                                                        12.0,
                                                                        12.0),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight: 1.5,
                                                              ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          cursorColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          enableInteractiveSelection:
                                                              true,
                                                          validator: _model
                                                              .editSysTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          controller: _model
                                                              .editDiaTextController,
                                                          focusNode: _model
                                                              .editDiaFocusNode,
                                                          autofocus: false,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: false,
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            hintText:
                                                                'Enter your diastolic',
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            filled: true,
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        12.0,
                                                                        12.0,
                                                                        12.0),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight: 1.5,
                                                              ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          cursorColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          enableInteractiveSelection:
                                                              true,
                                                          validator: _model
                                                              .editDiaTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.isEditingBP =
                                                                false;
                                                            safeSetState(() {});
                                                          },
                                                          text: 'CANCEL',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.editSys = double
                                                                .tryParse(_model
                                                                    .editSysTextController
                                                                    .text);
                                                            safeSetState(() {});
                                                            _model.patchSys =
                                                                await PatchDeviceVitalValueSysCall
                                                                    .call(
                                                              deviceId:
                                                                  'VITALS_001',
                                                              jsonPath:
                                                                  'vitals/bloodPressure',
                                                              newValue: _model
                                                                  .editSys,
                                                            );

                                                            if ((_model.patchSys
                                                                    ?.succeeded ??
                                                                true)) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Added Successfully',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Failed to Add',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text: 'SAVE SYS',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.editDia = double
                                                                .tryParse(_model
                                                                    .editDiaTextController
                                                                    .text);
                                                            safeSetState(() {});
                                                            _model.patchDia =
                                                                await PatchDeviceVitalValueDiaCall
                                                                    .call(
                                                              deviceId:
                                                                  'VITALS_001',
                                                              jsonPath:
                                                                  'vitals/bloodPressure',
                                                              newValue: _model
                                                                  .editDia,
                                                            );

                                                            if ((_model.patchDia
                                                                    ?.succeeded ??
                                                                true)) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Added Successfully',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Failed to Add',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text: 'SAVE DIA',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (_model.isEditingWeight == true)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0x652E2E2F),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 1.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .micStroke,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 24.0, 16.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'UPDATE WEIGHT VITAL',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Clash Grotesk',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.2,
                                                                ),
                                                          ),
                                                          Text(
                                                            'Enter patient\'s measurement',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  lineHeight:
                                                                      1.5,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 4.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Weight',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyLarge
                                                            .override(
                                                              fontFamily:
                                                                  'Gilroy',
                                                              letterSpacing:
                                                                  0.0,
                                                              lineHeight: 1.5,
                                                            ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          controller: _model
                                                              .editWeightTextController,
                                                          focusNode: _model
                                                              .editWeightFocusNode,
                                                          autofocus: false,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: false,
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            hintText:
                                                                'Enter your heart rate',
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.5,
                                                                    ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            filled: true,
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            contentPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        12.0,
                                                                        12.0,
                                                                        12.0),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                letterSpacing:
                                                                    0.0,
                                                                lineHeight: 1.5,
                                                              ),
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
                                                          cursorColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          enableInteractiveSelection:
                                                              true,
                                                          validator: _model
                                                              .editWeightTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8.0)),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.isEditingWeight =
                                                                false;
                                                            safeSetState(() {});
                                                          },
                                                          text: 'CANCEL',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.editWeight =
                                                                double.tryParse(
                                                                    _model
                                                                        .editWeightTextController
                                                                        .text);
                                                            safeSetState(() {});
                                                            _model.patchWeight =
                                                                await PatchDeviceVitalValueCall
                                                                    .call(
                                                              deviceId:
                                                                  'VITALS_001',
                                                              jsonPath:
                                                                  'vitals/weight',
                                                              newValue: _model
                                                                  .editWeight,
                                                            );

                                                            if ((_model
                                                                    .patchWeight
                                                                    ?.succeeded ??
                                                                true)) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Added Successfully',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Heart Rate Failed to Add',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Gilroy',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .micContainerBackground,
                                                                ),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text: 'SAVE',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 51.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Clash Grotesk',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      lineHeight:
                                                                          1.2,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          RefreshIndicator(
                            onRefresh: () async {
                              _model.historyLoading = true;
                              safeSetState(() {});
                              _model.historyDataString =
                                  await actions.getCurrentVitalsREST(
                                FFAppState().vitalsDeviceId,
                                FFAppState().firebaseRestApiUrl,
                              );
                              if (_model.historyDataString != null &&
                                  _model.historyDataString != '') {
                                _model.vitalsHistoryString =
                                    _model.historyDataString;
                                safeSetState(() {});
                                _model.historyLoading = false;
                                safeSetState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'History loaded',
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
                              } else {
                                _model.historyLoading = false;
                                safeSetState(() {});
                                _model.vitalsHistoryString = '\"\"';
                                safeSetState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'No history data found',
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
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'VITALS HISTORY',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                          fontFamily:
                                                              'Clash Grotesk',
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .dropDownValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.dropDownValue ??=
                                                          '24h',
                                                    ),
                                                    options: [
                                                      '1h',
                                                      '6h',
                                                      '24h',
                                                      '7d'
                                                    ],
                                                    onChanged: (val) async {
                                                      safeSetState(() => _model
                                                          .dropDownValue = val);
                                                      _model.selectedTimeRange =
                                                          _model.dropDownValue!;
                                                      safeSetState(() {});
                                                    },
                                                    width: 80.0,
                                                    height: 40.0,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Gilroy',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText: '24h',
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    elevation: 2.0,
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderWidth: 0.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    hidesUnderline: true,
                                                    isOverButton: false,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: double.infinity,
                                            constraints: BoxConstraints(
                                              minHeight: 200.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Builder(
                                                  builder: (context) {
                                                    if (_model.historyLoading ==
                                                        false) {
                                                      return Builder(
                                                        builder: (context) {
                                                          if (functions
                                                                  .getHistoryCount(
                                                                      _model
                                                                          .vitalsHistoryString!) >
                                                              0) {
                                                            return Builder(
                                                              builder:
                                                                  (context) {
                                                                final vitalsList = functions
                                                                    .generateIndexList(
                                                                        _model
                                                                            .vitalsHistoryString!)
                                                                    .toList();

                                                                return ListView
                                                                    .separated(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  primary:
                                                                      false,
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemCount:
                                                                      vitalsList
                                                                          .length,
                                                                  separatorBuilder: (_,
                                                                          __) =>
                                                                      SizedBox(
                                                                          height:
                                                                              8.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                          vitalsListIndex) {
                                                                    final vitalsListItem =
                                                                        vitalsList[
                                                                            vitalsListIndex];
                                                                    return Container(
                                                                      width:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .micContainerBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(12.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children:
                                                                              [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  functions.parseHistoryEntry(_model.vitalsHistoryString!, vitalsListIndex, 'formattedTime'),
                                                                                  style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                        fontFamily: 'Gilroy',
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                ),
                                                                                Builder(
                                                                                  builder: (context) {
                                                                                    if (functions.parseHistoryEntry(_model.vitalsHistoryString!, vitalsListIndex, 'alerts') != '0') {
                                                                                      return Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.warning,
                                                                                            color: FlutterFlowTheme.of(context).warning,
                                                                                            size: 16.0,
                                                                                          ),
                                                                                          Text(
                                                                                            'Warning: ${valueOrDefault<String>(
                                                                                              functions.parseHistoryEntry(_model.vitalsHistoryString!, vitalsListIndex, 'alerts'),
                                                                                              'Warning',
                                                                                            )}',
                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                  fontFamily: 'Gilroy',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 4.0)),
                                                                                      );
                                                                                    } else {
                                                                                      return Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.check_rounded,
                                                                                            color: FlutterFlowTheme.of(context).success,
                                                                                            size: 18.0,
                                                                                          ),
                                                                                          Text(
                                                                                            'Normal',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Gilroy',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 4.0)),
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Text(
                                                                                      'MHR',
                                                                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Gilroy',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        functions.parseHistoryEntry(_model.vitalsHistoryString!, vitalsListIndex, 'heartRate'),
                                                                                        '--',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                            fontFamily: 'Clash Grotesk',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 4.0)),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Text(
                                                                                      'FHR',
                                                                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Gilroy',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        functions.parseHistoryEntry(_model.vitalsHistoryString!, vitalsListIndex, 'fetalHeartRate'),
                                                                                        '--',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                            fontFamily: 'Clash Grotesk',
                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 4.0)),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Text(
                                                                                      'Temp',
                                                                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Gilroy',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        functions.parseHistoryEntry(_model.vitalsHistoryString!, vitalsListIndex, 'temperature'),
                                                                                        '--',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                            fontFamily: 'Clash Grotesk',
                                                                                            color: Color(0xFFD07F22),
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 4.0)),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Text(
                                                                                      'BP',
                                                                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Gilroy',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        '${functions.parseHistoryEntry(_model.vitalsHistoryString!, vitalsListIndex, 'systolic')}/${functions.parseHistoryEntry(_model.vitalsHistoryString!, vitalsListIndex, 'diastolic')}',
                                                                                        '--',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                            fontFamily: 'Clash Grotesk',
                                                                                            color: Color(0xFF22D096),
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 4.0)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ].divide(SizedBox(height: 16.0)),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          } else {
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          32.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/Covid_pregnant_woman.gif',
                                                                        width:
                                                                            80.0,
                                                                        height:
                                                                            80.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'NO VITALS HISTORY AVAILABLE',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Clash Grotesk',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      'Start monitoring to collect data',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Gilroy',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          8.0)),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      );
                                                    } else {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          CircularPercentIndicator(
                                                            percent: 0.5,
                                                            radius: 20.0,
                                                            lineWidth: 8.0,
                                                            animation: true,
                                                            animateFromLastPercent:
                                                                true,
                                                            progressColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent4,
                                                          ),
                                                          Text(
                                                            'Loading history...',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 8.0)),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]
                                            .divide(SizedBox(height: 16.0))
                                            .addToStart(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ].divide(SizedBox(height: 4.0)),
          ),
        ),
      ),
    );
  }
}
