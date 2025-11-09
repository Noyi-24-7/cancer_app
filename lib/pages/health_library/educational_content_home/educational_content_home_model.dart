import '/backend/api_requests/api_calls.dart';
import '/comp_cont/educational_article_card/educational_article_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import 'educational_content_home_widget.dart' show EducationalContentHomeWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EducationalContentHomeModel
    extends FlutterFlowModel<EducationalContentHomeWidget> {
  ///  Local state fields for this page.

  String selectedCategory = 'all';

  List<dynamic> articles = [];
  void addToArticles(dynamic item) => articles.add(item);
  void removeFromArticles(dynamic item) => articles.remove(item);
  void removeAtIndexFromArticles(int index) => articles.removeAt(index);
  void insertAtIndexInArticles(int index, dynamic item) =>
      articles.insert(index, item);
  void updateArticlesAtIndex(int index, Function(dynamic) updateFn) =>
      articles[index] = updateFn(articles[index]);

  bool isLoading = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getSampleEducationalContent] action in EducationalContentHome widget.
  List<dynamic>? sampleContent;
  // Stores action output result for [Custom Action - filterContentByCategory] action in Container widget.
  List<dynamic>? filteredArticlespCopy;
  // Stores action output result for [Backend Call - API (ContentFetcherAPI)] action in Container widget.
  ApiCallResponse? fetchResponse;
  // Stores action output result for [Custom Action - articlesToJsonString] action in Container widget.
  String? articlesJsonString;
  // Stores action output result for [Backend Call - API (ContentProcessorAPI)] action in Container widget.
  ApiCallResponse? translateResponse;
  // Stores action output result for [Custom Action - getSampleEducationalContent] action in Container widget.
  List<dynamic>? fallbackContent;
  // Stores action output result for [Custom Action - filterContentByCategory] action in Container widget.
  List<dynamic>? filteredArticlesbCopy;
  // Stores action output result for [Backend Call - API (ContentFetcherAPI)] action in Container widget.
  ApiCallResponse? fetchResponseCopy;
  // Stores action output result for [Custom Action - articlesToJsonString] action in Container widget.
  String? articlesJsonStringCopy;
  // Stores action output result for [Backend Call - API (ContentProcessorAPI)] action in Container widget.
  ApiCallResponse? translateResponseCopy;
  // Stores action output result for [Custom Action - getSampleEducationalContent] action in Container widget.
  List<dynamic>? fallbackContentCopy;
  // Stores action output result for [Custom Action - filterContentByCategory] action in Container widget.
  List<dynamic>? filteredArticlesn;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
