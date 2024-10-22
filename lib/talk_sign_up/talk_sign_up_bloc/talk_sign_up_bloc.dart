import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_taipei/app_bloc/app_state.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/talk_sign_up/talk_sign_up_bloc/talk_signup_barrel.dart';
import 'package:flutter_taipei/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

class TalkSignUpBloc extends Bloc<TalkSignUpEvent, TalkSignUpState> {
  final Repository _repository;
  final LighteningTalk _talk;

  TalkSignUpBloc({@required Repository repository, LighteningTalk talk})
      : assert(repository != null),
        _repository = repository,
        _talk = talk;

  @override
  TalkSignUpState get initialState {
    return (_talk != null)? TalkSignUpState.hasTalk() : TalkSignUpState.init();
  }

  @override
  Stream<TalkSignUpState> transformEvents(
      Stream<TalkSignUpEvent> events, Function next) {
    final shouldDebounce = (event) => (event is NumberChanged ||
        event is NameChanged ||
        event is TopicChanged);

    final nonDebounceStream = events.where((event) {
      return !shouldDebounce(event);
    });

    final debounceStream = events.where((event) {
      return shouldDebounce(event);
    }).debounceTime(Duration(milliseconds: 300));

    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<TalkSignUpState> mapEventToState(TalkSignUpEvent event) async* {
    if (event is NumberChanged) {
      yield* _mapNumberChangedToState(event.number);
    } else if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is TopicChanged) {
      yield* _mapTopicChangedToState(event.topic);
    } else if (event is SubmitTalkPressed) {
      yield* _mapSubmitTalkToState(
          number: event.number, name: event.speakerName, topic: event.topic);
    }
  }

  Stream<TalkSignUpState> _mapNumberChangedToState(String number) async* {
    yield state.update(isNumberValid: Validators.isValidNumber(number));
  }

  Stream<TalkSignUpState> _mapNameChangedToState(String name) async* {
    yield state.update(isNameValid: Validators.isValidName(name));
  }

  Stream<TalkSignUpState> _mapTopicChangedToState(String topic) async* {
    yield state.update(isTopicValid: Validators.isValidTopic(topic));
  }

  Stream<TalkSignUpState> _mapSubmitTalkToState(
      {String number, String name, String topic}) async* {
    yield TalkSignUpState.loading();

    final result = await _repository.signUpLighteningTalk(
        number: number, name: name, topic: topic);
    if (result) {
      yield TalkSignUpState.success();
    } else {
      yield TalkSignUpState.failed();
    }
  }
}
