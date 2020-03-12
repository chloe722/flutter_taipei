import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle kHeadingTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16.0,

);

const TextStyle kContentTextStyle = TextStyle(
  height: 1.7
);

const Color kBgColor = Colors.lightBlueAccent;
const Color kDarkBgColor = Color(0xFF1b273e);
const Color kLightBgColor = Color(0xFF495266);
const Color kLightGreen = Color(0xFF31b9bd);
const Color kYellow = Color(0xFFd3b60e);
const Color kGhostWhite = Color(0xFFe8e9ea);


InputDecoration kFormFieldDecoration = InputDecoration(
  filled: true,
  fillColor: kGhostWhite,
  focusColor: kLightGreen,
  border:  OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: kLightGreen, width: 2.0)

  ),
  focusedBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: kLightGreen, width: 2.0),

  ),
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),


);