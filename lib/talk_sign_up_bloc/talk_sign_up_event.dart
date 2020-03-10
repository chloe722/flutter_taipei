import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TalkSignUpEvent extends Equatable {
  const TalkSignUpEvent();

  @override
  List<Object> get props => [];

}

class NumberChanged extends TalkSignUpEvent {
  const NumberChanged({@required this.number});

  final String number;


  @override
  List<Object> get props => [number];

  @override
  String toString() {
    return 'NumberChanged{number: $number}';
  }
}


class NameChanged extends TalkSignUpEvent {
  const NameChanged({@required this.name});

  final String name;

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return 'NameChanged{name: $name}';
  }
}


class TopicChanged extends TalkSignUpEvent {
  const TopicChanged({@required this.topic});

  final String topic;


  @override
  List<Object> get props => [topic];

  @override
  String toString() {
    return 'TopicChanged{topic: $topic}';
  }
}


class Submitted extends TalkSignUpEvent {
  const Submitted(this.number, this.name, this.topic);

  final String number;
  final String name;
  final String topic;

  @override
  List<Object> get props => [number, name, topic];

}

class SignUpTalkPressed extends TalkSignUpEvent {
  SignUpTalkPressed(
      {@required this.number,
        @required this.speakerName,
        @required this.topic});

  final String number;
  final String speakerName;
  final String topic;

  @override
  List<Object> get props => [number, speakerName, topic];

  @override
  String toString() {
    return 'SignUpTalk{number: $number, speakerName: $speakerName, topic: $topic}';
  }

}

class ReviseTalkPressed extends TalkSignUpEvent {
  const ReviseTalkPressed({@required this.number, @required this.speakerName, @required this.topic});

  final String number;
  final String speakerName;
  final String topic;

  @override
  List<Object> get props => [number, speakerName, topic];

  @override
  String toString() {
    return 'ReviseTalk{number: $number, speakerName: $speakerName, topic: $topic}';
  }


}
