import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/database.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/screens/sign_up_lightening_talk_screen.dart';
import 'package:flutter_taipei/strings.dart';

class TalkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kLighteningTalkTitle),
        backgroundColor: kBgColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 8.0,
        label: Row(
          children: <Widget>[
            Icon(Icons.add),
            Text(kSignUpForLighteningTalk),
          ],
        ),
        onPressed: () {
          return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpLighteningTalkScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: StreamBuilder<List<LighteningTalk>>(
            stream: getLighteningTalks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                CircularProgressIndicator();

              if (snapshot.hasData && snapshot.data != null) {
                final _data = snapshot.data;
                print(_data);
                return _data.isNotEmpty
                    ? ListView.builder(
                        itemCount: _data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => LighteningTalkItem(
                          talk: _data[index],
                          number: (index + 1).toString(),
                        ),
                      )
                    : Container(
                        child: Center(child: Text("成為第一個分享者吧！")),
                      );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

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
