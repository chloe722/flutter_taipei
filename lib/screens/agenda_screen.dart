import 'package:flutter/material.dart';
import 'package:flutter_taipei/data.dart';
import 'package:flutter_taipei/timeline.dart';
import 'package:flutter_taipei/timeline_item.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 100.0, left: 8.0, right: 8.0),
          child: Timeline(
            children: agendas.map((agenda) => TimelineItem(timeline: agenda)).toList(),
            indicators: <Widget>[
              Icon(Icons.access_alarm),
              Icon(Icons.backup),
              Icon(Icons.accessibility_new),
              Icon(Icons.access_alarm),
              Icon(Icons.access_alarm),
              Icon(Icons.backup),
              Icon(Icons.accessibility_new),
              Icon(Icons.access_alarm),
            ],
          ),
        ),
      ),
    );
  }
}
