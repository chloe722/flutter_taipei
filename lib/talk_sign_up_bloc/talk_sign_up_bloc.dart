import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/talk_sign_up_bloc/talk_signup_barrel.dart';
import 'package:flutter_taipei/validators.dart';
import 'package:rxdart/rxdart.dart';


class TalkSignUpBloc extends Bloc<TalkSignUpEvent, TalkSignUpState> {
  final Repository _repository;

  TalkSignUpBloc({@required Repository repository})
      : assert(repository != null),
        _repository = repository;

  @override
  TalkSignUpState get initialState => TalkSignUpState.init();


  @override
  Stream<TalkSignUpState> transformEvents(Stream<TalkSignUpEvent> events,
      Function next) {

    final shouldDebounce = (event) => (event is NumberChanged || event is NameChanged || event is TopicChanged);

    final nonDebounceStream = events.where((event) {
      return !shouldDebounce(event);
    });

    final debounceStream = events.where((event) {
      return shouldDebounce(event);
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);

  }


  @override
  Stream<TalkSignUpState> mapEventToState(TalkSignUpEvent event) async* {
    print("mapEventToState: ${event}");

    if (event is NumberChanged) {
      yield* _mapNumberChangedToState(event.number);
    } else if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is TopicChanged){
      yield* _mapTopicChangedToState(event.topic);
    } else if (event is SignUpTalkPressed) {
      yield* _mapSignUpTalkToState(number: event.number, name: event.speakerName, topic: event.topic);
    }
//    else if (event is ReviseTalkPressed) {
//      yield* _mapReviseTalkToState();
//    }
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

  Stream<TalkSignUpState> _mapSignUpTalkToState({String number, String name, String topic}) async* {

    yield TalkSignUpState.loading();
    final result = await _repository.signUpLighteningTalk(number: number, name: name, topic: topic);
    if (result) {
        yield TalkSignUpState.success();
      } else {
        yield TalkSignUpState.failed();
      }
  }

//  //TODO might delete
//  Stream<TalkSignUpState> _mapReviseTalkToState({String number, String name, String topic}) async* {
//
//    try{
//      await _repository.signUpLighteningTalk(number: number, name: name, topic: topic);
//      yield TalkSignUpState.success();
//    } catch(_) {
//      yield  TalkSignUpState.failed();
//    }
//  }


}
