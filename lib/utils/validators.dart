class Validators {

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidNumber(String number) {
    return number != null && number.isNotEmpty;
  }

  static isValidName(String name) {
    return name != null && name.isNotEmpty;
  }

  static isValidTopic(String topic) {
    return topic != null && topic.isNotEmpty;
  }


}