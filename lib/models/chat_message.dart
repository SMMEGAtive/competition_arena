
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String imgUrl;
  final String user;
  final DateTime sentTime;
  final DateTime deliveredTime;
  final DateTime readTime;

  ChatMessage({
    Key key,
    this.text,
    this.imgUrl,
    this.user,
    this.sentTime,
    this.deliveredTime,
    this.readTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image;
    var alignment;
    var displayText;

    if (user == 'MEGAtive') {
      alignment = Alignment.topRight;
    } else {
      alignment = Alignment.topLeft;
    }

    if (imgUrl != null) {
      image = Image.network(imgUrl);
    } else {
      image = Container();
    }

    if (text != null) {
      displayText = text;
    } else {
      displayText = '';
    }

    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        children: <Widget>[
          image,
          Text(displayText),
        ],
      ),
    );
  }
}