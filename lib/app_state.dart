import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _selectedLanguage =
          prefs.getString('ff_selectedLanguage') ?? _selectedLanguage;
    });
    _safeInit(() {
      _selectedLanguageName =
          prefs.getString('ff_selectedLanguageName') ?? _selectedLanguageName;
    });
    _safeInit(() {
      _isQAMode = prefs.getBool('ff_isQAMode') ?? _isQAMode;
    });
    _safeInit(() {
      _selectedDoctorName =
          prefs.getString('ff_selectedDoctorName') ?? _selectedDoctorName;
    });
    _safeInit(() {
      _favoriteArticles =
          prefs.getStringList('ff_favoriteArticles') ?? _favoriteArticles;
    });
    _safeInit(() {
      _offlineContent = prefs.getStringList('ff_offlineContent')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _offlineContent;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _selectedLanguage = 'en';
  String get selectedLanguage => _selectedLanguage;
  set selectedLanguage(String value) {
    _selectedLanguage = value;
    prefs.setString('ff_selectedLanguage', value);
  }

  String _selectedLanguageName = 'English';
  String get selectedLanguageName => _selectedLanguageName;
  set selectedLanguageName(String value) {
    _selectedLanguageName = value;
    prefs.setString('ff_selectedLanguageName', value);
  }

  bool _isQAMode = true;
  bool get isQAMode => _isQAMode;
  set isQAMode(bool value) {
    _isQAMode = value;
    prefs.setBool('ff_isQAMode', value);
  }

  String _selectedDoctorName = 'Dr Lucy';
  String get selectedDoctorName => _selectedDoctorName;
  set selectedDoctorName(String value) {
    _selectedDoctorName = value;
    prefs.setString('ff_selectedDoctorName', value);
  }

  String _currentMode = 'home';
  String get currentMode => _currentMode;
  set currentMode(String value) {
    _currentMode = value;
  }

  String _educationalLanguage = 'en';
  String get educationalLanguage => _educationalLanguage;
  set educationalLanguage(String value) {
    _educationalLanguage = value;
  }

  List<String> _favoriteArticles = [];
  List<String> get favoriteArticles => _favoriteArticles;
  set favoriteArticles(List<String> value) {
    _favoriteArticles = value;
    prefs.setStringList('ff_favoriteArticles', value);
  }

  void addToFavoriteArticles(String value) {
    favoriteArticles.add(value);
    prefs.setStringList('ff_favoriteArticles', _favoriteArticles);
  }

  void removeFromFavoriteArticles(String value) {
    favoriteArticles.remove(value);
    prefs.setStringList('ff_favoriteArticles', _favoriteArticles);
  }

  void removeAtIndexFromFavoriteArticles(int index) {
    favoriteArticles.removeAt(index);
    prefs.setStringList('ff_favoriteArticles', _favoriteArticles);
  }

  void updateFavoriteArticlesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    favoriteArticles[index] = updateFn(_favoriteArticles[index]);
    prefs.setStringList('ff_favoriteArticles', _favoriteArticles);
  }

  void insertAtIndexInFavoriteArticles(int index, String value) {
    favoriteArticles.insert(index, value);
    prefs.setStringList('ff_favoriteArticles', _favoriteArticles);
  }

  List<dynamic> _offlineContent = [];
  List<dynamic> get offlineContent => _offlineContent;
  set offlineContent(List<dynamic> value) {
    _offlineContent = value;
    prefs.setStringList(
        'ff_offlineContent', value.map((x) => jsonEncode(x)).toList());
  }

  void addToOfflineContent(dynamic value) {
    offlineContent.add(value);
    prefs.setStringList('ff_offlineContent',
        _offlineContent.map((x) => jsonEncode(x)).toList());
  }

  void removeFromOfflineContent(dynamic value) {
    offlineContent.remove(value);
    prefs.setStringList('ff_offlineContent',
        _offlineContent.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromOfflineContent(int index) {
    offlineContent.removeAt(index);
    prefs.setStringList('ff_offlineContent',
        _offlineContent.map((x) => jsonEncode(x)).toList());
  }

  void updateOfflineContentAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    offlineContent[index] = updateFn(_offlineContent[index]);
    prefs.setStringList('ff_offlineContent',
        _offlineContent.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInOfflineContent(int index, dynamic value) {
    offlineContent.insert(index, value);
    prefs.setStringList('ff_offlineContent',
        _offlineContent.map((x) => jsonEncode(x)).toList());
  }

  String _connectedVitalsDevice = '';
  String get connectedVitalsDevice => _connectedVitalsDevice;
  set connectedVitalsDevice(String value) {
    _connectedVitalsDevice = value;
  }

  bool _vitalsMonitoringActive = false;
  bool get vitalsMonitoringActive => _vitalsMonitoringActive;
  set vitalsMonitoringActive(bool value) {
    _vitalsMonitoringActive = value;
  }

  String _currentVitalsData = '';
  String get currentVitalsData => _currentVitalsData;
  set currentVitalsData(String value) {
    _currentVitalsData = value;
  }

  String _vitalsDeviceId = 'VITALS_001';
  String get vitalsDeviceId => _vitalsDeviceId;
  set vitalsDeviceId(String value) {
    _vitalsDeviceId = value;
  }

  String _vitalsConnectionStatus = 'disconnected';
  String get vitalsConnectionStatus => _vitalsConnectionStatus;
  set vitalsConnectionStatus(String value) {
    _vitalsConnectionStatus = value;
  }

  String _vitalsAlerts = '';
  String get vitalsAlerts => _vitalsAlerts;
  set vitalsAlerts(String value) {
    _vitalsAlerts = value;
  }

  String _firebaseRestApiUrl =
      'https://preggos-dea93-default-rtdb.firebaseio.com';
  String get firebaseRestApiUrl => _firebaseRestApiUrl;
  set firebaseRestApiUrl(String value) {
    _firebaseRestApiUrl = value;
  }

  /// Tracks if user is logged in
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  set isAuthenticated(bool value) {
    _isAuthenticated = value;
  }

  /// Current user's phone number
  String _currentUserPhone = '\"\"';
  String get currentUserPhone => _currentUserPhone;
  set currentUserPhone(String value) {
    _currentUserPhone = value;
  }

  /// Current patient's profile data
  dynamic _currentPatientData = jsonDecode('{}');
  dynamic get currentPatientData => _currentPatientData;
  set currentPatientData(dynamic value) {
    _currentPatientData = value;
  }

  /// Current step in registration process
  int _registrationStep = 0;
  int get registrationStep => _registrationStep;
  set registrationStep(int value) {
    _registrationStep = value;
  }

  /// "Current doctor communication thread data"
  dynamic _currentDoctorCommunications;
  dynamic get currentDoctorCommunications => _currentDoctorCommunications;
  set currentDoctorCommunications(dynamic value) {
    _currentDoctorCommunications = value;
  }

  /// "Tracks if user is currently recording a voice message"
  bool _isRecordingVoiceMessage = false;
  bool get isRecordingVoiceMessage => _isRecordingVoiceMessage;
  set isRecordingVoiceMessage(bool value) {
    _isRecordingVoiceMessage = value;
  }

  /// "Path to the last recorded voice message"
  String _lastVoiceMessagePath = '';
  String get lastVoiceMessagePath => _lastVoiceMessagePath;
  set lastVoiceMessagePath(String value) {
    _lastVoiceMessagePath = value;
  }

  /// "Stores message history for current doctor thread"
  dynamic _communicationHistory;
  dynamic get communicationHistory => _communicationHistory;
  set communicationHistory(dynamic value) {
    _communicationHistory = value;
  }

  String _currentPatientId = '';
  String get currentPatientId => _currentPatientId;
  set currentPatientId(String value) {
    _currentPatientId = value;
  }

  /// the logged-in user’s phone as you have it (+234… is fine here).
  String _patientPhoneRaw = '';
  String get patientPhoneRaw => _patientPhoneRaw;
  set patientPhoneRaw(String value) {
    _patientPhoneRaw = value;
  }

  /// derived key we will use to build thread paths, e.g.
  ///
  /// phone_2341234567899.
  String _patientKey = '';
  String get patientKey => _patientKey;
  set patientKey(String value) {
    _patientKey = value;
  }

  String _assignedDoctorId = '';
  String get assignedDoctorId => _assignedDoctorId;
  set assignedDoctorId(String value) {
    _assignedDoctorId = value;
  }

  String _currentThreadId = '';
  String get currentThreadId => _currentThreadId;
  set currentThreadId(String value) {
    _currentThreadId = value;
  }

  /// raw JSON string from RTDB for the thread’s /messages.
  String _currentMessagesJson = '';
  String get currentMessagesJson => _currentMessagesJson;
  set currentMessagesJson(String value) {
    _currentMessagesJson = value;
  }

  ///
  ///
  List<dynamic> _parsedCurrentMessages2 = [];
  List<dynamic> get parsedCurrentMessages2 => _parsedCurrentMessages2;
  set parsedCurrentMessages2(List<dynamic> value) {
    _parsedCurrentMessages2 = value;
  }

  void addToParsedCurrentMessages2(dynamic value) {
    parsedCurrentMessages2.add(value);
  }

  void removeFromParsedCurrentMessages2(dynamic value) {
    parsedCurrentMessages2.remove(value);
  }

  void removeAtIndexFromParsedCurrentMessages2(int index) {
    parsedCurrentMessages2.removeAt(index);
  }

  void updateParsedCurrentMessages2AtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    parsedCurrentMessages2[index] = updateFn(_parsedCurrentMessages2[index]);
  }

  void insertAtIndexInParsedCurrentMessages2(int index, dynamic value) {
    parsedCurrentMessages2.insert(index, value);
  }

  String _currentPatientLanguage = 'en';
  String get currentPatientLanguage => _currentPatientLanguage;
  set currentPatientLanguage(String value) {
    _currentPatientLanguage = value;
  }

  dynamic _currentRiskData;
  dynamic get currentRiskData => _currentRiskData;
  set currentRiskData(dynamic value) {
    _currentRiskData = value;
  }

  String _patientPhoneId = 'phone_2341234567899';
  String get patientPhoneId => _patientPhoneId;
  set patientPhoneId(String value) {
    _patientPhoneId = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
