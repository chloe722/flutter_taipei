import 'package:cloud_firestore/cloud_firestore.dart';

class LighteningTalk {
  final String number;
  final String speakerName;
  final String topic;
  final Timestamp timestamp;


  LighteningTalk({this.number, this.speakerName, this.topic, this.timestamp});

  factory LighteningTalk.fromFirebase(DocumentSnapshot snapshot){

    return LighteningTalk(
      number: snapshot.documentID,
      topic: snapshot.data["topic"],
      speakerName: snapshot.data["name"],
      timestamp: snapshot.data["timestamp"],
    );
  }
}