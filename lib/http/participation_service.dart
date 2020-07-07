import 'dart:convert';
import 'dart:io';

import 'package:competition_arena/models/host_data.dart';
import 'package:competition_arena/models/participation_data.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class ParticipationService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<List<ParticipationData>> doGetList() async {
    final response = await client.get(
      '${api.base_url}/participations/get/',
    );

    List<dynamic> list = json.decode(response.body);
    List<ParticipationData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(ParticipationData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<List<ParticipationData>> doGetListFromParticipant(int id) async {
    final response = await client.get(
      '${api.base_url}/participations/get/participant/$id',
    );

    List<dynamic> list = json.decode(response.body);
    List<ParticipationData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(ParticipationData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<List<ParticipationData>> doGetListFromUser(int id) async {
    final response = await client.get(
      '${api.base_url}/participations/get/user/all/$id',
    );

    List<dynamic> list = json.decode(response.body);
    List<ParticipationData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(ParticipationData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<List<ParticipationData>> doGetListFromUserOngoing(int id) async {
    final response = await client.get(
      '${api.base_url}/participations/get/user/ongoing/$id',
    );

    List<dynamic> list = json.decode(response.body);
    List<ParticipationData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(ParticipationData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<List<ParticipationData>> doGetListFromUserPast(int id) async {
    final response = await client.get(
      '${api.base_url}/participations/get/user/past/$id',
    );

    List<dynamic> list = json.decode(response.body);
    List<ParticipationData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(ParticipationData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<ParticipationData> doGetOne(int id) async {
    final response = await client.get(
      '${api.base_url}/participations/get/$id',
    );

    ParticipationData regResponse = ParticipationData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<ParticipationData> doPostOne(int idParticipant, int idCompetition) async {
    final body = {
      "ID_Participant": idParticipant,
      "ID_Competition": idCompetition,
    };
    final response = await client.post(
      '${api.base_url}/participations/new',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    ParticipationData regResponse = ParticipationData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<String> doAddPayment(int id, File image) async {
    final body = {
      "payment": image,
    };
    final response = await client.patch(
      '${api.base_url}/participations/pay/$id',
      body: body,
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    String status = json.decode(response.body);

    return status;
  }

  Future<String> doApprovePayment(int id) async {
    final response = await client.patch(
      '${api.base_url}/participations/approve/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    String status = json.decode(response.body);

    return status;
  }

  Future<String> doDeclinePayment(int id) async {
    final response = await client.patch(
      '${api.base_url}/participations/decline/$id',
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
      '${api.base_url}/participations/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<int> doCount() async {
    final response = await client.get(
      '${api.base_url}/participations/count',
    );

    int count = json.decode(response.body);

    return count;
  }
}
