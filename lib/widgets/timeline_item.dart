import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/model/agenda.dart';
import 'package:flutter_taipei/model/speaker.dart';
import 'package:flutter_taipei/screens/talk_detail_screen.dart';


class AgendaItem extends StatelessWidget {
  final Agenda agenda;

  AgendaItem({this.agenda});

  Widget _image({bool isTalk}) {
    return Container(
        width: 50.0,
        height: 50.0,
        child: CircleAvatar(
            backgroundImage:
                AssetImage(isTalk ? agenda.speaker.photo : agenda.icon)));
  }

  @override
  Widget build(BuildContext context) {
    bool _isTalk = agenda.speaker != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        color: kGhostWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 23.0, bottom: 8.0),
                child: Text(agenda.time,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                  leading: _isTalk
                      ? Hero(
                          tag: agenda.speaker.name,
                          child: _image(isTalk: _isTalk))
                      : _image(isTalk: _isTalk),
                  title: Text(
                    _isTalk ? agenda.speaker.talkTopic : agenda.content,
                    style: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.w500, fontSize: 14.0),
                  ),
                  isThreeLine: _isTalk,
                  subtitle: _isTalk
                      ? Text(agenda.speaker.name)
                      : Container(child: null),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(Icons.access_time, size: 12.0),
                      ),
                      Text(
                        "${agenda.duration} m",
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  onTap: _isTalk
                      ? () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    TalkDetailScreen(speaker: agenda.speaker)),
                          )
                      : null),
            ],
          ),
        ),
      ),
    );
  }
}
