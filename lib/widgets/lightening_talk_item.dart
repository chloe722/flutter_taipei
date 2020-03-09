import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';

class LighteningTalkItem extends StatelessWidget {
  LighteningTalkItem({this.talk, this.number});

  final LighteningTalk talk;
  final String number;

  Widget _buildNumber() {
    return Text(number,
        style: TextStyle(color: Colors.lightBlue, fontSize: 28.0));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
          elevation: 4.0,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            leading: _buildNumber(),
            title: Text(
              talk.topic,
              softWrap: true,
              style: kHeadingTextStyle,
            ),
            subtitle: Text(talk.speakerName, softWrap: true),
          )),
    );
  }
}
