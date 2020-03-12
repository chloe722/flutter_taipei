import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';

class LighteningTalkItem extends StatefulWidget {
  LighteningTalkItem({this.talk, this.number, this.animation});

  final LighteningTalk talk;
  final String number;
  final animation;

  @override
  _LighteningTalkItemState createState() => _LighteningTalkItemState();
}

class _LighteningTalkItemState extends State<LighteningTalkItem> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<Offset> _offsetAnimation;

  Widget _buildNumber() {
    return Text(widget.number,
        style: TextStyle(color: Colors.lightBlue, fontSize: 28.0));

  }

  @override
  void initState() {
//    // TODO: implement initState
//    _animationController = AnimationController(duration: Duration(seconds: 5), vsync: this);
//
//    _offsetAnimation = Tween<Offset>(
//      begin: Offset.zero,
//      end: Offset(1.0, 0.0),
//    ).animate(CurvedAnimation(
//      parent: _animationController,
//      curve: Curves.easeIn,
//    ));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
//    _animationController.dispose();
    super.dispose();
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
              widget.talk.topic,
              softWrap: true,
              style: kHeadingTextStyle,
            ),
            subtitle: Text(widget.talk.speakerName, softWrap: true),
          )),
    );
  }
}
