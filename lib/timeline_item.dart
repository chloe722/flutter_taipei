import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taipei/model/speaker.dart';
import 'package:flutter_taipei/model/timeline_item.dart';
import 'package:flutter_taipei/screens/talk_detail_screen.dart';

//class TimelineItem extends StatelessWidget {
//  TimelineItem({this.timeline});
//
//  final TimelineModel timeline;
//
//  //TODO add current event color by time
//
//  final Radius _radius = Radius.circular(16.0);
//
//
//  @override
//  Widget build(BuildContext context) {
//    bool _isTalk = timeline.speaker != null;
//

//    return InkWell(
//      onTap: _isTalk
//          ? () => Navigator.of(context).push(MaterialPageRoute(
//              builder: (context) =>
//                  TalkDetailScreen(speaker: timeline.speaker)))
//          : null,
//      child: Container(
//        padding: EdgeInsets.symmetric(vertical: 8.0),
//        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//        decoration: BoxDecoration(
//            color: Colors.grey[100],
//            shape: BoxShape.rectangle,
//            borderRadius: BorderRadius.only(
//                topRight: _radius, bottomRight: _radius, bottomLeft: _radius)),
//        child: Column(
//          mainAxisSize: MainAxisSize.max,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.symmetric(vertical: 16.0),
//              child: Text(
//                _isTalk? timeline.speaker.talkTopic : timeline.content,
//                textAlign: TextAlign.center,
//                style: TextStyle(fontWeight: _isTalk? FontWeight.bold : null),
//              ),
//            ),
//            if (timeline.speaker != null) SpeakerRow(speaker: timeline.speaker),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class SpeakerRow extends StatelessWidget {
//  SpeakerRow({this.speaker});
//
//  final Speaker speaker;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: EdgeInsets.only(left: 16.0),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        mainAxisSize: MainAxisSize.max,
//        children: <Widget>[
//          Hero(
//            tag: speaker.name,
//            child: Padding(
//              padding: EdgeInsets.only(right: 8.0),
//              child: Container(
//                  width: 30.0,
//                  height: 30.0,
//                  child: CircleAvatar(backgroundImage: AssetImage(speaker.photo))),
//            ),
//          ),
//          Text(
//            speaker.name,
//            style: TextStyle(color: Colors.grey),
//          )
//        ],
//      ),
//    );
//  }
//}

class TimelineItem extends StatelessWidget {
  final AgendaModel timeline;

  TimelineItem({this.timeline});

  Widget _image({bool isTalk}) {
    return Container(
        width: 50.0,
        height: 50.0,
        child: CircleAvatar(
            backgroundImage:
                AssetImage(isTalk ? timeline.speaker.photo : timeline.image)));
  }

  @override
  Widget build(BuildContext context) {
    bool _isTalk = timeline.speaker != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(timeline.time),
              ),
              ListTile(
                  leading: _isTalk
                      ? Hero(
                          tag: timeline.speaker.name,
                          child: _image(isTalk: _isTalk))
                      : _image(isTalk: _isTalk),
                  title: Text(
                      _isTalk ? timeline.speaker.talkTopic : timeline.content),
                  isThreeLine: _isTalk,
                  subtitle: _isTalk ? Text(timeline.speaker.name) : null,
                  trailing: Text("25 min"),
                  onTap: _isTalk
                      ? () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => TalkDetailScreen(
                                    speaker: timeline.speaker)),
                          )
                      : null),
            ],
          ),
        ),
      ),
    );
  }
}
