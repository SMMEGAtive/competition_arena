import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/settings.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Profile',
        hasBackButton: false,
        actions: <Widget>[
          InkWell(
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 20, color: ColorPalette.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          )
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 200,
                  color: ColorPalette.gray_400,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(
                            'https://rhythmega.s-ul.eu/lBdht0Rt'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Text('MEGAtive'),
                  Text('Administrator'),
                ],
              ),
            ),
            DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(child: Text('Deskripsi'),),
                      Tab(child: Text('Lomba yang sedang diikuti'),),
                      Tab(child: Text('Lomba yang pernah diikuti'),),
                    ],
                  ),
                  title: Text('Tabs Demo'),
                ),
                body: TabBarView(
                  children: [
                    Icon(Icons.directions_car),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
