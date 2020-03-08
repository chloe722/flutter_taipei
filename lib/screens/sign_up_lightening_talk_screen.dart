import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/firebase_client.dart';
import 'package:flutter_taipei/model/speaker.dart';
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

  Widget _formField(
      {TextEditingController controller, String hint, IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: (hint == kNumberHint)
            ? TextInputType.number
            : TextInputType.multiline,
        validator: (val) => _validateInput(type: hint, val: val),
        maxLines: null,
        autofocus: true,
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

      print("result: ${_number + _name + _topic}");

      var result = await signUpLighteningTalk(name: _name, number: _number, topic: _topic);

      setState(() {
        _loading = false;
        if (result) {
          Navigator.pop(context);
          print("登記成功！"); //TODO add toast
        } else {
          print("號碼無效，請檢查輸入的號碼是否確"); //TODO add toast
        }
      });


//      await isNumberValidated(_number).then((validated) async {
//        if (validated) {
//
//          setState(() {
//            _loading = false;
//            Navigator.pop(context);
//          });
//        } else {
//          setState(() {
//            _loading = false;
//            print("號碼無效，請檢查輸入的號碼是否確"); //TODO add toast
//          });
//        }
//      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
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
                  ),
                  _formField(
                      hint: kNameHint,
                      icon: Icons.person,
                      controller: nameController),
                  _formField(
                      hint: kTopicHint,
                      icon: MaterialCommunityIcons.thought_bubble,
                      controller: topicController),
                  Spacer(flex: 1),
                  MaterialButton(
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    onPressed: _loading ? null : () => _signUp(),
                    splashColor: Colors.grey,
                    child: _loading
                        ? CircularProgressIndicator()
                        : Text(kSignUp, style: TextStyle(color: Colors.white)),
                    color: kBgColor,
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ));
  }
}
