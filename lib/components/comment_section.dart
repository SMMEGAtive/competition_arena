import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/http/api_service.dart';
import 'package:competition_arena/http/comment_service.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/models/comment_data.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/comment_submit.dart';
import 'package:competition_arena/view/submission_display.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final int idSubmission;

  CommentSection({this.idSubmission});
  @override
  State<StatefulWidget> createState() =>
      _CommentSectionState(idSubmission: idSubmission);
}

class _CommentSectionState extends State<CommentSection> {
  final int idSubmission;
  Future<List<CommentData>> data;
  MeData me;

  CommentService commentService = CommentService();
  UserService userService = UserService();

  _CommentSectionState({this.idSubmission});

  @override
  void initState() {
    getMe();
    super.initState();
  }

  Future<List<CommentData>> getList() async {
    data = commentService.doGetListFromSubmission(idSubmission);
    return data;
  }

  getMe() async {
    me = await userService.doGetLogged();
    setState(() {
      me = me;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ButtonCustom(
            text: 'Add Comment',
            color: ColorPalette.darkBlue_200,
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentSubmit(
                    idSubmission: idSubmission,
                  ),
                ),
              );
            },
          ),
          FutureBuilder(
            future: getList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CommentData>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  //itemCount harus dibikin dinamis nanti
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,

                  //Buat build list
                  itemBuilder: (context, index) {
                    return Comment(
                      comment: snapshot.data[index].content,
                      commentDate: snapshot.data[index].dateCreated,
                      username: snapshot.data[index].username,
                      avatarUrl: snapshot.data[index].avatarPath,
                      idSubmission: idSubmission,
                      idComment: snapshot.data[index].idComment,
                      idLoggedUser: me.id,
                      idCommenter: snapshot.data[index].idUser,
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
          )
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  ApiServices api = ApiServices();

  CommentService commentService = CommentService();
  final int idSubmission;
  final int idComment;
  final int idCommenter;
  final String avatarUrl;
  final String comment;
  final DateTime commentDate;
  final String username;
  final int idLoggedUser;

  Comment(
      {this.idSubmission,
      this.idComment,
      this.idCommenter,
      this.avatarUrl,
      this.comment,
      this.commentDate,
      this.username,
      this.idLoggedUser});

  deletThis() async {
    commentService.doDeleteOne(idComment);
  }

  @override
  Widget build(BuildContext context) {
    var avatar;
    if (avatarUrl.isEmpty) {
      avatar = 'https://zenius-i-vanisher.com/simfiles/Z-I-v%20Summer%20Contest%202020/Angelfalse/Angelfalse-jacket.png';
    } else {
      avatar = api.getBaseUrl() + '/' + avatarUrl.substring(8);
    }

    var delete;
    if (idLoggedUser == idCommenter) {
      delete = Container(
        child: InkWell(
          child: Text('Delete'),
          onTap: () {
            deletThis();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Berhasil'),
                content: Text('Komentar Terhapus'),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SubmissionDisplay(submissionID: idSubmission),
              ),
            );
          },
        ),
      );
    } else {
      delete = Container();
    }
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              backgroundImage: NetworkImage(avatar),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(username),
                    Text(commentDate.toIso8601String()),
                  ],
                ),
              ),
              Container(
                child: Text(
                  comment,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Container(
            child: InkWell(
              child: Text('Reply'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentSubmit(
                      idSubmission: idSubmission,
                      idCommentParent: idComment,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: delete,
          )
        ],
      ),
    );
  }
}
