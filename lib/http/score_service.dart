import 'dart:convert';

import 'package:competition_arena/models/host_data.dart';
import 'package:competition_arena/models/participant_data.dart';
import 'package:competition_arena/models/score_data.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class ScoreService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<ScoreData>> doGetList() async {
    final response = await client.get(
      '${api.base_url}/scores/get/',
    );

    List<dynamic> list = json.decode(response.body);
    List<ScoreData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(ScoreData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<List<ScoreData>> doGetListFromSubmission(int id) async {
    final response = await client.get(
      '${api.base_url}/scores/get/submission/$id',
    );

    List<dynamic> list = json.decode(response.body);
    List<ScoreData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(ScoreData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<ScoreData> doGetOne(int id) async {
    final response = await client.get(
      '${api.base_url}/scores/get/$id',
    );

    ScoreData regResponse =
        ScoreData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<ScoreData> doPostOne(int idSubmission, int score, String impression) async {
    final body = {
      "ID_Submission": idSubmission,
      "Score": score,
      "Impression": impression
    };
    final response = await client.post(
      '${api.base_url}/scores/new',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    ScoreData regResponse =
        ScoreData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<String> doUpdateOne(int id, int idSubmission, int score, String impression) async {
    final body = {
      "ID_Submission": idSubmission,
      "Score": score,
      "Impression": impression
    };
    final response = await client.patch(
      '${api.base_url}/scores/update/$id',
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
      '${api.base_url}/scores/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<int> doCount() async {
    final response = await client.get(
      '${api.base_url}/scores/count',
    );

    int count = json.decode(response.body);

    return count;
  }
}
