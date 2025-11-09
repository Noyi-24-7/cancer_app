// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatMessageStruct extends BaseStruct {
  ChatMessageStruct({
    String? text,
    String? audioUrl,
    bool? isUser,
    DateTime? timestamp,
    String? duration,
    String? language,

    /// JSON string of vitals snapshot
    String? vitalsData,
  })  : _text = text,
        _audioUrl = audioUrl,
        _isUser = isUser,
        _timestamp = timestamp,
        _duration = duration,
        _language = language,
        _vitalsData = vitalsData;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  set text(String? val) => _text = val;

  bool hasText() => _text != null;

  // "audioUrl" field.
  String? _audioUrl;
  String get audioUrl => _audioUrl ?? '';
  set audioUrl(String? val) => _audioUrl = val;

  bool hasAudioUrl() => _audioUrl != null;

  // "isUser" field.
  bool? _isUser;
  bool get isUser => _isUser ?? false;
  set isUser(bool? val) => _isUser = val;

  bool hasIsUser() => _isUser != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  set timestamp(DateTime? val) => _timestamp = val;

  bool hasTimestamp() => _timestamp != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  set duration(String? val) => _duration = val;

  bool hasDuration() => _duration != null;

  // "language" field.
  String? _language;
  String get language => _language ?? '';
  set language(String? val) => _language = val;

  bool hasLanguage() => _language != null;

  // "vitalsData" field.
  String? _vitalsData;
  String get vitalsData => _vitalsData ?? '';
  set vitalsData(String? val) => _vitalsData = val;

  bool hasVitalsData() => _vitalsData != null;

  static ChatMessageStruct fromMap(Map<String, dynamic> data) =>
      ChatMessageStruct(
        text: data['text'] as String?,
        audioUrl: data['audioUrl'] as String?,
        isUser: data['isUser'] as bool?,
        timestamp: data['timestamp'] as DateTime?,
        duration: data['duration'] as String?,
        language: data['language'] as String?,
        vitalsData: data['vitalsData'] as String?,
      );

  static ChatMessageStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatMessageStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'text': _text,
        'audioUrl': _audioUrl,
        'isUser': _isUser,
        'timestamp': _timestamp,
        'duration': _duration,
        'language': _language,
        'vitalsData': _vitalsData,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
        'audioUrl': serializeParam(
          _audioUrl,
          ParamType.String,
        ),
        'isUser': serializeParam(
          _isUser,
          ParamType.bool,
        ),
        'timestamp': serializeParam(
          _timestamp,
          ParamType.DateTime,
        ),
        'duration': serializeParam(
          _duration,
          ParamType.String,
        ),
        'language': serializeParam(
          _language,
          ParamType.String,
        ),
        'vitalsData': serializeParam(
          _vitalsData,
          ParamType.String,
        ),
      }.withoutNulls;

  static ChatMessageStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChatMessageStruct(
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
        audioUrl: deserializeParam(
          data['audioUrl'],
          ParamType.String,
          false,
        ),
        isUser: deserializeParam(
          data['isUser'],
          ParamType.bool,
          false,
        ),
        timestamp: deserializeParam(
          data['timestamp'],
          ParamType.DateTime,
          false,
        ),
        duration: deserializeParam(
          data['duration'],
          ParamType.String,
          false,
        ),
        language: deserializeParam(
          data['language'],
          ParamType.String,
          false,
        ),
        vitalsData: deserializeParam(
          data['vitalsData'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ChatMessageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChatMessageStruct &&
        text == other.text &&
        audioUrl == other.audioUrl &&
        isUser == other.isUser &&
        timestamp == other.timestamp &&
        duration == other.duration &&
        language == other.language &&
        vitalsData == other.vitalsData;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [text, audioUrl, isUser, timestamp, duration, language, vitalsData]);
}

ChatMessageStruct createChatMessageStruct({
  String? text,
  String? audioUrl,
  bool? isUser,
  DateTime? timestamp,
  String? duration,
  String? language,
  String? vitalsData,
}) =>
    ChatMessageStruct(
      text: text,
      audioUrl: audioUrl,
      isUser: isUser,
      timestamp: timestamp,
      duration: duration,
      language: language,
      vitalsData: vitalsData,
    );
