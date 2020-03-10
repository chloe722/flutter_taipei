import 'package:flutter/material.dart';

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
