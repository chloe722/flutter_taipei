
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _firestore = Firestore();


Future<bool> isNumberValidated(String number) async {

  QuerySnapshot snapshot = await _firestore.collection("valid_numbers").getDocuments();
  print(snapshot.documents);

  return snapshot.documents.contains(number);

}

