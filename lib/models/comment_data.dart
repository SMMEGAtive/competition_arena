// To parse this JSON data, do
//
//     final commentData = commentDataFromJson(jsonString);

import 'dart:convert';

CommentData commentDataFromJson(String str) => CommentData.fromJson(json.decode(str));

String commentDataToJson(CommentData data) => json.encode(data.toJson());

class CommentData {
    CommentData({
        this.idComment,
        this.idSubmission,
        this.idUser,
        this.username,
        this.idCommentParent,
        this.content,
        this.dateCreated,
        this.dateModified,
        this.avatarPath,
    });

    final int idComment;
    final int idSubmission;
    final int idUser;
    final String username;
    final int idCommentParent;
    final String content;
    final DateTime dateCreated;
    final DateTime dateModified;
    final String avatarPath;

    factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        idComment: json["ID_Comment"],
        idSubmission: json["ID_Submission"],
        idUser: json["ID_User"],
        username: json["Username"],
        idCommentParent: json["ID_Comment_Parent"],
        content: json["Content"],
        dateCreated: DateTime.parse(json["Date_Created"]),
        dateModified: DateTime.parse(json["Date_Modified"]),
        avatarPath: json["Avatar_Path"],
    );

    Map<String, dynamic> toJson() => {
        "ID_Comment": idComment,
        "ID_Submission": idSubmission,
        "ID_User": idUser,
        "Username": username,
        "ID_Comment_Parent": idCommentParent,
        "Content": content,
        "Date_Created": dateCreated.toIso8601String(),
        "Date_Modified": dateModified.toIso8601String(),
        "Avatar_Path": avatarPath,
    };
}
