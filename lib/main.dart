import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/screens/home_screen.dart';
import 'package:flutter_taipei/simple_bloc_delegate.dart';

void main() {
  /// required in Flutter v1.9.4+ before using any plugins if the code is executed before runApp
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final Repository repository = Repository();

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  MyApp({this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Taipei',
      theme: ThemeData(
          primarySwatch: Colors.blue, backgroundColor: Colors.grey[200]),
      home: HomeScreen(repository: repository,),
    );
  }
}
