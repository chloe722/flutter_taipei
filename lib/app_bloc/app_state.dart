
import 'package:equatable/equatable.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';

abstract class AppState extends Equatable {

  const AppState();

  @override
  List<Object> get props => [];

}

class Initialize extends AppState {
  const Initialize({this.talk});

  final LighteningTalk talk;

  @override
  List<Object> get props => [talk];

  @override
  String toString() {
    return 'Initialize{talk: $talk}';
  }
}


class Uninitialized extends AppState {}
