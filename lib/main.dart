import 'package:amplitude_flutter/amplitude.dart';
import 'package:blindsplay/presentation/screens/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServices();
  runApp(MyApp());
}

final GetIt getIt = GetIt.instance;

void setupServices() async {
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

  final Amplitude amplitude = Amplitude.getInstance();
  amplitude.init('cf36ee56a0cfb45c6d9071b41dd02c02');
  getIt.registerSingleton<Amplitude>(amplitude);
}
