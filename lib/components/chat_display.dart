import 'package:competition_arena/models/chat_message.dart';
import 'package:flutter/material.dart';

class ChatDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatDisplayState();
}

class _ChatDisplayState extends State<ChatDisplay> {
  loadChat() {
    var chat = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: ChatMessage(
            text: 'Test',
            user: 'MEGAtive',
          ),
        ),
        Flexible(
          child: ChatMessage(
            text: 'sample gambar',
            imgUrl:
                'https://gbf.wiki/images/thumb/6/66/Rupies_square.jpg/25px-Rupies_square.jpg',
            user: 'not-MEGAtive',
          ),
        ),
        Flexible(
          child: ChatMessage(
            imgUrl:
                'https://gbf.wiki/images/thumb/6/66/Rupies_square.jpg/25px-Rupies_square.jpg',
            user: 'MEGAtive',
          ),
        )
      ],
    );

    return chat;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: loadChat(),
      ),
    );
  }
}

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