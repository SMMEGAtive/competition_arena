import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/chat_display.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBarCustom(
        hasBackButton: true,
        title: 'Nama Penggunanya',
      ),
      body: ChatDisplay(),
    );
  }
}
