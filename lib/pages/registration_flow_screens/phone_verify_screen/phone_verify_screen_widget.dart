import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'phone_verify_screen_model.dart';
export 'phone_verify_screen_model.dart';

class PhoneVerifyScreenWidget extends StatefulWidget {
  const PhoneVerifyScreenWidget({super.key});

  static String routeName = 'PhoneVerifyScreen';
  static String routePath = '/phoneVerifyScreen';

  @override
  State<PhoneVerifyScreenWidget> createState() =>
      _PhoneVerifyScreenWidgetState();
}

class _PhoneVerifyScreenWidgetState extends State<PhoneVerifyScreenWidget> {
  late PhoneVerifyScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhoneVerifyScreenModel());

    _model.pinCodeFocusNode ??= FocusNode();
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 320.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/Pregnant_Woman_&_Baby_LOGO.png',
                        width: 80.0,
                        height: 120.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ].addToEnd(SizedBox(height: 80.0)),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ENTER VERIFICATION CODE',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Clash Grotesk',
                                letterSpacing: 0.0,
                                lineHeight: 1.2,
                              ),
                        ),
                        Text(
                          'We sent a 6-digit code to ${valueOrDefault<String>(
                            currentPhoneNumber,
                            '+234 801 234 5678',
                          )}',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ].divide(SizedBox(height: 4.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PinCodeTextField(
                              autoDisposeControllers: false,
                              appContext: context,
                              length: 6,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              enableActiveFill: true,
                              autoFocus: true,
                              focusNode: _model.pinCodeFocusNode,
                              enablePinAutofill: false,
                              errorTextSpace: 16.0,
                              showCursor: true,
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              obscureText: false,
                              hintCharacter: '-',
                              keyboardType: TextInputType.number,
                              pinTheme: PinTheme(
                                fieldHeight: 48.0,
                                fieldWidth: 50.5,
                                borderWidth: 0.0,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                shape: PinCodeFieldShape.box,
                                activeColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                inactiveColor:
                                    FlutterFlowTheme.of(context).alternate,
                                selectedColor:
                                    FlutterFlowTheme.of(context).primary,
                                activeFillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                inactiveFillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                selectedFillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              controller: _model.pinCodeController,
                              onChanged: (_) {},
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: _model.pinCodeControllerValidator
                                  .asValidator(context),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                context.safePop();
                              },
                              text: 'BACK',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 43.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).accent4,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'Clash Grotesk',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.2,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                GoRouter.of(context).prepareAuthEvent();
                                final smsCodeVal =
                                    _model.pinCodeController!.text;
                                if (smsCodeVal == null || smsCodeVal.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Enter SMS verification code.'),
                                    ),
                                  );
                                  return;
                                }
                                final phoneVerifiedUser =
                                    await authManager.verifySmsCode(
                                  context: context,
                                  smsCode: smsCodeVal,
                                );
                                if (phoneVerifiedUser == null) {
                                  return;
                                }

                                await Future.delayed(
                                  Duration(
                                    milliseconds: 1200,
                                  ),
                                );

                                context.pushNamedAuth(
                                    RegistrationScreenWidget.routeName,
                                    context.mounted);
                              },
                              text: 'VERIFY & CONTINUE',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 43.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'Clash Grotesk',
                                      color: FlutterFlowTheme.of(context).info,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.2,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ].divide(SizedBox(height: 40.0)),
                ),
              ),
            ].divide(SizedBox(height: 80.0)).addToEnd(SizedBox(height: 184.0)),
          ),
        ),
      ),
    );
  }
}
