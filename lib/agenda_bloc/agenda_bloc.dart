import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_taipei/agenda_bloc/agenda_event.dart';
import 'package:flutter_taipei/agenda_bloc/agenda_state.dart';
import 'package:flutter_taipei/model/agenda.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:rxdart/rxdart.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc({@required this.repository});

  Repository repository;

  @override
  AgendaState get initialState => AgendaUninitialized();

  @override
  Stream<AgendaState> transformEvents(
      Stream<AgendaEvent> events, Function next) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)), next);
  }

  @override
  Stream<AgendaState> mapEventToState(AgendaEvent event) async* {
    final currentState = state;

    if (event is Fetch) {
      if (currentState is AgendaUninitialized) {
        final agendas = await _fetchAgendas();
        yield AgendaLoaded(agendas: agendas);
      }
    }
  }

  Future<List<Agenda>> _fetchAgendas() async {
    final result = await repository.getAgenda();

    return result;
  }
}
