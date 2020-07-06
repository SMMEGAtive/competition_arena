import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            minLines: 1,
            maxLines: 3,
          ),
          Comment(),
          Comment(),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String imgUrl;
  final String comment;
  final DateTime commentDate;
  final String username;

  Comment({
    this.imgUrl,
    this.comment,
    this.commentDate,
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://gbf.wiki/File:Weapon_b_1040008000.png'),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Nama User'),
                    Text('Tanggal komentar'),
                  ],
                ),
              ),
              Container(
                child: Text(
                  'Komentarnya',
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
