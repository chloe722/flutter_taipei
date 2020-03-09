import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/database.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpLighteningTalkScreen extends StatefulWidget {
  @override
  _SignUpLighteningTalkScreenState createState() =>
      _SignUpLighteningTalkScreenState();
}

class _SignUpLighteningTalkScreenState
    extends State<SignUpLighteningTalkScreen> {
  final TextEditingController numberController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController topicController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  final StreamController<LighteningTalk> _stream = StreamController();

  Widget _formField(
      {TextEditingController controller,
      String hint,
      IconData icon,
      bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: (hint == kNumberHint)
            ? TextInputType.number
            : TextInputType.multiline,
        validator: (val) => _validateInput(type: hint, val: val),
        maxLines: null,
        autofocus: enabled,
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          icon: Icon(icon),
          hintText: hint,
        ),
      ),
    );
  }

  String _validateInput({String type, String val}) {
    switch (type) {
      case kNumberHint:
        return (val.isEmpty) ? kErrorNumberInput : null;
      case kNameHint:
        return (val.isEmpty) ? kErrorNameInput : null;
      case kTopicHint:
        return (val.isEmpty) ? kErrorTopicInput : null;
      default:
        return null;
    }
  }

  Future<void> _signUp() async {
    setState(() {
      _loading = true;
    });
    if (_formKey.currentState.validate()) {
      String _number = numberController.value.text;
      String _name = nameController.value.text;
      String _topic = topicController.value.text;

      var result = await signUpLighteningTalk(
          name: _name, number: _number, topic: _topic);

      setState(() {
        _loading = false;
        if (result) {
          showToast("登記成功！");
          Navigator.pop(context);
        } else {
          showToast("號碼無效，請檢查輸入的號碼是否確");
        }
      });
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void initData() async {
    _stream.add(await getExistingTalk());
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _stream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<LighteningTalk>(
            stream: _stream.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data;
                print("1stream data: $data");
                numberController.text = data.number;
                nameController.text = data.speakerName;
                topicController.text = data.topic;
              }
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Spacer(flex: 1),
                        _formField(
                            hint: kNumberHint,
                            icon: Icons.confirmation_number,
                            controller: numberController,
                            enabled: numberController.text.isEmpty),
                        _formField(
                            hint: kNameHint,
                            icon: Icons.person,
                            controller: nameController),
                        _formField(
                            hint: kTopicHint,
                            icon: MaterialCommunityIcons.thought_bubble,
                            controller: topicController),
                        Spacer(flex: 1),
                        numberController.text.isEmpty
                            ? CustomButton(
                                label: kSignUp,
                                onPress: _signUp,
                                loading: _loading,
                              )
                            : CustomButton(
                                label: kEditingSubmittedTopic,
                                onPress: _signUp,
                                loading: _loading,
                              ),
                        Spacer(flex: 1),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({this.label, this.onPress, this.loading});

  final String label;
  final Function onPress;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      onPressed: loading ? null : () => onPress(),
      splashColor: Colors.grey,
      child: loading
          ? CircularProgressIndicator()
          : Text(label, style: TextStyle(color: Colors.white)),
      color: kBgColor,
    );
  }
}
