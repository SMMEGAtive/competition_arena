import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/http/api_service.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/models/user_data.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserService userService = UserService();
  ApiServices api = ApiServices();
  Future<UserData> user;
  MeData me;

  initState() {
    loadProfile();
    super.initState();
  }

  Future<UserData> loadProfile() async {
    me = await userService.doGetLogged();
    if (me.id != null) {
      user = userService.doGetOne(me.id);
    }
    return user;
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
              FutureBuilder(
                future: loadProfile(),
                builder:
                    (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (snapshot.data != null
                                ? api.base_url +
                                    snapshot.data.avatarPath.substring(8)
                                : 'https://rhythmega.s-ul.eu/lBdht0Rt'),
                          ),
                          radius: 75,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://rhythmega.s-ul.eu/lBdht0Rt',
                          ),
                          radius: 75,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        )
                      ],
                    );
                  }
                },
              ),
              FutureBuilder(
                builder:
                    (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                  if (snapshot.hasData) {
                    String role = '';
                    if (me.role == 1) {
                      role = 'Admin';
                    } else if (me.role == 2) {
                      role = 'Penyelenggara Lomba';
                    } else if (me.role == 3) {
                      role = 'Pengguna';
                    } else {
                      role = 'visitor';
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            (snapshot.data.username != null
                                ? snapshot.data.username
                                : 'Test'),
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(role),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Bukan Pengguna',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text('Pengunjung'),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        )
                      ],
                    );
                  }
                },
                future: loadProfile(),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FutureBuilder(
                                future: loadProfile(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<UserData> snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15.0),
                                      child: Text(
                                        (snapshot.data.description != null
                                            ? snapshot.data.description
                                            : 'Tidak ada deskripsi'),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15.0),
                                      child: Text(
                                        '',
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      children: <Widget>[
                                        SizedBox(
                                          child: CircularProgressIndicator(),
                                          width: 60,
                                          height: 60,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 16),
                                          child: Text('Awaiting result...'),
                                        )
                                      ],
                                    );
                                  }
                                }),
                            Divider(
                              thickness: 2,
                            )
                          ],
                        ),
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
