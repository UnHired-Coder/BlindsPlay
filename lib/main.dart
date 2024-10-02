import 'package:blindsplay/presentation/screens/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBOs80jOYMWvtUFrERjAqzKz5TGC3SQrSc",
            appId: "1:807824387546:android:ef6dc7cda420762074a4e3",
            messagingSenderId: "807824387546",
            projectId: "tictacmemo-123e7"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}
