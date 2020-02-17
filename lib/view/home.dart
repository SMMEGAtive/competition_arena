import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/category_listing.dart';
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
      body: CategoryListing() /* Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: CategoryListing(),
            flex: 0,
          )
        ],
      ) */,
    );
  }
}

class HomeStatus {
  static const int extended = 1;
  static const int collapsed = 2;
}
