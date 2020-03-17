import 'package:equatable/equatable.dart';
import 'package:flutter_taipei/model/speaker.dart';

class Agenda extends Equatable{
  String date;
  String time;
  String icon;
  String content;
  String duration;
  Speaker speaker;

  Agenda({this.date, this.time, this.icon, this.content, this.duration,
      this.speaker});


  factory Agenda.fromDatabase({String date, String time, String icon, String content, String duration,
    String name, Speaker speaker }) {
    return Agenda()..date = date
        ..time = time
        ..icon = icon
        ..content = content
        ..duration = duration
        ..speaker = speaker;

  }

  @override
  List<Object> get props => [date, time, icon, content, duration, speaker];

  @override
  String toString() {
    return 'Agenda{date: $date, time: $time, icon: $icon, content: $content, duration: $duration, speaker: $speaker}';
  }


}