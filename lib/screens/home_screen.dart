import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/model/lightening_talk.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/screens/agenda_screen.dart';
import 'package:flutter_taipei/screens/lightening_talk_screen.dart';
import 'package:flutter_taipei/talk_sign_up/talk_sign_up_screen.dart';
import 'package:flutter_taipei/strings.dart';
import 'package:flutter_taipei/widgets/clipping_class.dart';
import 'package:flutter_taipei/widgets/custom_floating_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.repository, this.talk});

  final Repository repository;
  final LighteningTalk talk;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Repository get _repository => widget.repository;

  LighteningTalk get _talk => widget.talk;

  int _currentPage = 0;

  PageController _pageController;

  void bottomTapped(int index) {
    setState(() {
      _currentPage = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  void _onPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: _onPageChange,
      children: <Widget>[
        AgendaScreen(),
        TalkScreen(repository: _repository),
      ],
    );
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage, keepPage: true);
    super.initState();
  }

  void onPress(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpLighteningTalkScreen(
                repository: _repository, talk: _talk)));
  }

  @override
  Widget build(BuildContext context) {
    bool _isAgendaScreen = _currentPage == 0;
    bool _isTalkExisted = _talk != null;

    return Scaffold(
        appBar: AppBar(
          title: Text(_isAgendaScreen ? kAgendaTitle : kLighteningTalkTitle),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            //TODO delete
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => _repository.clearAll(),
            ),
          ],
        ),
        floatingActionButton: CustomFloatingButton(
          label: _isTalkExisted
              ? kEditingSubmittedTopic
              : kSignUpForLighteningTalk,
          icon: _isTalkExisted ? Icons.edit : Icons.add,
          onPress: () => onPress(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kDarkBgColor,
          selectedItemColor: kYellow,
          currentIndex: _currentPage,
          onTap: bottomTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(MaterialCommunityIcons.view_agenda),
                title: Text(kBottomNavAgendaTitle)),
            BottomNavigationBarItem(
                icon: Icon(MaterialCommunityIcons.microphone_variant),
                title: Text(kBottomNavTalksTitle)),
          ],
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
                clipper: ClippingClass(),
                child: Container(
                    height: 180.0,
                    width: MediaQuery.of(context).size.width,
                    color: kDarkBgColor)),
            buildPageView()
          ],
        ));
  }
}
