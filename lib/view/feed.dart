import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/components/competition_item.dart';
import 'package:competition_arena/components/competition_list.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  var option = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ItemButton(
            text: 'Belum bayar',
          ),
          ItemButton(
            text: 'Menunggu verifikasi',
          ),
          ItemButton(
            text: 'Terverifikasi',
          ),
          ItemButton(
            text: 'Sedang berjalan',
          ),
          ItemButton(
            text: 'Selesai',
          ),
          ItemButton(
            text: 'Juara diumumkan',
          ),
        ],
      ),
    ),
  );

  var item = Container(
    child: CompetitionList(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Feed',
        hasBackButton: false,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            option,
            item,
          ],
        ),
      ),
    );
  }
}

class ItemButton extends StatelessWidget {
  final String text;
  final Function onPress;

  ItemButton({Key key, this.text, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(text),
      ),
    );
  }
}