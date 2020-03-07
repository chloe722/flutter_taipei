import 'package:flutter/material.dart';
import 'package:flutter_taipei/data.dart';
import 'package:flutter_taipei/timeline.dart';
import 'package:flutter_taipei/timeline_item.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 100.0, left: 8.0, right: 8.0),
          child: Timeline(
//indicatorStyle: PaintingStyle.fill,
            indicatorSize: 50.0,
//            indicatorColor: Colors.deepOrangeAccent,
            children: agendas
                .map((agenda) => TimelineItem(timeline: agenda))
                .toList(),
            indicators: times
                .map((time) =>
                    Card(child: Text(time, style: TextStyle(fontWeight: FontWeight.bold))))
                .toList(),
          ),
        ),
      ),
    );
  }
}


