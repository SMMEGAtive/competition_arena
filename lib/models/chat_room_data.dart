// To parse this JSON data, do
//
//     final chatRoomData = chatRoomDataFromJson(jsonString);

import 'dart:convert';

ChatRoomData chatRoomDataFromJson(String str) => ChatRoomData.fromJson(json.decode(str));

String chatRoomDataToJson(ChatRoomData data) => json.encode(data.toJson());

class ChatRoomData {
    ChatRoomData({
        this.idRoom,
        this.roomName,
        this.members,
    });

    final int idRoom;
    final String roomName;
    final List<Member> members;

    factory ChatRoomData.fromJson(Map<String, dynamic> json) => ChatRoomData(
        idRoom: json["ID_Room"],
        roomName: json["Room_Name"],
        members: List<Member>.from(json["Members"].map((x) => Member.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ID_Room": idRoom,
        "Room_Name": roomName,
        "Members": List<dynamic>.from(members.map((x) => x.toJson())),
    };
}

class Member {
    Member({
        this.idUser,
        this.username,
    });

    final int idUser;
    final String username;

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        idUser: json["ID_User"],
        username: json["Username"],
    );

    Map<String, dynamic> toJson() => {
        "ID_User": idUser,
        "Username": username,
    };
}
