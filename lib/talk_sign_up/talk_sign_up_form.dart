import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_taipei/app_bloc/app_bloc.dart';
import 'package:flutter_taipei/app_bloc/app_event.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/strings.dart';
import 'package:flutter_taipei/talk_sign_up/talk_sign_up_bloc/talk_signup_barrel.dart';
import 'package:flutter_taipei/utils/messager.dart';
import 'package:flutter_taipei/widgets/submit_buttom.dart';

class TalkSignUpForm extends StatefulWidget {
  TalkSignUpForm({this.talk});

  final LighteningTalk talk;

  @override
  _TalkSignUpFormState createState() => _TalkSignUpFormState();
}

class _TalkSignUpFormState extends State<TalkSignUpForm> {

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  bool _isTalkedExisted = false;

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
    super.initState();
  }


  @override
  void didChangeDependencies() {
    _isTalkedExisted = widget.talk != null;
    if (widget.talk != null) {
      _numberController.text= widget.talk.number;
      _nameController.text = widget.talk.speakerName;
      _topicController.text = widget.talk.topic;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _topicController.dispose();
    _nameController.dispose();
    super.dispose();
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
      _bloc.add(SubmitTalkPressed(
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
    bool _isNumberField = hint == kNumberHint;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: _isNumberField
            ? TextInputType.number
            : TextInputType.multiline,
        validator: (_) => _validateInput(type: hint, state: state),
        maxLines: null,
        maxLength: _isNumberField && enabled == true? 6 : null,
        autocorrect: false,
        autofocus: true,
        decoration: kFormFieldDecoration.copyWith(
          icon: Icon(icon,color: kGhostWhite,),
          hintText: hint,
        )
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
          BlocProvider.of<AppBloc>(context).add(AppStarted());
          showToast(kSignUpSuccess);
          Navigator.pop(context);
        }

        if (state.isSubmitting) {
          FocusScope.of(context).requestFocus(FocusNode());
          _loading = true;

        }

        if (state.isFailed) {
          _loading = false;
          showToast(kInvalidNumberMsg);
        }
      },
      child: BlocBuilder<TalkSignUpBloc, TalkSignUpState>(
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _formField(
                          hint: kNumberHint,
                          icon: Icons.confirmation_number,
                          controller: _numberController,
                          enabled: _isTalkedExisted == false,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: SubmitButton(
                          label: _isTalkedExisted? kEditingSubmittedTopic : kSignUp,
                          onPress: isSubmitButtonEnabled(state)
                              ? _onSubmitted
                              : null,
                          loading: _loading,
                        ),
                      ),
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