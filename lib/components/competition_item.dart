import 'package:flutter/material.dart';

class CompetitionItem extends StatelessWidget {
  final String title;
  final String date;
  final String imageURL;
  final String status;
  final String description;

  CompetitionItem({
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
      margin: EdgeInsets.all(15),
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

    return item;
  }
}
