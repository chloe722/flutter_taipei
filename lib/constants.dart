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


const InputDecoration kFormFieldDecoration = InputDecoration(
  filled: true,
  border: InputBorder.none,
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),

);