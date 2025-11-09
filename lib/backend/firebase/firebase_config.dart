import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDT7xTjfzGMQmONtOH_d7jxESEPsB13CtU",
            authDomain: "preggos-dea93.firebaseapp.com",
            projectId: "preggos-dea93",
            storageBucket: "preggos-dea93.firebasestorage.app",
            messagingSenderId: "644612001767",
            appId: "1:644612001767:web:a1f3be4c6941f428803742"));
  } else {
    await Firebase.initializeApp();
  }
}
