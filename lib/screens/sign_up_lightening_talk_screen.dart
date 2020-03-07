import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/strings.dart';


class SignUpLighteningTalkScreen extends StatefulWidget {
  @override
  _SignUpLighteningTalkScreenState createState() => _SignUpLighteningTalkScreenState();
}

class _SignUpLighteningTalkScreenState extends State<SignUpLighteningTalkScreen> {
  final TextEditingController numberController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController topicController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget _formField(
      {TextEditingController controller,
      String hint,
      IconData icon}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          controller: controller,
          keyboardType: (hint == kNumberHint)? TextInputType.number : TextInputType.text,
          validator: (val) => _validateInput(type: hint, val: val),
          decoration: InputDecoration(
            filled: true,
            border: InputBorder.none,
            icon: Icon(icon),
            hintText: hint,
          ),
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
        return (val.isEmpty)? kErrorNameInput : null;
      case kTopicHint:
        return (val.isEmpty)? kErrorTopicInput : null;
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

  Widget _content() {
    return  Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _formField(
                hint: kNumberHint,
                icon: Icons.confirmation_number,
                controller: numberController,),
              _formField(
                  hint: kNameHint,
                  icon: Icons.person,
                  controller: nameController),
              _formField(
                  hint: kTopicHint,
                  icon: MaterialCommunityIcons.thought_bubble,
                  controller: topicController),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: RaisedButton(
                  onPressed: () => _signUp(),
                  splashColor: Colors.grey,
                  child: Text(kSignUp, style: TextStyle(color: Colors.white)),
                  color: kBgColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0.0,
      child: _content(),
    );
  }
}
