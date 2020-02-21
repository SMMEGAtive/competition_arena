import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:flutter/material.dart';

class Competition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        hasBackButton: true,
        title: 'Lomba 1',
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: Image.network('https://rhythmega.s-ul.eu/KGwwejMs',
                fit: BoxFit.cover),
          ),
          Flexible(
            child: Container(
              child: Text('Description'),
            ),
          ),
          Stack(
            children: <Widget>[
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(child: Text('Bottom Bar')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
