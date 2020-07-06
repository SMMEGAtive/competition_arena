import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/feed.dart';
import 'package:competition_arena/view/home.dart';
import 'package:competition_arena/view/profile.dart';
import 'package:competition_arena/view/statistic.dart';
import 'package:flutter/material.dart';

class PrimaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetList = <Widget>[
    Home(),
    Feed(),
    Statistic(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: ColorPalette.lightBlue_100,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.rss_feed,
              color: ColorPalette.lightBlue_100,
            ),
            title: Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.multiline_chart,
              color: ColorPalette.lightBlue_100,
            ),
            title: Text('Stat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: ColorPalette.lightBlue_100,
            ),
            title: Text('Profile'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorPalette.darkBlue_400,
        onTap: _onItemTapped,
      ),
    );
  }
}
