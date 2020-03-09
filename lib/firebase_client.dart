import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';

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
    return true;
  } else {
    return false;
  }
}

Future<void> removeSpeaker(String number) async {
  await _firestore.document("lightening_talk/$number").delete();
}
