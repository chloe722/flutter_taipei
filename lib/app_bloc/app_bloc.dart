import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_taipei/app_bloc/app_event.dart';
import 'package:flutter_taipei/app_bloc/app_state.dart';
import 'package:flutter_taipei/repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({@required Repository repository})
      : assert(repository != null),
        _repository = repository;

  final Repository _repository;

  @override
  AppState get initialState => Uninitialized();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
  }

  Stream<AppState> _mapAppStartedToState() async* {
    final result = await _repository.getExistingTalk();
    yield Initialize(talk: result);
  }
}
