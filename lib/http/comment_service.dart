import 'dart:convert';

import 'package:competition_arena/models/comment_data.dart';
import 'package:competition_arena/models/host_data.dart';
import 'package:competition_arena/models/participant_data.dart';
import 'package:competition_arena/models/score_data.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class CommentService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<CommentData>> doGetList() async {
    final response = await client.get(
      '${api.base_url}/comments/get/',
    );

    List<dynamic> list = json.decode(response.body);
    List<CommentData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(CommentData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<List<CommentData>> doGetListFromSubmission(int id) async {
    final response = await client.get(
      '${api.base_url}/comments/get/submission/$id',
    );

    List<dynamic> list = json.decode(response.body);
    List<CommentData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(CommentData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<CommentData> doGetOne(int id) async {
    final response = await client.get(
      '${api.base_url}/comments/get/$id',
    );

    CommentData regResponse =
        CommentData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<CommentData> doPostOne(int idSubmission, String content) async {
    final body = {
      "ID_Submission": idSubmission,
      "Content": content
    };
    final response = await client.post(
      '${api.base_url}/comments/new',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    CommentData regResponse =
        CommentData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<CommentData> doReply(int idParent, int idSubmission, String content) async {
    final body = {
      "ID_Submission": idSubmission,
      "Content": content
    };
    final response = await client.post(
      '${api.base_url}/comments/reply/$idParent',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    CommentData regResponse =
        CommentData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<String> doUpdateOne(int id, int idSubmission, String content) async {
    final body = {
      "ID_Submission": idSubmission,
      "Content": content
    };
    final response = await client.patch(
      '${api.base_url}/comments/update/$id',
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
      '${api.base_url}/comments/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<int> doCount() async {
    final response = await client.get(
      '${api.base_url}/comments/count',
    );

    int count = json.decode(response.body);

    return count;
  }
}
