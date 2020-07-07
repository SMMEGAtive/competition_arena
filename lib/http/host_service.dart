import 'dart:convert';

import 'package:competition_arena/models/host_data.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class HostService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<HostData>> doGetList() async {
    final response = await client.get(
      '${api.base_url}/hosts/get/',
    );

    List<dynamic> list = json.decode(response.body);
    List<HostData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(HostData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<HostData> doGetOne(int id) async {
    final response = await client.get(
      '${api.base_url}/hosts/get/$id',
    );

    HostData regResponse = HostData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<HostData> doPostOne(String hostName, List<int> members) async {
    final body = {
      "Host_Name": hostName,
      "Members": members,
    };
    final response = await client.post(
      '${api.base_url}/hosts/new',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    HostData regResponse = HostData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<String> doUpdateOne(int id, String hostName, List<int> members) async {
    final body = {
      "Host_Name": hostName,
      "Members": members,
    };
    final response = await client.patch(
      '${api.base_url}/hosts/update/$id',
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
      '${api.base_url}/hosts/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<int> doCount() async {
    final response = await client.get(
      '${api.base_url}/hosts/count',
    );

    int count = json.decode(response.body);

    return count;
  }
}
