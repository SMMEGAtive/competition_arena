import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/components/chat_display.dart';
import 'package:competition_arena/components/competition_item.dart';
import 'package:competition_arena/components/competition_list.dart';
import 'package:competition_arena/http/chat_service.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/models/chat_room_data.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/view/competition.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class Feed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  ChatService chatService = ChatService();
  UserService userService = UserService();
  Future<List<ChatRoomData>> room;
  MeData me;

  Future<List<ChatRoomData>> loadChatRoom() async {
    room = chatService.doGetList();
    return room;
  }

  Future<MeData> loadMe() async {
    me = await userService.doGetLogged();
    return me;
  }

  @override
  void initState() {
    loadMe();
    loadChatRoom();
    super.initState();
  }

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
            FutureBuilder(
              future: loadChatRoom(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChatRoomData>> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data.length);
                  return ListView.builder(
                    //itemCount harus dibikin dinamis nanti
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,

                    //Buat build list
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Chat(data: snapshot.data[index], me: me),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Text(
                              snapshot.data[index].roomName,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
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
