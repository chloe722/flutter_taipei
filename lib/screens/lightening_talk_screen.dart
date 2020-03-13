import 'package:flutter/material.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/strings.dart';
import 'package:flutter_taipei/widgets/lightening_talk_item.dart';

class TalkScreen extends StatelessWidget {
  TalkScreen({this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LighteningTalk>>(
        stream: repository.getLighteningTalks(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.hasData && snapshot.data != null) {
            final _data = snapshot.data;
            return snapshot.data.isNotEmpty
                ? ListView.builder(
                    itemCount: _data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => LighteningTalkItem(
                      talk: _data[index],
                      number: (index + 1).toString(),
                    ),
                  )
                : Container(
                    child: Center(child: Text(kEmptyTalkListPlaceholderText)),
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
