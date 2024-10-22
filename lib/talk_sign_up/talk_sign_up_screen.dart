import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/talk_sign_up/talk_sign_up_form.dart';

import '../assets.dart';
import 'talk_sign_up_bloc/talk_signup_barrel.dart';

class SignUpLighteningTalkScreen extends StatelessWidget {
  SignUpLighteningTalkScreen({Repository repository, LighteningTalk talk}):
        assert (repository != null),
        _repository = repository,
        _talk = talk;


  final Repository _repository;
  final LighteningTalk _talk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: kDarkBgColor,
        appBar: AppBar(
          backgroundColor: kDarkBgColor,
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(kTaipei101Bg), fit: BoxFit.fitWidth)),
            ),
            BlocProvider<TalkSignUpBloc>(
              create: (context) => TalkSignUpBloc(repository: _repository, talk: _talk),
              child:  TalkSignUpForm(talk: _talk,),
            ),
          ],

        ));
  }
}





