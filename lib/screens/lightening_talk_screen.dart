import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/database.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/screens/sign_up_lightening_talk_screen.dart';
import 'package:flutter_taipei/strings.dart';
import 'package:flutter_taipei/widgets/lightening_talk_item.dart';

class TalkScreen extends StatelessWidget {
  void onPress(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SignUpLighteningTalkScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kLighteningTalkTitle),
        backgroundColor: kBgColor,
      ),
      floatingActionButton: CustomFloatingButton(
        label: kSignUpForLighteningTalk,
        icon: Icons.add,
        onPress: () => onPress(context),
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
                        child: Center(child: Text("趕快插頭香！大家等你分享呢！")),
                      );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

class CustomFloatingButton extends StatelessWidget {
  CustomFloatingButton({this.label, this.icon, this.onPress});

  final String label;
  final IconData icon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      isExtended: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 8.0,
      label: Row(
        children: <Widget>[
          Icon(icon),
          Text(label),
        ],
      ),
      onPressed: onPress,
    );
  }
}
