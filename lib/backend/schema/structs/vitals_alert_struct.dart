// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VitalsAlertStruct extends BaseStruct {
  VitalsAlertStruct({
    String? alertType,
    String? vitalName,
    String? message,
    String? severity,
    DateTime? timestamp,
  })  : _alertType = alertType,
        _vitalName = vitalName,
        _message = message,
        _severity = severity,
        _timestamp = timestamp;

  // "alertType" field.
  String? _alertType;
  String get alertType => _alertType ?? '';
  set alertType(String? val) => _alertType = val;

  bool hasAlertType() => _alertType != null;

  // "vitalName" field.
  String? _vitalName;
  String get vitalName => _vitalName ?? '';
  set vitalName(String? val) => _vitalName = val;

  bool hasVitalName() => _vitalName != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "severity" field.
  String? _severity;
  String get severity => _severity ?? '';
  set severity(String? val) => _severity = val;

  bool hasSeverity() => _severity != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  set timestamp(DateTime? val) => _timestamp = val;

  bool hasTimestamp() => _timestamp != null;

  static VitalsAlertStruct fromMap(Map<String, dynamic> data) =>
      VitalsAlertStruct(
        alertType: data['alertType'] as String?,
        vitalName: data['vitalName'] as String?,
        message: data['message'] as String?,
        severity: data['severity'] as String?,
        timestamp: data['timestamp'] as DateTime?,
      );

  static VitalsAlertStruct? maybeFromMap(dynamic data) => data is Map
      ? VitalsAlertStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'alertType': _alertType,
        'vitalName': _vitalName,
        'message': _message,
        'severity': _severity,
        'timestamp': _timestamp,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'alertType': serializeParam(
          _alertType,
          ParamType.String,
        ),
        'vitalName': serializeParam(
          _vitalName,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'severity': serializeParam(
          _severity,
          ParamType.String,
        ),
        'timestamp': serializeParam(
          _timestamp,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static VitalsAlertStruct fromSerializableMap(Map<String, dynamic> data) =>
      VitalsAlertStruct(
        alertType: deserializeParam(
          data['alertType'],
          ParamType.String,
          false,
        ),
        vitalName: deserializeParam(
          data['vitalName'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        severity: deserializeParam(
          data['severity'],
          ParamType.String,
          false,
        ),
        timestamp: deserializeParam(
          data['timestamp'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'VitalsAlertStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VitalsAlertStruct &&
        alertType == other.alertType &&
        vitalName == other.vitalName &&
        message == other.message &&
        severity == other.severity &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([alertType, vitalName, message, severity, timestamp]);
}

VitalsAlertStruct createVitalsAlertStruct({
  String? alertType,
  String? vitalName,
  String? message,
  String? severity,
  DateTime? timestamp,
}) =>
    VitalsAlertStruct(
      alertType: alertType,
      vitalName: vitalName,
      message: message,
      severity: severity,
      timestamp: timestamp,
    );
