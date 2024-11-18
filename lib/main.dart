import 'package:amplitude_flutter/amplitude.dart';
import 'package:blindsplay/config/constants.dart';
import 'package:blindsplay/network/repository/common/CommonRepository.dart';
import 'package:blindsplay/network/repository/login/FirebaseAuthService.dart';
import 'package:blindsplay/network/repository/login/UserRepository.dart';
import 'package:blindsplay/network/repository/login/UserService.dart';
import 'package:blindsplay/presentation/screens/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'network/repository/common/CommonWebService.dart';
import 'network/repository/gmae/GameRepository.dart';
import 'network/repository/gmae/WebService.dart';
import 'network/repository/gmae/WebSocketService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServices();
  runApp(MyApp());
}

final GetIt getIt = GetIt.instance;

Future<void> setupServices() async {
  getIt.registerLazySingleton<Amplitude>(() {
    final amplitude = Amplitude.getInstance();
    amplitude.init(
        'cf36ee56a0cfb45c6d9071b41dd02c02'); // Replace 'YOUR_API_KEY' with your Amplitude API key
    return amplitude;
  });

  final webSocketService = WebSocketService();
  getIt.registerLazySingleton<WebSocketService>(() => webSocketService);

  final webService = WebService(baseUrl: AppConstants.BASE_URL);
  getIt.registerLazySingleton<WebService>(() => webService);

  getIt.registerLazySingleton<GameRepository>(
    () => GameRepository(
        webSocketService: webSocketService, webService: webService),
  );

  final userService = UserService(baseUrl: AppConstants.BASE_URL);
  getIt.registerLazySingleton<UserService>(() => userService);

  getIt.registerLazySingleton<UserRepository>(
      () => UserRepository(userService: userService));

  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

  final commonWebService = CommonWebService(baseUrl: AppConstants.BASE_URL);
  getIt.registerLazySingleton<CommonWebService>(() => commonWebService);

  getIt.registerLazySingleton<CommonRepository>(
      () => CommonRepository(commonWebService: commonWebService));

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
}
