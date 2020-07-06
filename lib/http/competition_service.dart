import 'dart:convert';

import 'package:competition_arena/http/api_service.dart';
import 'package:competition_arena/models/competition_data.dart';
import 'package:http/http.dart';

class CompetitionService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<CompetitionData>> doGetList() async {
    final response = await client.get(
      '${api.base_url}/competitions/get/',
    );

    List<dynamic> list = json.decode(response.body);
    List<CompetitionData> listCompetition = new List();
    for (int i = 0; i < list.length; i++) {
      listCompetition.add(CompetitionData.fromJson(json.decode(list[i])));
    }

    return listCompetition;
  }

  Future<CompetitionData> doGetOne(int id) async {
    final response = await client.get(
      '${api.getBaseUrl()}/competitions/get/$id',
    );

    print(response);

    CompetitionData regResponse =
        CompetitionData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<List<CompetitionData>> doGetOneFromKeyword(
      String keyword, List<String> tags) async {
    final body = {"keyword": keyword, "tags": tags};
    final response = await client.post(
      '${api.base_url}/competitions/get/keyword',
      body: body,
    );

    List<dynamic> list = json.decode(response.body);
    List<CompetitionData> listCompetition = new List();
    for (int i = 0; i < list.length; i++) {
      listCompetition.add(CompetitionData.fromJson(json.decode(list[i])));
    }

    return listCompetition;
  }

  Future<CompetitionData> doPostOne(
      int idHost,
      String title,
      String description,
      String registrationStart,
      String registrationEnd,
      String verificationEnd,
      String executionStart,
      String executionEnd,
      String announcementDate,
      List<String> tags) async {
    final body = {
      "ID_Host": idHost,
      "Title": title,
      "Description": description,
      "Registration_Start": registrationStart,
      "Registration_End": registrationEnd,
      "Verification_End": verificationEnd,
      "Execution_Start": executionStart,
      "Execution_End": executionEnd,
      "Announcement_Date": announcementDate,
      "Tags": tags,
    };
    final response = await client.post(
      '${api.base_url}/competitions/new',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    CompetitionData regResponse =
        CompetitionData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<String> doSetWinner(int id) async {
    final response = await client.patch(
      '${api.base_url}/setwinner/$id',
    );

    String status = json.decode(response.body);

    return status;
  }

  Future<String> doUpdateOne(
      int id,
      int idHost,
      String title,
      String description,
      String registrationStart,
      String registrationEnd,
      String verificationEnd,
      String executionStart,
      String executionEnd,
      String announcementDate,
      List<String> tags) async {
    final body = {
      "ID_Host": idHost,
      "Title": title,
      "Description": description,
      "Registration_Start": registrationStart,
      "Registration_End": registrationEnd,
      "Verification_End": verificationEnd,
      "Execution_Start": executionStart,
      "Execution_End": executionEnd,
      "Announcement_Date": announcementDate,
      "Tags": tags,
    };
    final response = await client.patch(
      '${api.base_url}/competitions/update/$id',
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
      '${api.base_url}/competitions/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<int> doCount() async {
    final response = await client.get(
      '${api.base_url}/competitions/count',
    );

    int count = json.decode(response.body);

    return count;
  }
}
