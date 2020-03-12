import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_taipei/app_bloc/app_bloc.dart';
import 'package:flutter_taipei/app_bloc/app_event.dart';
import 'package:flutter_taipei/app_bloc/app_state.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/screens/home_screen.dart';
import 'package:flutter_taipei/screens/splash_screen.dart';
import 'package:flutter_taipei/simple_bloc_delegate.dart';

void main() {
  /// required in Flutter v1.9.4+ before using any plugins if the code is executed before runApp
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final Repository repository = Repository();

  runApp(BlocProvider(
      create: (context) => AppBloc(repository: repository)..add(AppStarted()),
      child: App(repository: repository)));
}

class App extends StatelessWidget {
  App({this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Taipei',
//      color: kDarkBgColor,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: kDarkBgColor),
           backgroundColor: kDarkBgColor),
      home: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
        if (state is Uninitialized) {
          return SplashScreen();
        }
        if (state is Initialize) {
          return HomeScreen(repository: repository, talk: state.talk);
        }
      }),
    );
  }
}
