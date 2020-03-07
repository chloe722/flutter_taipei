import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/data.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';

class TalkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("現場分享者"),
        backgroundColor: kBgColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 8.0,
        label: Row(
          children: <Widget>[
            Icon(Icons.add),
            Text("報名分享"),
          ],
        ),
        onPressed: () {
          print("click");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: ListView.builder(
          itemCount: lighteningTalks.length,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              LighteningTalkItem(talk: lighteningTalks[index]),
        ),
      ),
    );
  }
}

class LighteningTalkItem extends StatelessWidget {
  LighteningTalkItem({this.talk});

  final LighteningTalk talk;

  Widget _buildNumber() {
    return Text(talk.orderNumber,
        style: TextStyle(color: Colors.lightBlue, fontSize: 28.0));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Card(
        elevation: 4.0,
          child: ListTile(
            leading: _buildNumber(),
            title: Text(talk.topic, softWrap: true,),
            subtitle: Text(talk.speakerName, softWrap: true),
          )),
    );
  }
}
