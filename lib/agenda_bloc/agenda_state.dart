import 'package:equatable/equatable.dart';
import 'package:flutter_taipei/model/agenda.dart';

abstract class AgendaState extends Equatable {
  @override
  List<Object> get props => [];
}

class AgendaUninitialized extends AgendaState {}

class AgendaError extends AgendaState {}

class AgendaLoaded extends AgendaState {
  AgendaLoaded({this.agendas});

  final List<Agenda> agendas;

  AgendaLoaded copyWith({
    List<Agenda> agendas,
    bool hasReachMax,
  }) {
    return AgendaLoaded(
      agendas: agendas ?? this.agendas,
    );
  }

  @override
  List<Object> get props => [agendas];

  @override
  String toString() {
    return 'AgendaLoaded{agendas: $agendas}';
  }
}
