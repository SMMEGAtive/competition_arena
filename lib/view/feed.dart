import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/components/competition_item.dart';
import 'package:competition_arena/components/competition_list.dart';
import 'package:competition_arena/view/competition.dart';
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

  var item = Flexible(
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
            Container(child: option),
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
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Text(text),
      ),
    );
  }
}

class FeedItem extends StatelessWidget {
  final String title;
  final String date;
  final String imageURL;
  final String status;
  final String description;

  FeedItem({
    Key key,
    this.title,
    this.date,
    this.imageURL,
    this.status,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget item = Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            width: 120,
            height: 120,
            child: Image.network(
              imageURL,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title),
              Text('Tanggal ' + status + ':'),
              Text(date),
              Text(description)
            ],
          )
        ],
      ),
    );

    var linkItem = InkWell(
      child: item,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Competition(),
          ),
        );
      },
    );

    return linkItem;
  }
}
