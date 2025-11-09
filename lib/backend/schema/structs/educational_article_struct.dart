// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EducationalArticleStruct extends BaseStruct {
  EducationalArticleStruct({
    String? id,
    String? title,
    String? content,
    String? category,
    String? imageUrl,
    String? videoId,
    String? audioUrl,
    String? author,
    String? readTime,
  })  : _id = id,
        _title = title,
        _content = content,
        _category = category,
        _imageUrl = imageUrl,
        _videoId = videoId,
        _audioUrl = audioUrl,
        _author = author,
        _readTime = readTime;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "imageUrl" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? val) => _imageUrl = val;

  bool hasImageUrl() => _imageUrl != null;

  // "videoId" field.
  String? _videoId;
  String get videoId => _videoId ?? '';
  set videoId(String? val) => _videoId = val;

  bool hasVideoId() => _videoId != null;

  // "audioUrl" field.
  String? _audioUrl;
  String get audioUrl => _audioUrl ?? '';
  set audioUrl(String? val) => _audioUrl = val;

  bool hasAudioUrl() => _audioUrl != null;

  // "author" field.
  String? _author;
  String get author => _author ?? '';
  set author(String? val) => _author = val;

  bool hasAuthor() => _author != null;

  // "readTime" field.
  String? _readTime;
  String get readTime => _readTime ?? '';
  set readTime(String? val) => _readTime = val;

  bool hasReadTime() => _readTime != null;

  static EducationalArticleStruct fromMap(Map<String, dynamic> data) =>
      EducationalArticleStruct(
        id: data['id'] as String?,
        title: data['title'] as String?,
        content: data['content'] as String?,
        category: data['category'] as String?,
        imageUrl: data['imageUrl'] as String?,
        videoId: data['videoId'] as String?,
        audioUrl: data['audioUrl'] as String?,
        author: data['author'] as String?,
        readTime: data['readTime'] as String?,
      );

  static EducationalArticleStruct? maybeFromMap(dynamic data) => data is Map
      ? EducationalArticleStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'content': _content,
        'category': _category,
        'imageUrl': _imageUrl,
        'videoId': _videoId,
        'audioUrl': _audioUrl,
        'author': _author,
        'readTime': _readTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'imageUrl': serializeParam(
          _imageUrl,
          ParamType.String,
        ),
        'videoId': serializeParam(
          _videoId,
          ParamType.String,
        ),
        'audioUrl': serializeParam(
          _audioUrl,
          ParamType.String,
        ),
        'author': serializeParam(
          _author,
          ParamType.String,
        ),
        'readTime': serializeParam(
          _readTime,
          ParamType.String,
        ),
      }.withoutNulls;

  static EducationalArticleStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      EducationalArticleStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        imageUrl: deserializeParam(
          data['imageUrl'],
          ParamType.String,
          false,
        ),
        videoId: deserializeParam(
          data['videoId'],
          ParamType.String,
          false,
        ),
        audioUrl: deserializeParam(
          data['audioUrl'],
          ParamType.String,
          false,
        ),
        author: deserializeParam(
          data['author'],
          ParamType.String,
          false,
        ),
        readTime: deserializeParam(
          data['readTime'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'EducationalArticleStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EducationalArticleStruct &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        category == other.category &&
        imageUrl == other.imageUrl &&
        videoId == other.videoId &&
        audioUrl == other.audioUrl &&
        author == other.author &&
        readTime == other.readTime;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        title,
        content,
        category,
        imageUrl,
        videoId,
        audioUrl,
        author,
        readTime
      ]);
}

EducationalArticleStruct createEducationalArticleStruct({
  String? id,
  String? title,
  String? content,
  String? category,
  String? imageUrl,
  String? videoId,
  String? audioUrl,
  String? author,
  String? readTime,
}) =>
    EducationalArticleStruct(
      id: id,
      title: title,
      content: content,
      category: category,
      imageUrl: imageUrl,
      videoId: videoId,
      audioUrl: audioUrl,
      author: author,
      readTime: readTime,
    );
