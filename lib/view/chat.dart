import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/chat_display.dart';
import 'package:competition_arena/http/chat_service.dart';
import 'package:competition_arena/models/chat_room_data.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final ChatRoomData data;
  final MeData me;

  Chat({this.data, this.me});

  @override
  State<StatefulWidget> createState() => _ChatState(data: data, me: me);
}

class _ChatState extends State<Chat> {
  final ChatRoomData data;
  final MeData me;
  TextEditingController text = TextEditingController();
  ChatService chatService = ChatService();
  String image = '';

  _ChatState({this.data, this.me});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBarCustom(
        hasBackButton: true,
        title: data.roomName,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ChatDisplay(data: data, me: me),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        child: TextField(
                  controller: text,
                ))),
                Container(
                    child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (image == '') {
                      chatService
                          .doSendMessageWithoutImage(
                              data.idRoom, me.id, text.text)
                          .then((status) {
                        setState(() {
                          text.text = '';
                        });
                      });
                    }
                  },
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
