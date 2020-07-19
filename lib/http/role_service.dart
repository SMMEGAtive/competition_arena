import 'dart:convert';

import 'package:competition_arena/models/host_data.dart';
import 'package:competition_arena/models/participant_data.dart';
import 'package:competition_arena/models/role_change_request_data.dart';
import 'package:competition_arena/models/score_data.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class RoleService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<RoleChangeRequestData>> doGetList() async {
    final response = await client.get(
      '${api.base_url}/role-change-requests/get/',
    );

    List<dynamic> list = json.decode(response.body);
    List<RoleChangeRequestData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(RoleChangeRequestData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<RoleChangeRequestData> doGetOne(int id) async {
    final response = await client.get(
      '${api.base_url}/role-change-requests/get/$id',
    );

    RoleChangeRequestData regResponse =
        RoleChangeRequestData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<RoleChangeRequestData> doPostOne() async {
    final response = await client.post(
      '${api.base_url}/role-change-requests/new',
      headers: await api.getNormalHeaders(),
    );

    RoleChangeRequestData regResponse =
        RoleChangeRequestData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<String> doAccept(int id) async {
    final response = await client.patch(
      '${api.base_url}/role-change-requests/accept/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    String status = json.decode(response.body);

    return status;
  }

  Future<String> doDecline(int id) async {
    final response = await client.patch(
      '${api.base_url}/role-change-requests/decline/$id',
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
      '${api.base_url}/role-change-requests/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<int> doCount() async {
    final response = await client.get(
      '${api.base_url}/role-change-requests/count',
    );

    int count = json.decode(response.body);

    return count;
  }
}
