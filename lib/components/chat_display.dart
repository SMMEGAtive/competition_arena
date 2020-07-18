import 'package:competition_arena/http/chat_service.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/models/chat_message.dart';
import 'package:competition_arena/models/chat_message_data.dart';
import 'package:competition_arena/models/chat_room_data.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:flutter/material.dart';

class ChatDisplay extends StatefulWidget {
  final ChatRoomData data;
  UserService userService = UserService();
  final MeData me;

  ChatDisplay({this.data, this.me});

  @override
  State<StatefulWidget> createState() =>
      _ChatDisplayState(user: me.id, data: data);
}

class _ChatDisplayState extends State<ChatDisplay> {
  ChatService chatService = ChatService();
  Future<List<ChatMessageData>> message;
  final int user;
  final ChatRoomData data;

  _ChatDisplayState({this.user, this.data});

  Future<List<ChatMessageData>> loadMessages() async {
    message = chatService.doGetListFromRoom(data.idRoom);
    return message;
  }

  initState() {
    loadMessages();
    super.initState();
  }

  loadChat() {
    var chat = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FutureBuilder(
          future: loadMessages(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ChatMessageData>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                //itemCount harus dibikin dinamis nanti
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,

                //Buat build list
                itemBuilder: (context, index) {
                  return Message(
                    data: snapshot.data[index],
                    user: user,
                  );
                },
              );
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
          },
        ),
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

class Message extends StatelessWidget {
  final ChatMessageData data;
  final int user;

  Message({this.data, this.user});

  @override
  Widget build(BuildContext context) {
    var profile = Expanded(
        child: Padding(
          child: Text(data.username, overflow: TextOverflow.ellipsis, maxLines: 1,),
          padding: EdgeInsets.symmetric(horizontal: 5.0),
        ),
        flex: 2);
    var message = Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            data.message,
            textAlign: TextAlign.right,
          ),
        ),
        flex: 7);
    var messageLeft = Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            data.message,
            textAlign: TextAlign.left,
          ),
        ),
        flex: 7);

    var location;

    if (data.idUser == user) {
      location = Row(
        children: <Widget>[
          message,
          Container(
            width: 2,
            color: ColorPalette.black,
            height: 15,
          ),
          profile
        ],
      );
    } else {
      location = Row(
        children: <Widget>[
          profile,
          Container(
            width: 2,
            color: ColorPalette.black,
            height: 15,
          ),
          messageLeft
        ],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: location,
    );
  }
}

/* class ChatMessage extends StatelessWidget {
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
} */
