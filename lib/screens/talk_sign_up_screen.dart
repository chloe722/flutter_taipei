import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/strings.dart';
import 'package:flutter_taipei/talk_sign_up_bloc/talk_signup_barrel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpLighteningTalkScreen extends StatelessWidget {
  SignUpLighteningTalkScreen({Repository repository}):
        assert (repository != null),
        _repository = repository;

  final Repository _repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider<TalkSignUpBloc>(
          create: (context) => TalkSignUpBloc(repository: _repository),
          child:SignUpTalkForm(),
        ));
  }
}


class SignUpTalkForm extends StatefulWidget {

  @override
  _SignUpTalkFormState createState() => _SignUpTalkFormState();
}

class _SignUpTalkFormState extends State<SignUpTalkForm> {

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

//  void initData() async {
//    _stream.add(await Repository().getExistingTalk());
//  }

  bool _loading = false;

  TalkSignUpBloc _bloc;


  bool get isPopulated => _numberController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _topicController.text.isNotEmpty;

  bool isSubmitButtonEnabled(TalkSignUpState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<TalkSignUpBloc>(context);
    _numberController.addListener(_onNumberChanged);
    _nameController.addListener(_onNameChanged);
    _topicController.addListener(_onTopicChanged);
//    initData();
    super.initState();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _topicController.dispose();
    _nameController.dispose();
    super.dispose();
  }


  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onNumberChanged() {
    _bloc.add(NumberChanged(number: _numberController.text));
  }

  void _onNameChanged() {
    _bloc.add(NameChanged(name: _nameController.text));
  }

  void _onTopicChanged() {
    _bloc.add(TopicChanged(topic: _topicController.text));
  }

  void _onSubmitted() {
    if (_formKey.currentState.validate()) {
      _bloc.add(SignUpTalkPressed(
          number: _numberController.text,
          speakerName: _nameController.text,
          topic: _topicController.text));
    }
  }

  Widget _formField(
      {TextEditingController controller,
        String hint,
        IconData icon,
        TalkSignUpState state,
        bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: (hint == kNumberHint)
            ? TextInputType.number
            : TextInputType.multiline,
        validator: (_) => _validateInput(type: hint, state: state),
        maxLines: null,
        autofocus: enabled,
        autocorrect: false,
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          icon: Icon(icon),
          hintText: hint,
        ),
      ),
    );
  }

  String _validateInput({String type, TalkSignUpState state}) {
    switch (type) {
      case kNumberHint:
        return !state.isNumberValid ? kErrorNumberInput : null;
      case kNameHint:
        return !state.isNameValid ? kErrorNameInput : null;
      case kTopicHint:
        return !state.isTopicValid ? kErrorTopicInput : null;
        default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TalkSignUpBloc, TalkSignUpState>(
      listener: (context, state) {
        if (state.isSuccess) {
          _loading = false;
          showToast(kSignUpSuccess);
          Navigator.pop(context);
        }

        if (state.isSubmitting) {
          _loading = true;
        }

        if (state.isFailed) {
          _loading = false;
          showToast(kInvalidNumberMsg);
        }
      },
      child: BlocBuilder<TalkSignUpBloc, TalkSignUpState>(
          builder: (context, state) {
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Spacer(flex: 1),
                      _formField(
                          hint: kNumberHint,
                          icon: Icons.confirmation_number,
                          controller: _numberController,
                          state: state),
                      _formField(
                          hint: kNameHint,
                          icon: Icons.person,
                          controller: _nameController,
                          state: state),
                      _formField(
                          hint: kTopicHint,
                          icon: MaterialCommunityIcons.thought_bubble,
                          controller: _topicController,
                          state: state),
                      Spacer(flex: 1),
                      SubmitButton(
                        label: kSignUp,
                        onPress:
                        isSubmitButtonEnabled(state)
                            ? _onSubmitted
                            : null,
                        loading: _loading,
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}


class SubmitButton extends StatelessWidget {
  SubmitButton({this.label, VoidCallback onPress, this.loading}): _onPress = onPress;

  final String label;
  final VoidCallback _onPress;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      onPressed: loading? null : _onPress,
      splashColor: Colors.grey,
      child: loading
          ? CircularProgressIndicator()
          : Text(label, style: TextStyle(color: Colors.white)),
      color: kBgColor,
    );
  }
}
