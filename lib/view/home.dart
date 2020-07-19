import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/category_listing.dart';
import 'package:competition_arena/components/competition_list.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/competition_meta.dart';
import 'package:competition_arena/view/competition_submit.dart';
import 'package:competition_arena/view/search.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int status;
  UserService userService = UserService();
  Future<MeData> me;

  Future<MeData> getMe() {
    me = userService.doGetLogged();
    return me;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Competition Arena",
        hasBackButton: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: ColorPalette.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text('Selemat Datang'),
            ),
            Flexible(
              child: Container(
                child: CompetitionList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FutureBuilder(
        future: getMe(),
          builder: (BuildContext context, AsyncSnapshot<MeData> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.role);
          if (snapshot.data.role == 1 || snapshot.data.role == 2) {
            return FloatingActionButton(
              child: Text('+'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompetitionSubmit(),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        } else if (snapshot.hasError) {
          return Column(
            children: <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ],
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
    );
  }
}

class HomeStatus {
  static const int extended = 1;
  static const int collapsed = 2;
}
