import 'dart:convert';

import 'package:competition_arena/models/host_data.dart';
import 'package:competition_arena/models/participant_data.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class ParticipantService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<ParticipantData>> doGetList() async {
    final response = await client.get(
      '${api.base_url}/participants/get/',
    );

    List<dynamic> list = json.decode(response.body);
    List<ParticipantData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(ParticipantData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<ParticipantData> doGetOne(int id) async {
    final response = await client.get(
      '${api.base_url}/participants/get/$id',
    );

    ParticipantData regResponse =
        ParticipantData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<int> doPostOne(String hostName, List<int> members) async {
    final body = jsonEncode({
      "Team_Name": hostName,
      "Members": members,
    });

    final response = await client.post(
      '${api.base_url}/participants/new',
      body: body,
      headers: await api.getNormalHeaders(),
    );

    return int.parse(response.body);
  }

  Future<String> doUpdateOne(int id, String hostName, List<int> members) async {
    final body = {
      "Team_Name": hostName,
      "Members": members,
    };
    final response = await client.patch(
      '${api.base_url}/participants/update/$id',
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
      '${api.base_url}/participants/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<int> doCount() async {
    final response = await client.get(
      '${api.base_url}/participants/count',
    );

    int count = json.decode(response.body);

    return count;
  }
}
