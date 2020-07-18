import 'dart:convert';
import 'dart:io';

import 'package:competition_arena/http/api_service.dart';
import 'package:competition_arena/models/competition_data.dart';
import 'package:http/http.dart';

class CompetitionService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<CompetitionData>> doGetList() async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: await api.authHeader()
    };

    final response = await client.get('${api.base_url}/competitions/get/',
        headers: await api.getNormalHeaders());

    List<dynamic> list = json.decode(response.body);
    print(list.length);
    List<CompetitionData> listCompetition = List();
    for (int i = 0; i < list.length; i++) {
      listCompetition.add(CompetitionData.fromJson(list[i]));
    }

    return listCompetition;
  }

  Future<List<dynamic>> doGetTag(int id) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: await api.authHeader()
    };
    final response = await client
        .get('${api.base_url}/tags/get/competitions/$id', headers: headers);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> name = map["Tags"];
    print(map["Tags"]);
    return name;
  }

  Future<CompetitionData> doGetOne(int id) async {
    final response = await client.get(
      '${api.getBaseUrl()}/competitions/get/$id',
    );

    print(response);

    CompetitionData regResponse = competitionDataFromJson(response.body);

    return regResponse;
  }

  Future<List<CompetitionData>> doGetOneFromKeyword(
      String keyword, List<String> tags) async {
    var body = '';
    if (tags == null || tags.length == 0 || tags[0] == "none") {
      if (keyword == null) {
        body = jsonEncode({"keyword": ''});
      } else {
        body = jsonEncode({"keyword": keyword});
      }
    } else {
      body = jsonEncode({"keyword": keyword, "tags": tags});
    }
    final response = await client.post(
        '${api.base_url}/competitions/get/keyword',
        body: body,
        headers: await api.getNormalHeaders());

    List<dynamic> list = json.decode(response.body);
    List<CompetitionData> listCompetition = new List();
    for (int i = 0; i < list.length; i++) {
      listCompetition.add(CompetitionData.fromJson(list[i]));
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
    final body = jsonEncode({
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
    });
    final response = await client.post(
      '${api.base_url}/competitions/new',
      body: body,
      headers: await api.getNormalHeaders(),
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
    final body = json.encode({
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
    });
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: await api.authHeader()
    };
    final response = await client.patch(
        '${api.base_url}/competitions/update/$id',
        body: body,
        headers: headers);

    Map<String, dynamic> map = json.decode(response.body);
    String status = map["status"];
    print(status);

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
