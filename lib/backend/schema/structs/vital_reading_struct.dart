// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// What's happening here: Defining FlutterFlow data structures for vitals
/// information.
///
/// Why this matters: These data types must exist before we create pages and
/// actions that use them.
class VitalReadingStruct extends BaseStruct {
  VitalReadingStruct({
    String? vitalType,
    double? value,
    String? unit,
    String? status,
    DateTime? timestamp,
  })  : _vitalType = vitalType,
        _value = value,
        _unit = unit,
        _status = status,
        _timestamp = timestamp;

  // "vitalType" field.
  String? _vitalType;
  String get vitalType => _vitalType ?? '';
  set vitalType(String? val) => _vitalType = val;

  bool hasVitalType() => _vitalType != null;

  // "value" field.
  double? _value;
  double get value => _value ?? 0.0;
  set value(double? val) => _value = val;

  void incrementValue(double amount) => value = value + amount;

  bool hasValue() => _value != null;

  // "unit" field.
  String? _unit;
  String get unit => _unit ?? '';
  set unit(String? val) => _unit = val;

  bool hasUnit() => _unit != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  set timestamp(DateTime? val) => _timestamp = val;

  bool hasTimestamp() => _timestamp != null;

  static VitalReadingStruct fromMap(Map<String, dynamic> data) =>
      VitalReadingStruct(
        vitalType: data['vitalType'] as String?,
        value: castToType<double>(data['value']),
        unit: data['unit'] as String?,
        status: data['status'] as String?,
        timestamp: data['timestamp'] as DateTime?,
      );

  static VitalReadingStruct? maybeFromMap(dynamic data) => data is Map
      ? VitalReadingStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'vitalType': _vitalType,
        'value': _value,
        'unit': _unit,
        'status': _status,
        'timestamp': _timestamp,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'vitalType': serializeParam(
          _vitalType,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.double,
        ),
        'unit': serializeParam(
          _unit,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'timestamp': serializeParam(
          _timestamp,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static VitalReadingStruct fromSerializableMap(Map<String, dynamic> data) =>
      VitalReadingStruct(
        vitalType: deserializeParam(
          data['vitalType'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.double,
          false,
        ),
        unit: deserializeParam(
          data['unit'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
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
  String toString() => 'VitalReadingStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VitalReadingStruct &&
        vitalType == other.vitalType &&
        value == other.value &&
        unit == other.unit &&
        status == other.status &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([vitalType, value, unit, status, timestamp]);
}

VitalReadingStruct createVitalReadingStruct({
  String? vitalType,
  double? value,
  String? unit,
  String? status,
  DateTime? timestamp,
}) =>
    VitalReadingStruct(
      vitalType: vitalType,
      value: value,
      unit: unit,
      status: status,
      timestamp: timestamp,
    );
