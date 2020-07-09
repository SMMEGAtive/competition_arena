import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/category_listing.dart';
import 'package:competition_arena/components/competition_list.dart';
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
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CategoryListing(),
            Flexible(
              child: Container(
                child: CompetitionList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeStatus {
  static const int extended = 1;
  static const int collapsed = 2;
}
