import 'dart:convert';

import 'package:competition_arena/models/chat_message_data.dart';
import 'package:competition_arena/models/chat_room_data.dart';
import 'package:competition_arena/models/comment_data.dart';
import 'package:competition_arena/models/host_data.dart';
import 'package:competition_arena/models/participant_data.dart';
import 'package:competition_arena/models/score_data.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class ChatService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<ChatRoomData>> doGetList() async {
    final response = await client.get('${api.base_url}/chat-rooms/get/',
        headers: await api.getNormalHeaders());

    List<dynamic> list = json.decode(response.body);
    List<ChatRoomData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      if (list[i]["Members"] != null) {
        listUser.add(ChatRoomData.fromJson(list[i]));
      }
    }

    return listUser;
  }

  Future<List<ChatMessageData>> doGetListFromRoom(int id) async {
    final response = await client.get(
        '${api.base_url}/chat-rooms/get/messages/$id',
        headers: await api.getNormalHeaders());

    List<dynamic> list = json.decode(response.body);
    List<ChatMessageData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(ChatMessageData.fromJson(list[i]));
    }

    return listUser;
  }

  Future<ChatRoomData> doGetOne(int id) async {
    final response = await client.get(
      '${api.base_url}/chat-rooms/get/$id',
    );

    ChatRoomData regResponse =
        ChatRoomData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<ChatRoomData> doPostOne(String roomName, List<int> member) async {
    final body = {"Room_Name": roomName, "Member": member};
    final response = await client.post(
      '${api.base_url}/chat-rooms/new',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    ChatRoomData regResponse =
        ChatRoomData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<ChatRoomData> doSendMessage(
    int idRoom,
    int idUser,
    String message,
    String image,
  ) async {
    final body = {
      "ID_Room": idRoom,
      "ID_User": idUser,
      "Message": message,
      "Image_URL": image,
      "Sent_Time": "",
      "Delivered_Time": "",
      "Read_Time": ""
    };
    final response = await client.post(
      '${api.base_url}/chat-rooms/send/$idRoom',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    ChatRoomData regResponse =
        ChatRoomData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<String> doUpdateOne(int id, String roomName, List<int> member) async {
    final body = {"Room_Name": roomName, "Member": member};
    final response = await client.patch(
      '${api.base_url}/chat-rooms/update/$id',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    String status = json.decode(response.body);

    return status;
  }

  Future<String> doDeleteOne(
    int id,
  ) async {
    final response = await client.delete(
      '${api.base_url}/chat-rooms/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<int> doCountMember(int id) async {
    final response = await client.get(
      '${api.base_url}/chat-rooms/membercount/$id',
    );

    int count = json.decode(response.body);

    return count;
  }

  Future<int> doCountRooms() async {
    final response = await client.get(
      '${api.base_url}/chat-rooms/count',
    );

    int count = json.decode(response.body);

    return count;
  }
}
