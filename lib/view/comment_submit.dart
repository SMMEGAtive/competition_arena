import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/components/comment_section.dart';
import 'package:competition_arena/http/comment_service.dart';
import 'package:competition_arena/models/comment_data.dart';
import 'package:competition_arena/view/submission_display.dart';
import 'package:flutter/material.dart';

class CommentSubmit extends StatelessWidget {
  final int idSubmission;
  final int idCommentParent;
  CommentService commentService = CommentService();
  CommentData parentComment;
  TextEditingController comment = TextEditingController();

  CommentSubmit({this.idSubmission, this.idCommentParent});

  send() async {
    int idParent;
    if (idCommentParent != null) {
      CommentData data =
          await commentService.doPostOne(idSubmission, comment.text);
    } else {
      CommentData data =
          await commentService.doReply(idParent, idSubmission, comment.text);
    }
  }

  getParentComment() async {
    parentComment = await commentService.doGetOne(idCommentParent);
  }

  @override
  Widget build(BuildContext context) {
    var commentParentData;
    if (idCommentParent != null) {
      getParentComment();
      commentParentData = Container(
        child: Column(
          children: <Widget>[
            Text('User: ${parentComment.username}'),
            Text('Comment: ${parentComment.content}')
          ],
        ),
      );
    } else {
      commentParentData = Container();
    }
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          commentParentData,
          TextField(
            decoration: InputDecoration(labelText: 'Isi Komentar'),
            maxLines: 4,
            controller: comment,
          ),
          ButtonCustom(
            text: 'Send',
            onPress: () {
              if (comment.text.length != 0) {
                send();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Berhasil'),
                    content: Text('Komentar terkirim'),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubmissionDisplay(),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Tolong isi komentar anda'),
                  ),
                );
              }
            },
          )
        ],
      )),
    );
  }
}
