import 'package:flutter/cupertino.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';

@immutable
class TalkSignUpState {
  final bool isNumberValid;
  final bool isNameValid;
  final bool isTopicValid;
  final bool isSuccess;
  final bool isFailed;
  final bool isSubmitting;

  bool get isFormValid => isNumberValid && isNameValid && isTopicValid;

  TalkSignUpState(
      {@required this.isNumberValid,
      @required this.isNameValid,
      @required this.isTopicValid,
      @required this.isSuccess,
      @required this.isFailed,
      @required this.isSubmitting});

  factory TalkSignUpState.talkExisted({LighteningTalk talk}) {
    return TalkSignUpState(
      isNumberValid: true,
      isNameValid: true,
      isTopicValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailed: false,

    );
  }

  factory TalkSignUpState.init() {
    return TalkSignUpState(
      isNumberValid: false,
      isNameValid: false,
      isTopicValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailed: false,
    );
  }

  factory TalkSignUpState.loading() {
    return TalkSignUpState(
      isNumberValid: true,
      isNameValid: true,
      isTopicValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailed: false,
    );
  }

  factory TalkSignUpState.success() {
    return TalkSignUpState(
      isNumberValid: true,
      isNameValid: true,
      isTopicValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailed: false,
    );
  }

  factory TalkSignUpState.failed() {
    return TalkSignUpState(
      isNumberValid: true,
      isNameValid: true,
      isTopicValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailed: true,
    );
  }

  TalkSignUpState copyWith({
    bool isNumberValid,
    bool isNameValid,
    bool isTopicValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailed,
  }) {
    return TalkSignUpState(
      isNumberValid: isNumberValid ?? this.isNumberValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isTopicValid: isTopicValid ?? this.isTopicValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
    );
  }

  TalkSignUpState update({
    bool isNumberValid,
    bool isNameValid,
    bool isTopicValid,
  }) {
    return copyWith(
      isNumberValid: isNumberValid,
      isNameValid: isNameValid,
      isTopicValid: isTopicValid,
      isSubmitting: false,
      isSuccess: false,
      isFailed: false,
    );
  }

  @override
  String toString() {
    return 'TalkSignUpState{'
        'isNumberValid: $isNumberValid,'
        ' isNameValid: $isNameValid,'
        ' isTopicValid: $isTopicValid,'
        ' isSuccess: $isSuccess, isFailed: $isFailed,'
        ' isSubmitting: $isSubmitting}';
  }
}
