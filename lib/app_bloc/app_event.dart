import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {

  @override
  List<Object> get props => [];
}


class AppStarted extends AppEvent{}


