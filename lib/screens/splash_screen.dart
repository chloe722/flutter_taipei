import 'package:flutter/material.dart';
import 'package:flutter_taipei/assets.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBgColor,
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage(kLogo),fit: BoxFit.fill),
                Loading(indicator: BallBeatIndicator(), size: 50.0, color: kYellow),
              ],
            ),
          ),
        ));
  }
}
