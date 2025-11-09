import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'educational_article_card_model.dart';
export 'educational_article_card_model.dart';

class EducationalArticleCardWidget extends StatefulWidget {
  const EducationalArticleCardWidget({
    super.key,
    required this.article,
  });

  final EducationalArticleStruct? article;

  @override
  State<EducationalArticleCardWidget> createState() =>
      _EducationalArticleCardWidgetState();
}

class _EducationalArticleCardWidgetState
    extends State<EducationalArticleCardWidget> {
  late EducationalArticleCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EducationalArticleCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        context.pushNamed(
          ArticleDetailScreenWidget.routeName,
          queryParameters: {
            'article': serializeParam(
              widget!.article,
              ParamType.DataStruct,
            ),
          }.withoutNulls,
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.bottomToTop,
            ),
          },
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: 92.0,
                height: 92.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Builder(
                  builder: (context) {
                    if (widget!.article?.imageUrl != null &&
                        widget!.article?.imageUrl != '') {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          widget!.article!.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).aiChatBubble,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.article?.title,
                      '11 safety tips for your baby\'s nursery',
                    ),
                    maxLines: 2,
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Gilroy',
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Text(
                          valueOrDefault<String>(
                            widget!.article?.content,
                            'Every parent wants to fulfil their nursery...',
                          ),
                          maxLines: 1,
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                      Text(
                        '...',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Gilroy',
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (widget!.article?.author != null &&
                          widget!.article?.author != '')
                        Text(
                          valueOrDefault<String>(
                            widget!.article?.author,
                            'Dr. Jenna Becham',
                          ),
                          style:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      if (widget!.article?.readTime != null &&
                          widget!.article?.readTime != '')
                        Text(
                          valueOrDefault<String>(
                            widget!.article?.readTime,
                            '2 min',
                          ),
                          style:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    fontFamily: 'Gilroy',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ].divide(SizedBox(height: 8.0)),
              ),
            ),
          ].divide(SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
