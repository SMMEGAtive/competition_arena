import 'dart:convert';

import 'package:competition_arena/models/host_data.dart';
import 'package:competition_arena/models/participant_data.dart';
import 'package:competition_arena/models/submission_data.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class SubmissionService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<SubmissionData>> doGetList() async {
    final response = await client.get('${api.base_url}/submissions/get/',
        headers: await api.getNormalHeaders());

    List<dynamic> list = json.decode(response.body);
    List<SubmissionData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(SubmissionData.fromJson(list[i]));
    }

    return listUser;
  }

  Future<SubmissionData> doGetOne(int id) async {
    final response = await client.get('${api.base_url}/submissions/get/$id',
        headers: await api.getNormalHeaders());

    SubmissionData regResponse =
        SubmissionData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<String> doPostOne(
      int idCompetition, String link, String title, String description) async {
    final body = jsonEncode({
      "ID_Competition": idCompetition,
      "Link": link,
      "Title": title,
      "Description": description
    });
    final response = await client.post(
      '${api.base_url}/submissions/new',
      body: body,
      headers: await api.getNormalHeaders(),
    );

    String status = response.body;

    return status;
  }

  Future<String> doUpdateOne(int id, int idCompetition, String link,
      String title, String description) async {
    final body = {
      "ID_Competion": idCompetition,
      "Link": link,
      "Title": title,
      "Description": description
    };
    final response = await client.patch(
      '${api.base_url}/submissions/update/$id',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    String status = json.decode(response.body);

    return status;
  }

  Future<String> doDisqualify(int id) async {
    final response = await client.patch(
      '${api.base_url}/submissions/disqualify/$id',
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
      '${api.base_url}/submissions/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<int> doCount() async {
    final response = await client.get(
      '${api.base_url}/submissions/count',
    );

    int count = json.decode(response.body);

    return count;
  }
}
