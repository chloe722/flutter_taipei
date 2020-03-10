import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_taipei/constants.dart';
import 'package:flutter_taipei/repository.dart';
import 'package:flutter_taipei/screens/agenda_screen.dart';
import 'package:flutter_taipei/screens/lightening_talk_screen.dart';
import 'package:flutter_taipei/screens/talk_sign_up_screen.dart';
import 'package:flutter_taipei/strings.dart';
import 'package:flutter_taipei/widgets/clipping_class.dart';
import 'package:flutter_taipei/widgets/custom_floating_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.repository});

  final Repository repository;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Repository get _repository => widget.repository;

  int _currentTab = 0;

  List<Widget> _tabs = [
    AgendaScreen(),
    TalkScreen(),
  ];

  void _onTabTap(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  void onPress(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SignUpLighteningTalkScreen(repository: _repository)));
  }

  @override
  Widget build(BuildContext context) {
    bool _isAgendaScreen = _currentTab == 0;

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.5,
          title: Text( _isAgendaScreen? kAgendaTitle : kLighteningTalkTitle),
          centerTitle: true,
          backgroundColor: kBgColor,
          elevation: 0.0,
        ),
        floatingActionButton: _isAgendaScreen
            ? null
            : CustomFloatingButton(
                label: kSignUpForLighteningTalk,
                icon: Icons.add,
                onPress: () => onPress(context),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: _onTabTap,
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
                    color: kBgColor)),
            _tabs[_currentTab]
          ],
        ));
  }
}
