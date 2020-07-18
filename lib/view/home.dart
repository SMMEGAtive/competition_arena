import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/category_listing.dart';
import 'package:competition_arena/components/competition_list.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompetitionSubmit(),
            ),
          );
        },
      ),
    );
  }
}

class HomeStatus {
  static const int extended = 1;
  static const int collapsed = 2;
}
