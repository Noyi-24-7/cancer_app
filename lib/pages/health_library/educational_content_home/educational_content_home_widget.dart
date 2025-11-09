import '/backend/api_requests/api_calls.dart';
import '/comp_cont/educational_article_card/educational_article_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'educational_content_home_model.dart';
export 'educational_content_home_model.dart';

class EducationalContentHomeWidget extends StatefulWidget {
  const EducationalContentHomeWidget({super.key});

  static String routeName = 'EducationalContentHome';
  static String routePath = '/educationalContentHome';

  @override
  State<EducationalContentHomeWidget> createState() =>
      _EducationalContentHomeWidgetState();
}

class _EducationalContentHomeWidgetState
    extends State<EducationalContentHomeWidget> {
  late EducationalContentHomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EducationalContentHomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().currentMode = 'education';
      safeSetState(() {});
      _model.sampleContent = await actions.getSampleEducationalContent();
      _model.articles = _model.sampleContent!.toList().cast<dynamic>();
      safeSetState(() {});
      FFAppState().offlineContent =
          _model.sampleContent!.toList().cast<dynamic>();
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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 56.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(),
                        ),
                        Text(
                          'Health Library',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Clash Grotesk',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 22.0,
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Topics',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Gilroy',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 120.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: ListView(
                            padding: EdgeInsets.fromLTRB(
                              16.0,
                              0,
                              16.0,
                              0,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.isLoading = true;
                                  _model.selectedCategory = 'pregnancy';
                                  safeSetState(() {});
                                  _model.fetchResponse =
                                      await ContentFetcherAPICall.call(
                                    topic: 'pregnancy',
                                    category: 'pregnancy',
                                    language: 'en',
                                  );

                                  if ((_model.fetchResponse?.succeeded ??
                                      true)) {
                                    if (FFAppState().educationalLanguage !=
                                        'en') {
                                      _model.articlesJsonString =
                                          await actions.articlesToJsonString(
                                        getJsonField(
                                          (_model.fetchResponse?.jsonBody ??
                                              ''),
                                          r'''$.articles''',
                                          true,
                                        )!,
                                      );
                                      _model.translateResponse =
                                          await ContentProcessorAPICall.call(
                                        articlesJson: _model.articlesJsonString,
                                        targetLanguage:
                                            FFAppState().educationalLanguage,
                                        action: 'translate_only',
                                        articleId: '\"\"',
                                      );

                                      if ((_model
                                              .translateResponse?.succeeded ??
                                          true)) {
                                        _model.articles = getJsonField(
                                          (_model.translateResponse?.jsonBody ??
                                              ''),
                                          r'''$.articles''',
                                          true,
                                        )!
                                            .toList()
                                            .cast<dynamic>();
                                        _model.isLoading = false;
                                        safeSetState(() {});
                                      } else {
                                        _model.articles = getJsonField(
                                          (_model.fetchResponse?.jsonBody ??
                                              ''),
                                          r'''$.articles''',
                                          true,
                                        )!
                                            .toList()
                                            .cast<dynamic>();
                                        _model.isLoading = false;
                                        safeSetState(() {});
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Translation unavailable, showing English content',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Gilroy',
                                                        color:
                                                            FlutterFlowTheme.of(
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
                                    } else {
                                      _model.articles = getJsonField(
                                        (_model.fetchResponse?.jsonBody ?? ''),
                                        r'''$.articles''',
                                        true,
                                      )!
                                          .toList()
                                          .cast<dynamic>();
                                      _model.isLoading = false;
                                      safeSetState(() {});
                                    }
                                  } else {
                                    _model.isLoading = false;
                                    safeSetState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Unable to load content. Please check your connection.',
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
                                        duration: Duration(milliseconds: 2000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .micContainerBackground,
                                      ),
                                    );
                                    _model.fallbackContent = await actions
                                        .getSampleEducationalContent();
                                    _model.articles = _model.fallbackContent!
                                        .toList()
                                        .cast<dynamic>();
                                    safeSetState(() {});
                                  }

                                  safeSetState(() {});
                                },
                                onDoubleTap: () async {
                                  await actions.getSampleEducationalContent();
                                  _model.articles = _model.sampleContent!
                                      .toList()
                                      .cast<dynamic>();
                                  safeSetState(() {});
                                  _model.selectedCategory = 'pregnancy';
                                  safeSetState(() {});
                                  _model.filteredArticlespCopy =
                                      await actions.filterContentByCategory(
                                    _model.articles.toList(),
                                    'pregnancy',
                                  );
                                  _model.articles = _model
                                      .filteredArticlespCopy!
                                      .toList()
                                      .cast<dynamic>();
                                  safeSetState(() {});

                                  safeSetState(() {});
                                },
                                child: Container(
                                  width: 180.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE8B4CB),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pregnancy Guide',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'Gilroy',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Text(
                                          'Week by week updates',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'Gilroy',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.isLoading = true;
                                  _model.selectedCategory = 'birth_control';
                                  safeSetState(() {});
                                  _model.fetchResponseCopy =
                                      await ContentFetcherAPICall.call(
                                    topic: 'birth_control',
                                    category: 'birth_control',
                                    language: 'en',
                                  );

                                  if ((_model.fetchResponseCopy?.succeeded ??
                                      true)) {
                                    if (FFAppState().educationalLanguage !=
                                        'en') {
                                      _model.articlesJsonStringCopy =
                                          await actions.articlesToJsonString(
                                        getJsonField(
                                          (_model.fetchResponseCopy?.jsonBody ??
                                              ''),
                                          r'''$.articles''',
                                          true,
                                        )!,
                                      );
                                      _model.translateResponseCopy =
                                          await ContentProcessorAPICall.call(
                                        articlesJson:
                                            _model.articlesJsonStringCopy,
                                        targetLanguage:
                                            FFAppState().educationalLanguage,
                                        action: 'translate_only',
                                        articleId: '\"\"',
                                      );

                                      if ((_model.translateResponseCopy
                                              ?.succeeded ??
                                          true)) {
                                        _model.articles = getJsonField(
                                          (_model.translateResponseCopy
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.articles''',
                                          true,
                                        )!
                                            .toList()
                                            .cast<dynamic>();
                                        _model.isLoading = false;
                                        safeSetState(() {});
                                      } else {
                                        _model.articles = getJsonField(
                                          (_model.fetchResponseCopy?.jsonBody ??
                                              ''),
                                          r'''$.articles''',
                                          true,
                                        )!
                                            .toList()
                                            .cast<dynamic>();
                                        _model.isLoading = false;
                                        safeSetState(() {});
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Translation unavailable, showing English content',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Gilroy',
                                                        color:
                                                            FlutterFlowTheme.of(
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
                                    } else {
                                      _model.articles = getJsonField(
                                        (_model.fetchResponseCopy?.jsonBody ??
                                            ''),
                                        r'''$.articles''',
                                        true,
                                      )!
                                          .toList()
                                          .cast<dynamic>();
                                      _model.isLoading = false;
                                      safeSetState(() {});
                                    }
                                  } else {
                                    _model.isLoading = false;
                                    safeSetState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Unable to load content. Please check your connection.',
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
                                        duration: Duration(milliseconds: 2000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .micContainerBackground,
                                      ),
                                    );
                                    _model.fallbackContentCopy = await actions
                                        .getSampleEducationalContent();
                                    _model.articles = _model
                                        .fallbackContentCopy!
                                        .toList()
                                        .cast<dynamic>();
                                    safeSetState(() {});
                                  }

                                  safeSetState(() {});
                                },
                                onDoubleTap: () async {
                                  await actions.getSampleEducationalContent();
                                  _model.articles = _model.sampleContent!
                                      .toList()
                                      .cast<dynamic>();
                                  safeSetState(() {});
                                  _model.selectedCategory = 'birth_control';
                                  safeSetState(() {});
                                  _model.filteredArticlesbCopy =
                                      await actions.filterContentByCategory(
                                    _model.articles.toList(),
                                    'birth_control',
                                  );
                                  _model.articles = _model
                                      .filteredArticlesbCopy!
                                      .toList()
                                      .cast<dynamic>();
                                  safeSetState(() {});

                                  safeSetState(() {});
                                },
                                child: Container(
                                  width: 180.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFB8D8E0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Birth Control',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'Gilroy',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Text(
                                          'Family planning info',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'Gilroy',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await actions.getSampleEducationalContent();
                                  _model.articles = _model.sampleContent!
                                      .toList()
                                      .cast<dynamic>();
                                  safeSetState(() {});
                                  _model.selectedCategory = 'nutrition';
                                  safeSetState(() {});
                                  _model.filteredArticlesn =
                                      await actions.filterContentByCategory(
                                    _model.articles.toList(),
                                    'nutrition',
                                  );
                                  _model.articles = _model.filteredArticlesn!
                                      .toList()
                                      .cast<dynamic>();
                                  safeSetState(() {});

                                  safeSetState(() {});
                                },
                                child: Container(
                                  width: 180.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE8D5B7),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nutrition Tips',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'Gilroy',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Text(
                                          'Healthy eating guides',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'Gilroy',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Insights',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Gilroy',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final articleItem = _model.articles.toList();

                                return ListView.separated(
                                  padding: EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    16.0,
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: articleItem.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 16.0),
                                  itemBuilder: (context, articleItemIndex) {
                                    final articleItemItem =
                                        articleItem[articleItemIndex];
                                    return EducationalArticleCardWidget(
                                      key: Key(
                                          'Key528_${articleItemIndex}_of_${articleItem.length}'),
                                      article:
                                          EducationalArticleStruct.maybeFromMap(
                                              articleItemItem)!,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 16.0)).addToEnd(SizedBox(height: 40.0)),
            ),
          ),
        ),
      ),
    );
  }
}
