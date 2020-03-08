
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _firestore = Firestore();


Future<bool> isNumberValidated(String number) async {
  QuerySnapshot snapshot = await _firestore.collection("valid_numbers")
      .getDocuments();

  for (DocumentSnapshot document in snapshot.documents) {
    print(document.documentID);
     return number == document.documentID;
  }

  return false;
}

Future<bool> signUpLighteningTalk({String number, String name, String topic}) async {

  var result = await isNumberValidated(number);

  if (result) {
    await _firestore.document("lightening_talk/$number").setData({
      "number" : number,
      "timeStamp" : FieldValue.serverTimestamp(),
      "name" : name,
      "topic" : topic,
    });

    return true;
  } else {
    return false;
  }
}

Future<void> removeSpeaker(String number) async {
  await _firestore.document("lightening_talk/$number").delete();
}