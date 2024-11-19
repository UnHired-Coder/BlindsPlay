import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../config/screen_size.dart';
import '../../logic/blocs/login/login_bloc.dart';
import '../../network/repository/login/FirebaseAuthService.dart';
import '../../network/repository/login/UserRepository.dart';
import 'mainscreen/MainScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserRepository>(
          create: (context) => GetIt.I<UserRepository>(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authService: GetIt.I<FirebaseAuthService>(),
            userRepository: GetIt.I<UserRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic Tac Memo',
        home: Center(child: MainScreen()),
      ),
    );
  }
}
