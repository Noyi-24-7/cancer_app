import '/backend/api_requests/api_calls.dart';
import '/comp_cont/educational_article_card/educational_article_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class EducationalContentHomeWidget extends StatefulWidget {
  const EducationalContentHomeWidget({super.key});

  static const String routeName = 'EducationalContentHome';
  static const String routePath = '/educationalContentHome';

  @override
  State<EducationalContentHomeWidget> createState() =>
      _EducationalContentHomeWidgetState();
}

class _EducationalContentHomeWidgetState
    extends State<EducationalContentHomeWidget> {
  String selectedCategory = 'all';
  List<dynamic> articles = [];
  bool isLoading = false;
  List<dynamic>? sampleContent;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void addToArticles(dynamic item) {
    setState(() {
      articles.add(item);
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().currentMode = 'education';
      if (mounted) {
        setState(() {});
      }
      sampleContent = await actions.getSampleEducationalContent();
      articles = sampleContent!.toList().cast<dynamic>();
      if (mounted) {
        setState(() {});
      }
      FFAppState().offlineContent =
          sampleContent!.toList().cast<dynamic>();
      if (mounted) {
        setState(() {});
      }
    });
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
        key: _scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const _HeaderSection(),
                _TopicsSection(
                  selectedCategory: selectedCategory,
                  onCategorySelected: (category) async {
                    setState(() {
                      isLoading = true;
                      selectedCategory = category;
                    });
                    
                    // Load sample content
                    sampleContent = await actions.getSampleEducationalContent();
                    
                    // Filter by category
                    final filteredArticles = await actions.filterContentByCategory(
                      sampleContent!.toList(),
                      category,
                    );
                    
                    articles = filteredArticles!.toList().cast<dynamic>();
                    
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onCategoryDoubleTapped: (category) async {
                    setState(() {
                      isLoading = true;
                      selectedCategory = category;
                    });
                    
                    // Load sample content
                    sampleContent = await actions.getSampleEducationalContent();
                    
                    // Filter by category
                    final filteredArticles = await actions.filterContentByCategory(
                      sampleContent!.toList(),
                      category,
                    );
                    
                    articles = filteredArticles!.toList().cast<dynamic>();
                    
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                _ArticlesListSection(articles: articles),
              ]
                  .divide(const SizedBox(height: 16.0))
                  .addToEnd(const SizedBox(height: 40.0)),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 56.0, 0.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 60.0, height: 60.0),
            Text(
              'Health Library',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
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
    );
  }
}

class _TopicsSection extends StatelessWidget {
  const _TopicsSection({
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onCategoryDoubleTapped,
  });

  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onCategoryDoubleTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Topics',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Gilroy',
                          color: FlutterFlowTheme.of(context).primaryText,
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
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  _CategoryCard(
                    title: 'Detection & Signs',
                    subtitle: 'Early warning signs',
                    color: const Color(0xFFE8B4CB),
                    isActive: selectedCategory == 'detection',
                    onTap: () => onCategorySelected('detection'),
                    onDoubleTap: () => onCategoryDoubleTapped('detection'),
                  ),
                  _CategoryCard(
                    title: 'Treatment',
                    subtitle: 'Management options',
                    color: const Color(0xFFB8D8E0),
                    isActive: selectedCategory == 'treatment',
                    onTap: () => onCategorySelected('treatment'),
                    onDoubleTap: () => onCategoryDoubleTapped('treatment'),
                  ),
                  _CategoryCard(
                    title: 'Support & Care',
                    subtitle: 'Living with cancer',
                    color: const Color(0xFFE8D5B7),
                    isActive: selectedCategory == 'support',
                    onTap: () => onCategorySelected('support'),
                    onDoubleTap: () => onCategoryDoubleTapped('support'),
                  ),
                ].divide(const SizedBox(width: 8.0)),
              ),
            ),
          ].divide(const SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isActive,
    required this.onTap,
    required this.onDoubleTap,
  });

  final String title;
  final String subtitle;
  final Color color;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Container(
        width: 180.0,
        height: 120.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
          border: isActive
              ? Border.all(
                  color: const Color(0xFF3A6BF4),
                  width: 4.0,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Gilroy',
                      letterSpacing: 0.0,
                    ),
              ),
              Text(
                subtitle,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Gilroy',
                      letterSpacing: 0.0,
                    ),
              ),
            ].divide(const SizedBox(height: 4.0)),
          ),
        ),
      ),
    );
  }
}

class _ArticlesListSection extends StatelessWidget {
  const _ArticlesListSection({required this.articles});

  final List<dynamic> articles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Insights',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Gilroy',
                          color: FlutterFlowTheme.of(context).primaryText,
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
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: articles.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                  itemBuilder: (context, index) {
                    final articleItem = articles[index];
                    return EducationalArticleCardWidget(
                      key: Key('Key528_${index}_of_${articles.length}'),
                      article: EducationalArticleStruct.maybeFromMap(
                          articleItem)!,
                    );
                  },
                ),
              ),
            ),
          ].divide(const SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}

