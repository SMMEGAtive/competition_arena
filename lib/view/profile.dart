import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  loadProfilePicture() {
    return Container(
      height: 200,
      color: ColorPalette.gray_400,
      child: Stack(
        children: <Widget>[
          Container(
            height: 200,
            color: ColorPalette.gray_400,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage('https://rhythmega.s-ul.eu/lBdht0Rt'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Profile',
        hasBackButton: false,
        actions: <Widget>[
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SvgPicture.asset(
                'assets/gear.svg',
                width: 30.0,
                height: 30.0,
              ),
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
      body: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://rhythmega.s-ul.eu/lBdht0Rt'),
                    radius: 75,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'MEGAtive',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text('Administrator'),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            'Deskripsi',
                            style: TextStyle(color: ColorPalette.black),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Lomba yang sedang diikuti',
                            style: TextStyle(color: ColorPalette.black),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Lomba yang pernah diikuti',
                            style: TextStyle(color: ColorPalette.black),
                          ),
                        ),
                      ],
                    ),
                    body: TabBarView(
                      children: [
                        Icon(Icons.directions_car),
                        Icon(Icons.directions_transit),
                        Icon(Icons.directions_bike),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
