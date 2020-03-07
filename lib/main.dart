import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_taipei/screens/agenda_screen.dart';
import 'package:flutter_taipei/screens/talk_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey[200]
      ),
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  List<Widget> _tabs = [
    AgendaScreen(),
    TalkScreen(),
  ];

  void _onTabTap(int index){
    setState(() {
      _currentTab = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: _onTabTap,
        items: [
          BottomNavigationBarItem(icon: Icon(MaterialCommunityIcons.view_agenda), title: Text("查看流程")),
          BottomNavigationBarItem(icon: Icon(MaterialCommunityIcons.microphone_variant), title: Text("現場分享")),
        ],
      ),
      body: _tabs[_currentTab]
    );
  }
}
