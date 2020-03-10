import 'package:flutter/material.dart';
import 'package:flutter_taipei/data.dart';
import 'package:flutter_taipei/widgets/timeline_item.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: agendas.length,
              itemBuilder: (context, index) => AgendaItem(
                    agenda: agendas[index],
                  ))),
    );
  }
}
