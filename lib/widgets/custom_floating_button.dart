import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';

class CustomFloatingButton extends StatelessWidget {
  CustomFloatingButton({this.label, this.icon, this.onPress});

  final String label;
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      isExtended: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 8.0,
      backgroundColor: kLightGreen,
      icon: Icon(icon),
      label:  Text(label),
      onPressed: onPress,
    );
  }
}
