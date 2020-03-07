import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/model/speaker.dart';

class TalkDetailScreen extends StatelessWidget {
  TalkDetailScreen({this.speaker});

  final Speaker speaker;

  Widget _content({String text, bool isHeading}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text,
          style: isHeading ? kHeadingTextStyle : kContentTextStyle,
          textAlign: TextAlign.center,
          softWrap: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 50.0, left: 8.0, right: 8.0),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                    width: 100.0,
                    height: 100.0,
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    child: CircleAvatar(
                        backgroundImage: AssetImage(speaker.photo))),
                _content(text: speaker.name, isHeading: true),
                _content(text: speaker.introduction, isHeading: false),
                _content(text: speaker.talkTopic, isHeading: true),
                _content(text: speaker.topicIntro, isHeading: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
