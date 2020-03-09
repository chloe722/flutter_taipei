import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:shared_preferences/shared_preferences.dart';

Firestore _firestore = Firestore();

Stream<List<LighteningTalk>> getLighteningTalks() {
  return _firestore
      .collection("lightening_talk")
      .reference()
      .orderBy("timeStamp", descending: false)
      .snapshots()
      .map((snapshot) {
    return snapshot.documents.map((document) {
      return LighteningTalk.fromFirebase(document);
    }).toList();
  });
}

Future<LighteningTalk> getExistingTalk() async {

  final prefData = await getDataFromPreferences();
  String _existNumber = prefData.number;
  print("existing num: $_existNumber");
  if (_existNumber != null) {
    print("existing num: $_existNumber");
    final snapshot = await _firestore.collection("lightening_talk").document(_existNumber).get();
    if (snapshot != null && snapshot.exists) {
      return LighteningTalk.fromFirebase(snapshot);
    }
  }
  return null;
}


Future<bool> isNumberValidated(String number) async {
  final snapshot =
      await _firestore.collection("valid_numbers").document(number).get();
  return (snapshot != null && snapshot.exists);
}

Future<bool> signUpLighteningTalk(
    {String number, String name, String topic}) async {
  var result = await isNumberValidated(number);
  print("result: ${number + name + topic}");

  if (result) {
    await _firestore.document("lightening_talk/$number").setData({
      "number": number,
      "timeStamp": FieldValue.serverTimestamp(),
      "name": name,
      "topic": topic,
    });
    await setDataInPreference(number:number, name: number, topic:topic);
    return true;
  } else {
    return false;
  }
}

Future<void> removeSpeaker(String number) async {
  await _firestore.document("lightening_talk/$number").delete();
}

Future<void> setDataInPreference({String number, String name, String topic}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('lightening_talk_number', number);
  await prefs.setString("speakerName", name);
  await prefs.setString('topic', topic);
}

Future<LighteningTalk> getDataFromPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return Future.value(LighteningTalk(number: prefs.getString('lightening_talk_number')
  ,speakerName: prefs.getString("speakerName")
  ,topic: prefs.getString('topic')));
}

