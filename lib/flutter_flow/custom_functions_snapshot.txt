import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';

dynamic generateMockVitals(String? vitalType) {
  final random = math.Random(); // Changed from Random() to math.Random()

  if (vitalType == 'heartRate') {
    final value = 70 + random.nextInt(20);
    return {
      'type': 'Heart Rate',
      'value': value,
      'unit': 'bpm',
      'isNormal': value >= 60 && value <= 100,
      'color': value >= 60 && value <= 100 ? '0xFF4CAF50' : '0xFFFF5252'
    };
  } else if (vitalType == 'bloodPressure') {
    final systolic = 110 + random.nextInt(30);
    final diastolic = 70 + random.nextInt(20);
    return {
      'type': 'Blood Pressure',
      'value': '$systolic/$diastolic',
      'unit': 'mmHg',
      'isNormal': systolic < 140 && diastolic < 90,
      'color': systolic < 140 && diastolic < 90 ? '0xFF4CAF50' : '0xFFFF5252'
    };
  } else if (vitalType == 'movement') {
    final movements = random.nextInt(10);
    return {
      'type': 'Baby Movement',
      'value': movements > 0 ? 'Active' : 'Quiet',
      'unit': '',
      'isNormal': true,
      'color': '0xFF4CAF50'
    };
  }

  return {
    'type': 'Unknown',
    'value': 0,
    'unit': '',
    'isNormal': false,
    'color': '0xFF9E9E9E'
  };
}

String? stringToAudioPath(String? url) {
  if (url == null || url.isEmpty) {
    return '';
  }

  // If it's a base64 data URL, return as is
  if (url.startsWith('data:audio')) {
    return url;
  }

  // If it's already a valid URL, return as is
  if (url.startsWith('http://') || url.startsWith('https://')) {
    return url;
  }

  // Otherwise, assume it's a relative path and prepend base URL if needed
  return url;
}

String getPlayTranslationText(String? targetLanguage) {
  switch (targetLanguage) {
    case 'en':
      return 'Play Translation';
    case 'yo':
      return 'Gbo Itumọ'; // "Play Translation" in Yoruba
    case 'ha':
      return 'Kunna Fassarar'; // "Play Translation" in Hausa
    case 'ig':
      return 'Kpọọ Ntụgharị'; // "Play Translation" in Igbo
    default:
      return 'Play Translation'; // Default to English
  }
}

String? getRecordingText(
  String? language,
  String? state,
) {
  Map<String, Map<String, String>> translations = {
    'en': {
      'tap': 'Tap to record a voice message',
      'listening': '🎤 Listening...Tap again to stop',
      'processing': '🤖 Message is processing...'
    },
    'yo': {
      'tap': 'Tẹ lati ṣe igbasilẹ ifiranṣẹ ohun',
      'listening': '🎤 Ngbọ...Tẹ lẹẹkansi lati duro',
      'processing': '🤖 AI n ronu...'
    },
    'ha': {
      'tap': 'Danna don yin saƙon murya',
      'listening': '🎤 Sauraro...Danna kuma don tsayawa',
      'processing': '🤖 AI yana tunani...'
    },
    'ig': {
      'tap': 'Pịa ka dekọọ ozi olu',
      'listening': '🎤 Na-ege ntị...Pịa ọzọ ka kwụsị',
      'processing': '🤖 AI na-eche...'
    }
  };

  return translations[language]?[state] ??
      translations['en']?[state] ??
      'Tap to record';
}

String? getEmptyStateText(
  String? language,
  String? textType,
) {
  Map<String, Map<String, String>> translations = {
    'en': {
      'welcome': 'WELCOME TO MEDICAL ASSISTANT',
      'instruction': 'Ask any health question in English'
    },
    'yo': {
      'welcome': 'KAABO SI OLURANLOWO IṢOOGUN',
      'instruction': 'Beere eyikeyi ibeere ilera ni Yoruba'
    },
    'ha': {
      'welcome': 'BARKA DA ZUWA GA MAI TAIMAKO NA LIKITA',
      'instruction': 'Yi tambayar lafiya a Hausa'
    },
    'ig': {
      'welcome': 'NNỌỌ NA ONYE ENYEMAKA AHỤIKE',
      'instruction': 'Jụọ ajụjụ ahụike ọ bụla na Igbo'
    }
  };

  return translations[language]?[textType] ??
      translations['en']?[textType] ??
      'Welcome';
}

List<dynamic> getSampleEducationalContent2() {
  return [
    {
      'id': 'pregnancy_week_12',
      'title': 'Week 12: Your baby\'s development',
      'content':
          'At 12 weeks, your baby is about the size of a plum. The kidneys are now functioning and producing urine. Your baby\'s reflexes are developing, and they may even suck their thumb. The baby\'s face is becoming more human-like, with eyes moving from the sides to the front of the head. This is an exciting milestone in your pregnancy journey.',
      'category': 'pregnancy',
      'imageUrl': '',
      'videoId': 'dQw4w9WgXcQ',
      'author': 'Dr. Sarah Johnson, Obstetrician',
      'readTime': '3 min read'
    },
    {
      'id': 'birth_control_basics',
      'title': 'Birth control basics: What you need to know',
      'content':
          'Birth control helps prevent pregnancy. There are many types available, including hormonal methods like pills and patches, barrier methods like condoms, and long-acting options like IUDs. Each method has different effectiveness rates and side effects. Consult with your healthcare provider to find the best option for you.',
      'category': 'birth_control',
      'imageUrl': '',
      'videoId': '',
      'author': 'Dr. Maria Rodriguez, Gynecologist',
      'readTime': '5 min read'
    },
    {
      'id': 'pregnancy_nutrition',
      'title': 'Healthy eating during pregnancy',
      'content':
          'Good nutrition during pregnancy is crucial for both mother and baby. Focus on eating a variety of foods including fruits, vegetables, whole grains, lean proteins, and dairy products. Take prenatal vitamins as recommended by your doctor. Avoid alcohol, raw fish, and limit caffeine intake.',
      'category': 'nutrition',
      'imageUrl': '',
      'videoId': '',
      'author': 'Dr. Jennifer Lee, Nutritionist',
      'readTime': '4 min read'
    },
    {
      'id': 'prenatal_exercise',
      'title': 'Safe exercises during pregnancy',
      'content':
          'Regular exercise during pregnancy can help reduce back pain, improve mood, and prepare your body for labor. Safe exercises include walking, swimming, prenatal yoga, and light strength training. Always consult your healthcare provider before starting any exercise program during pregnancy.',
      'category': 'exercise',
      'imageUrl': '',
      'videoId': '',
      'author': 'Dr. Michael Chen, Sports Medicine',
      'readTime': '6 min read'
    },
    {
      'id': 'emergency_bleeding',
      'title': 'When to seek help for bleeding during pregnancy',
      'content':
          'Some bleeding during pregnancy can be normal, but heavy bleeding or bleeding with pain requires immediate medical attention. Contact your healthcare provider immediately if you experience heavy bleeding, severe cramping, or passing of tissue. Emergency signs include soaking more than one pad per hour.',
      'category': 'emergency',
      'imageUrl': '',
      'videoId': '',
      'author': 'Dr. Lisa Thompson, Emergency Medicine',
      'readTime': '2 min read'
    }
  ];
}

List<dynamic> filterContentByCategory2(
  List<dynamic> articles,
  String category,
) {
  List<Map<String, dynamic>> filtered = [];

  for (var item in articles) {
    if (item is Map<String, dynamic>) {
      // If category is "all", include everything
      if (category == 'all') {
        filtered.add(item);
      } else {
        // Filter by specific category
        String articleCategory = item['category']?.toLowerCase() ?? '';
        if (articleCategory == category.toLowerCase()) {
          filtered.add(item);
        }
      }
    }
  }

  // Sort by title alphabetically
  filtered.sort((a, b) {
    String titleA = a['title'] ?? '';
    String titleB = b['title'] ?? '';
    return titleA.compareTo(titleB);
  });

  return filtered;
}

String constructYouTubeUrl(String videoId) {
  if (videoId.isEmpty) {
    return '';
  }

  return 'https://www.youtube.com/watch?v=$videoId';
}

String formatMessagesForAPIFn(List<ChatMessageStruct>? messages) {
  if (messages == null || messages.isEmpty) {
    return '[]';
  }

  // Take last 8 messages to avoid token limits
  final recentMessages =
      messages.length > 8 ? messages.sublist(messages.length - 8) : messages;

  List<Map<String, dynamic>> formattedMessages = [];

  for (var message in recentMessages) {
    formattedMessages.add({
      'text': message.text ?? '',
      'isUser': message.isUser ?? false,
    });
  }

  // Convert to JSON string
  return json.encode(formattedMessages);
}

/// Prepares article data for audio generation API
String prepareArticleForAudioFn(
  dynamic article,
  String? translatedContent,
  String? translatedTitle,
) {
  // Create a mutable copy of the article
  final Map<String, dynamic> articleCopy;

  if (article is Map<String, dynamic>) {
    articleCopy = Map<String, dynamic>.from(article);
  } else {
    // If article is not a map, create a basic structure
    articleCopy = {
      'id': 'unknown',
      'title': 'Article',
      'content': 'No content available',
    };
  }

  // Add translated content if available
  if (translatedContent != null && translatedContent.isNotEmpty) {
    articleCopy['translatedContent'] = translatedContent;
  }

  // Add translated title if available
  if (translatedTitle != null && translatedTitle.isNotEmpty) {
    articleCopy['translatedTitle'] = translatedTitle;
  }

  // Convert to JSON string array with single article
  return jsonEncode([articleCopy]);
}

/// Converts list of articles to JSON string
String articlesToJsonStringFn(List<dynamic> articles) {
  try {
    // Convert the articles list to JSON string
    return jsonEncode(articles);
  } catch (e) {
    // If encoding fails, return empty array
    print('Error encoding articles: $e');
    return '[]';
  }
}

String extractDeviceIdFromScanResult(String scanResult) {
  if (scanResult.startsWith('found:')) {
    return scanResult.substring(6); // Remove "found:" prefix
  }
  return '';
}

String parseVitalsDataString(
  String vitalsString,
  String? field,
) {
  try {
    if (vitalsString.isEmpty) return '';

    Map<String, dynamic> vitalsData = json.decode(vitalsString);

    switch (field) {
      case 'heartRate':
        return vitalsData['vitals']?['heartRate']?['value']?.toString() ?? '--';
      case 'heartRateStatus':
        return vitalsData['vitals']?['heartRate']?['status']?.toString() ??
            'unknown';
      case 'systolic':
        return vitalsData['vitals']?['bloodPressure']?['systolic']
                ?.toString() ??
            '--';
      case 'diastolic':
        return vitalsData['vitals']?['bloodPressure']?['diastolic']
                ?.toString() ??
            '--';
      case 'bpStatus':
        return vitalsData['vitals']?['bloodPressure']?['status']?.toString() ??
            'unknown';
      case 'temperature':
        return vitalsData['vitals']?['temperature']?['value']?.toString() ??
            '--';
      case 'tempStatus':
        return vitalsData['vitals']?['temperature']?['status']?.toString() ??
            'unknown';
      case 'oxygenSat':
        return vitalsData['vitals']?['oxygenSaturation']?['value']
                ?.toString() ??
            '--';
      case 'o2Status':
        return vitalsData['vitals']?['oxygenSaturation']?['status']
                ?.toString() ??
            'unknown';
      case 'timestamp':
        return vitalsData['timestamp']?.toString() ?? '';
      case 'batteryLevel':
        return vitalsData['batteryLevel']?.toString() ?? '--';
      case 'fetalHeartRate':
        return vitalsData['vitals']?['fetalHeartRate']?['value']?.toString() ??
            '--';
      case 'fetalPresent':
        return vitalsData['vitals']?['fetalHeartRate']?['present']
                ?.toString() ??
            'false';

      // NEW FIELDS
      case 'fetalMovementIntensity':
        return vitalsData['vitals']?['fetalMovement']?['intensity']
                ?.toString() ??
            '--';
      case 'weight':
        return vitalsData['vitals']?['weight']?['value']?.toString() ?? '--';

      default:
        return '';
    }
  } catch (e) {
    print('Error parsing vitals data: $e');
    return '';
  }
}

int getAlertsCount(String vitalsString) {
  try {
    if (vitalsString.isEmpty) return 0;

    Map<String, dynamic> vitalsData = json.decode(vitalsString);
    List<dynamic> alerts = vitalsData['alerts'] ?? [];
    return alerts.length;
  } catch (e) {
    print('Error getting alerts count: $e');
    return 0;
  }
}

bool hasCriticalAlerts(String vitalsString) {
  try {
    if (vitalsString.isEmpty) return false;

    Map<String, dynamic> vitalsData = json.decode(vitalsString);
    List<dynamic> alerts = vitalsData['alerts'] ?? [];

    for (var alert in alerts) {
      if (alert['type'] == 'critical') {
        return true;
      }
    }
    return false;
  } catch (e) {
    print('Error checking for critical alerts: $e');
    return false;
  }
}

String? getVitalsStatusColor(
  String vitalsString,
  String vitalType,
) {
  try {
    if (vitalsString.isEmpty) return 'gray';

    Map<String, dynamic> vitalsData = json.decode(vitalsString);
    String status = '';

    switch (vitalType) {
      case 'heartRate':
        status = vitalsData['vitals']?['heartRate']?['status']?.toString() ??
            'unknown';
        break;
      case 'bloodPressure':
        status =
            vitalsData['vitals']?['bloodPressure']?['status']?.toString() ??
                'unknown';
        break;
      case 'temperature':
        status = vitalsData['vitals']?['temperature']?['status']?.toString() ??
            'unknown';
        break;
      case 'oxygenSaturation':
        status =
            vitalsData['vitals']?['oxygenSaturation']?['status']?.toString() ??
                'unknown';
        break;
      default:
        return 'gray';
    }

    switch (status) {
      case 'normal':
        return 'green';
      case 'high':
      case 'low':
        return 'orange';
      case 'critical':
        return 'red';
      default:
        return 'gray';
    }
  } catch (e) {
    print('Error getting vitals status color: $e');
    return 'gray';
  }
}

String parseHistoryEntry(
  String historyString,
  int index,
  String field,
) {
  try {
    if (historyString.isEmpty) return '';

    List<dynamic> historyList = json.decode(historyString);
    if (index >= historyList.length || index < 0) return '';

    Map<String, dynamic> entry = Map<String, dynamic>.from(historyList[index]);

    switch (field) {
      case 'timestamp':
        return entry['timestamp']?.toString() ?? '';
      case 'heartRate':
        return entry['heartRate']?.toString() ?? '--';
      case 'bloodPressure':
        return entry['bloodPressure']?.toString() ?? '--/--';
      case 'temperature':
        return entry['temperature']?.toString() ?? '--';
      case 'alerts':
        return entry['alerts']?.toString() ?? '0';
      case 'formattedTime':
        String timestamp = entry['timestamp']?.toString() ?? '';
        if (timestamp.isNotEmpty) {
          try {
            DateTime dt = DateTime.parse(timestamp.replaceAll('-', ':'));
            return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
          } catch (e) {
            return timestamp.split('T')[1]?.split('-')[0] ?? timestamp;
          }
        }
        return '';
      default:
        return '';
    }
  } catch (e) {
    print('Error parsing history entry: $e');
    return '';
  }
}

int getHistoryCount(String historyString) {
  try {
    if (historyString.isEmpty) return 0;

    List<dynamic> historyList = json.decode(historyString);
    return historyList.length;
  } catch (e) {
    print('Error getting history count: $e');
    return 0;
  }
}

String getConnectionStatusText(
  String statusString,
  String language,
) {
  Map<String, Map<String, String>> statusTexts = {
    'en': {
      'connected': 'Live monitoring active',
      'connecting': 'Connecting to device...',
      'disconnected': 'Not monitoring',
      'error': 'Connection error',
      'no_data': 'Waiting for device data',
    },
    'yo': {
      'connected': 'Iṣakoso laaye n ṣiṣe',
      'connecting': 'N darapọ mọ ẹrọ...',
      'disconnected': 'Ko si iṣakoso',
      'error': 'Aṣiṣe asopọ',
      'no_data': 'N duro fun data ẹrọ',
    },
    'ha': {
      'connected': 'Ana gudanar da sauraro kai tsaye',
      'connecting': 'Ana haɗawa da na\'ura...',
      'disconnected': 'Babu sauraro',
      'error': 'Kuskuren haɗi',
      'no_data': 'Ana jiran bayanan na\'ura',
    },
    'ig': {
      'connected': 'Nlekọta dị ndụ na-arụ ọrụ',
      'connecting': 'Na-ejikọ na ngwaọrụ...',
      'disconnected': 'Enweghị nlekọta',
      'error': 'Njehie njikọ',
      'no_data': 'Na-echere data ngwaọrụ',
    }
  };

  return statusTexts[language]?[statusString] ??
      statusTexts['en']?[statusString] ??
      statusString;
}

bool shouldShowEmergencyAlert(String alertsString) {
  try {
    if (alertsString.isEmpty) return false;

    List<dynamic> alertsData = json.decode(alertsString);

    for (var alert in alertsData) {
      Map<String, dynamic> alertMap = Map<String, dynamic>.from(alert);
      if (alertMap['type'] == 'critical') {
        return true;
      }
    }
    return false;
  } catch (e) {
    print('Error checking emergency state: $e');
    return false;
  }
}

List<int> generateIndexList(String historyString) {
  // Handle empty string
  if (historyString.isEmpty) {
    return [];
  }

  try {
    // Parse the JSON string directly
    List<dynamic> historyList = json.decode(historyString);

    // Generate indices [0, 1, 2, ...] based on list length
    return List<int>.generate(historyList.length, (i) => i);
  } catch (e) {
    // If parsing fails, return empty list
    print('Error parsing history in generateIndexList: $e');
    return [];
  }
}

ChatMessageStruct createChatMessage(
  String text,
  String audioUrl,
  bool isUser,
  DateTime timestamp,
  String? language,
) {
  return ChatMessageStruct(
    text: text.trim(),
    audioUrl: audioUrl.trim(),
    isUser: isUser,
    timestamp: timestamp.toUtc(),
    // if your ChatMessage struct doesn't have `language`, remove this line
    language: (language != null && language.trim().isNotEmpty)
        ? language.trim()
        : null,
  );
}

String normalizePhoneKey(String phone) {
  if (phone == null || phone.isEmpty) return '';
  // strip non-digits, ensure we keep leading country digits only once
  final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
  // your RTDB uses phone_234... (no +)
  return 'phone_$digits';
}

String buildThreadId(
  String patientKey,
  String doctorId,
) {
  if (patientKey == null ||
      patientKey.isEmpty ||
      doctorId == null ||
      doctorId.isEmpty) return '';
  return 'thread_${patientKey}_${doctorId}';
}
