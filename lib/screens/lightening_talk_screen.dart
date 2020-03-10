import 'package:flutter/material.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/strings.dart';
import 'package:flutter_taipei/widgets/lightening_talk_item.dart';

class TalkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<LighteningTalk>>(
          stream: Repository().getLighteningTalks(),
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
                      child: Center(child: Text(kEmptyTalkListPlaceholderText)),
                    );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
