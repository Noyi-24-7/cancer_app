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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'article_detail_screen_model.dart';
export 'article_detail_screen_model.dart';

class ArticleDetailScreenWidget extends StatefulWidget {
  const ArticleDetailScreenWidget({
    super.key,
    required this.article,
  });

  final EducationalArticleStruct? article;

  static String routeName = 'ArticleDetailScreen';
  static String routePath = '/articleDetailScreen';

  @override
  State<ArticleDetailScreenWidget> createState() =>
      _ArticleDetailScreenWidgetState();
}

class _ArticleDetailScreenWidgetState extends State<ArticleDetailScreenWidget> {
  late ArticleDetailScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArticleDetailScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.translatedContent = widget!.article?.content;
      _model.translatedTitle = valueOrDefault<String>(
        widget!.article?.title,
        '11 safety tips for your baby\'s nursery',
      );
      safeSetState(() {});
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                border: Border.all(
                  color: FlutterFlowTheme.of(context).micStroke,
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 56.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.close_rounded,
                        color: FlutterFlowTheme.of(context).darkMutedColor,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        context.pop();
                      },
                    ),
                    Text(
                      'Insights',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Clash Grotesk',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.bookmark_border_outlined,
                        color: FlutterFlowTheme.of(context).darkMutedColor,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      height: 640.0,
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 28.0, 16.0, 12.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Language:',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily: 'Gilroy',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Expanded(
                                          child: FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .languageDropdownValueController ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: List<String>.from(
                                                ['en', 'yo', 'ha', 'ig']),
                                            optionLabels: [
                                              'English',
                                              'Yoruba',
                                              'Hausa',
                                              'Igbo'
                                            ],
                                            onChanged: (val) async {
                                              safeSetState(() => _model
                                                  .languageDropdownValue = val);
                                              _model.selectedLanguage =
                                                  _model.languageDropdownValue!;
                                              safeSetState(() {});
                                              if ((_model.languageDropdownValue !=
                                                      'en') ||
                                                  (_model.languageDropdownValue ==
                                                      'en')) {
                                                _model.isGeneratingAudio = true;
                                                _model.isTranslating = true;
                                                safeSetState(() {});
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Translating article...',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .micContainerBackground,
                                                  ),
                                                );
                                                _model.articleJsonString =
                                                    await actions
                                                        .prepareArticleForAudio(
                                                  widget!.article!.toMap(),
                                                  'null',
                                                  'null',
                                                );
                                                _model.translationResponse =
                                                    await ContentProcessorAPICall
                                                        .call(
                                                  articlesJson:
                                                      _model.articleJsonString,
                                                  targetLanguage: _model
                                                      .languageDropdownValue,
                                                  action: 'translate_only',
                                                  articleId:
                                                      widget!.article?.id,
                                                );

                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                                if ((_model.translationResponse
                                                        ?.succeeded ??
                                                    true)) {
                                                  _model.extractedData =
                                                      await actions
                                                          .extractTranslatedData(
                                                    (_model.translationResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  );
                                                  _model.translatedContent =
                                                      getJsonField(
                                                    _model.extractedData,
                                                    r'''$.translatedContent''',
                                                  ).toString();
                                                  _model.translatedTitle =
                                                      getJsonField(
                                                    _model.extractedData,
                                                    r'''$.translatedTitle''',
                                                  ).toString();
                                                  _model.isTranslating = false;
                                                  _model.isGeneratingAudio =
                                                      false;
                                                  safeSetState(() {});
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Translation complete!',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 1000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .micContainerBackground,
                                                    ),
                                                  );
                                                  _model.canViewAudio = false;
                                                  safeSetState(() {});
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Translation failed. Please try again.',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .micContainerBackground,
                                                    ),
                                                  );
                                                  _model.isGeneratingAudio =
                                                      false;
                                                  _model.isTranslating = false;
                                                  safeSetState(() {});
                                                }
                                              }

                                              safeSetState(() {});
                                            },
                                            width: 200.0,
                                            height: 56.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Gilroy',
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText: 'Select...',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .micContainerBackground,
                                            elevation: 2.0,
                                            borderColor: Colors.transparent,
                                            borderWidth: 0.0,
                                            borderRadius: 8.0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            hidesUnderline: true,
                                            isOverButton: false,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            _model.translatedTitle != null &&
                                                    _model.translatedTitle != ''
                                                ? _model.translatedTitle
                                                : valueOrDefault<String>(
                                                    widget!.article?.title,
                                                    '11 safety tips for your baby\'s nursery',
                                                  ),
                                            '11 safety tips for your baby\'s nursery',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily: 'Clash Grotesk',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://picsum.photos/seed/548/600',
                                                width: 40.0,
                                                height: 40.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Written By',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Gilroy',
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    widget!.article?.author,
                                                    'Dr Jenna Beckham',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Gilroy',
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ].divide(SizedBox(height: 4.0)),
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                    Builder(
                                      builder: (context) {
                                        if (widget!.article?.imageUrl != null &&
                                            widget!.article?.imageUrl != '') {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 200.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  widget!.article!.imageUrl,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 200.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              valueOrDefault<String>(
                                                _model.translatedContent !=
                                                            null &&
                                                        _model.translatedContent !=
                                                            ''
                                                    ? _model.translatedContent
                                                    : widget!.article?.content,
                                                'Content that\'s been translated...',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .micContainerBackground,
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).micStroke,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_model.canViewAudio == true)
                                FlutterFlowAudioPlayer(
                                  audio: Audio.network(
                                    functions
                                        .stringToAudioPath(_model.audioUrl)!,
                                    metas: Metas(
                                      title: 'Listen to Article',
                                    ),
                                  ),
                                  titleTextStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Clash Grotesk',
                                        letterSpacing: 0.0,
                                      ),
                                  playbackDurationTextStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Gilroy',
                                            letterSpacing: 0.0,
                                          ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .micContainerBackground,
                                  playbackButtonColor:
                                      FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                      FlutterFlowTheme.of(context).primary,
                                  inactiveTrackColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  elevation: 0.0,
                                  playInBackground: PlayInBackground
                                      .disabledRestoreOnForeground,
                                ),
                              if (_model.canViewAudio == false)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Listen to Article',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                                  fontFamily: 'Clash Grotesk',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Text(
                                            'Audio in selected language',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Gilroy',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 4.0)),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          if (_model.isGeneratingAudio ==
                                              true) {
                                            return CircularPercentIndicator(
                                              percent: 1.0,
                                              radius: 12.0,
                                              lineWidth: 4.0,
                                              animation: true,
                                              animateFromLastPercent: true,
                                              progressColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .accent4,
                                            );
                                          } else {
                                            return FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 60.0,
                                              icon: Icon(
                                                Icons.settings_sharp,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 30.0,
                                              ),
                                              onPressed: () async {
                                                if (_model.isGeneratingAudio ==
                                                    false) {
                                                  _model.isGeneratingAudio =
                                                      true;
                                                  safeSetState(() {});
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Generating audio...',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .micContainerBackground,
                                                    ),
                                                  );
                                                  _model.audioArticleJson =
                                                      await actions
                                                          .prepareArticleForAudio(
                                                    widget!.article!.toMap(),
                                                    _model.translatedContent,
                                                    _model.translatedTitle,
                                                  );
                                                  _model.audioResponse =
                                                      await ContentProcessorAPICall
                                                          .call(
                                                    articlesJson: _model
                                                        .articleJsonString,
                                                    targetLanguage:
                                                        _model.selectedLanguage,
                                                    action:
                                                        'translate_and_audio',
                                                    articleId:
                                                        widget!.article?.id,
                                                  );

                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  if ((_model.audioResponse
                                                          ?.succeeded ??
                                                      true)) {
                                                    _model.extractedAudioUrl =
                                                        await actions
                                                            .extractAudioUrl(
                                                      getJsonField(
                                                        (_model.audioResponse
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.articles[:].audioUrl''',
                                                      ),
                                                    );
                                                    _model.audioUrl =
                                                        getJsonField(
                                                      (_model.audioResponse
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$.articles[:].audioUrl''',
                                                    ).toString();
                                                    _model.isGeneratingAudio =
                                                        false;
                                                    _model.canViewAudio = true;
                                                    safeSetState(() {});
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Audio ready! Press play to listen',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 2000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .micContainerBackground,
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Failed to generate audio from translated text',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Gilroy',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .micContainerBackground,
                                                      ),
                                                    );
                                                    _model.isGeneratingAudio =
                                                        false;
                                                    safeSetState(() {});
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Audio generation in progress...',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Gilroy',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .micContainerBackground,
                                                    ),
                                                  );
                                                }

                                                safeSetState(() {});
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            ],
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
      ),
    );
  }
}
