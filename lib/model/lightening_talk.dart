import 'package:cloud_firestore/cloud_firestore.dart';

class LighteningTalk {
  final String number;
  final String speakerName;
  final String topic;
  final String orderNumber; //TODO orderNumber is signed up by the time
  final Timestamp timestamp;


  LighteningTalk({this.number, this.speakerName, this.topic,
      this.orderNumber, this.timestamp});

  factory LighteningTalk.fromFirebase(DocumentSnapshot snapshot){

    return LighteningTalk(
      number: snapshot.documentID,
      topic: snapshot.data["topic"],
      speakerName: snapshot.data["name"],
      timestamp: snapshot.data["timestamp"],
    );
  }
}