import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/model/speaker.dart';

class TalkDetailScreen extends StatefulWidget {
  TalkDetailScreen({this.speaker});

  final Speaker speaker;

  @override
  _TalkDetailScreenState createState() => _TalkDetailScreenState();
}

class _TalkDetailScreenState extends State<TalkDetailScreen> {

  Widget _content({String text, bool isHeading}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text,
          style: isHeading ? kHeadingTextStyle : kContentTextStyle,
          textAlign: TextAlign.center,
          softWrap: true),
    );
  }

  Widget _buildCard() {
    return Positioned(
      width: MediaQuery.of(context).size.width - 20,
      top: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 8.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _content(text: widget.speaker.name, isHeading: true),
                _content(text: widget.speaker.introduction, isHeading: false),
                _content(text: widget.speaker.talkTopic, isHeading: true),
                _content(text: widget.speaker.topicIntro, isHeading: false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Align(
      alignment: Alignment.topCenter,
      child: Hero(
        tag: widget.speaker.name,
        child: Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: CircleAvatar(
                backgroundImage: AssetImage(widget.speaker.photo))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBgColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kDarkBgColor,
      ),
      body: Center(
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            _buildCard(),
            _buildImage(),
          ],
        ),
      ),
    );
  }
}
