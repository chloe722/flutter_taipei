import 'package:flutter/material.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/data.dart';
import 'package:flutter_taipei/strings.dart';
import 'package:flutter_taipei/widgets/clipping_class.dart';
import 'package:flutter_taipei/widgets/timeline_item.dart';

class AgendaScreen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.5,
        title: Text(kAgendaTitle),
        centerTitle: true,
        backgroundColor: kBgColor,
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
              clipper: ClippingClass(),
              child: Container(
                  height: 180.0,
                  width: MediaQuery.of(context).size.width,
                  color: kBgColor)),
          Center(
            child: Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: agendas.length,
                    itemBuilder: (context, index) => AgendaItem(
                          agenda: agendas[index],
                        ))),
          ),
        ],
      ),
    );
  }
}

