// To parse this JSON data, do
//
//     final chatMessageData = chatMessageDataFromJson(jsonString);

import 'dart:convert';

ChatMessageData chatMessageDataFromJson(String str) => ChatMessageData.fromJson(json.decode(str));

String chatMessageDataToJson(ChatMessageData data) => json.encode(data.toJson());

class ChatMessageData {
    ChatMessageData({
        this.idMessage,
        this.idRoom,
        this.idUser,
        this.message,
        this.imageUrl,
        this.sentTime,
        this.deliveredTime,
        this.readTime,
    });

    final int idMessage;
    final int idRoom;
    final int idUser;
    final String message;
    final String imageUrl;
    final DateTime sentTime;
    final DateTime deliveredTime;
    final DateTime readTime;

    factory ChatMessageData.fromJson(Map<String, dynamic> json) => ChatMessageData(
        idMessage: json["ID_Message"],
        idRoom: json["ID_Room"],
        idUser: json["ID_User"],
        message: json["Message"],
        imageUrl: json["Image_URL"],
        sentTime: DateTime.parse(json["Sent_Time"]),
        deliveredTime: DateTime.parse(json["Delivered_Time"]),
        readTime: DateTime.parse(json["Read_Time"]),
    );

    Map<String, dynamic> toJson() => {
        "ID_Message": idMessage,
        "ID_Room": idRoom,
        "ID_User": idUser,
        "Message": message,
        "Image_URL": imageUrl,
        "Sent_Time": sentTime.toIso8601String(),
        "Delivered_Time": deliveredTime.toIso8601String(),
        "Read_Time": readTime.toIso8601String(),
    };
}
