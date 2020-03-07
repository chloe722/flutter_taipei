import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/model/speaker.dart';
import 'package:flutter_taipei/strings.dart';

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

  Widget _formField(
      {TextEditingController controller, String hint, IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType:
            (hint == kNumberHint) ? TextInputType.number : TextInputType.multiline,
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
        if (val.isEmpty) {
          return kErrorNumberInput;
        } else if (_validateNumber() == false) {
          return kInvalidNumberInput;
        } else {
          return null;
        }
        break;

      case kNameHint:
        return (val.isEmpty) ? kErrorNameInput : null;
      case kTopicHint:
        return (val.isEmpty) ? kErrorTopicInput : null;
      default:
        return null;
    }
  }

  bool _validateNumber() {
    //TODO
    return true;
  }

  void _signUp() {
    if (_formKey.currentState.validate()) {
      String _number = numberController.value.text;
      String _name = nameController.value.text;
      String _topic = topicController.value.text;

      print(_number + _name + _topic);
      Navigator.pop(context);
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    onPressed: () => _signUp(),
                    splashColor: Colors.grey,
                    child: Text(kSignUp, style: TextStyle(color: Colors.white)),
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
