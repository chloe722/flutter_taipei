import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({this.label, this.onPress, this.loading});

  final String label;
  final VoidCallback onPress;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      onPressed: loading? null : onPress,
      disabledColor: Colors.grey[400],
      splashColor: Colors.grey,
      child: loading
          ? CircularProgressIndicator()
          : Text(label, style: TextStyle(color: Colors.white)),
      color: kLightGreen,
    );
  }
}
