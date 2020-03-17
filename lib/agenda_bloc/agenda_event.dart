import 'package:equatable/equatable.dart';

abstract class AgendaEvent extends Equatable {


  @override
  List<Object> get props => [];

}


class Fetch extends AgendaEvent{}