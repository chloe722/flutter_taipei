import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_taipei/agenda/agenda_bloc/agenda_bloc.dart';
import 'package:flutter_taipei/agenda/agenda_bloc/agenda_state.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/widgets/timeline_item.dart';

class AgendaScreen extends StatelessWidget {
  AgendaScreen({this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaBloc, AgendaState>(
      builder: (context, state) {
        if (state is AgendaUninitialized) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is AgendaLoaded) {
          if (state.agendas.isEmpty) {
            return Center(child: Text("No Agenda"));
          }

          return Center(
            child: Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.agendas.length,
                    itemBuilder: (context, index) => AgendaItem(
                          agenda: state.agendas[index],
                        ))),
          );
        }
      },
    );
  }
}
