import 'dart:convert';
import 'dart:io';

import 'package:competition_arena/http/api_service.dart';
import 'package:competition_arena/models/competition_data.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/models/user_data.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  ApiServices api = new ApiServices();
  Client client = new Client();

  Future<String> doLogin(String email, String password) async {
    final body = jsonEncode({"email": email, "password": password});
    String token;
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: await api.authHeader()
    };
    final response = await client.post('${api.base_url}/users/login/',
        body: body, headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      token = map["token"];
    } else {
      return "failed";
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);

    return token;
  }

  Future<List<UserData>> doGetList() async {
    final response = await client.get(
      '${api.base_url}/users/get/',
    );

    List<dynamic> list = json.decode(response.body);
    List<UserData> listUser = new List();
    for (int i = 0; i < list.length; i++) {
      listUser.add(userDataFromJson(list[i]));
    }

    return listUser;
  }

  Future<UserData> doGetOne(int id) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: await api.authHeader()
    };
    final response =
        await client.get('${api.base_url}/users/get/$id', headers: headers);

    Map<String, dynamic> map = json.decode(response.body);
    UserData regResponse = UserData.fromJson(map);

    return regResponse;
  }

  Future<MeData> doGetLogged() async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: await api.authHeader()
    };

    final response =
        await client.get('${api.base_url}/users/me', headers: headers);

    MeData regResponse = meDataFromJson(response.body);

    return regResponse;
  }

  Future<UserData> doRegister(
      String username,
      String password,
      String passwordVerified,
      String email,
      String phone,
      int gender,
      String dob) async {
    final body = {
      "Username": username,
      "Password": password,
      "Password_Verified": passwordVerified,
      "Email": email,
      "Email_Verified": false,
      "Phone": phone,
      "Role": 3,
      "Gender": gender,
      "Date_of_Birth": dob
    };
    final response = await client.post(
      '${api.base_url}/users/register',
      body: body,
    );

    UserData regResponse = UserData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<String> doRequestForgotPass(String email) async {
    final body = {"email": email};
    final response = await client.post(
        '${api.base_url}/users/forgotpass/request',
        body: body,
        headers: await api.getNormalHeaders());

    String regResponse = json.decode(response.body);

    return regResponse;
  }

  Future<String> doForgotPass(String newPass, String newPassReinput) async {
    final body = {
      "new_password": newPass,
      "new_password_reinput": newPassReinput
    };
    final response = await client.post(
        '${api.base_url}/users/forgotpass/change',
        body: body,
        headers: await api.getNormalHeaders());

    String regResponse = json.decode(response.body);

    return regResponse;
  }

  Future<String> doVerifyEmail() async {
    final response = await client.post('${api.base_url}/users/verifyemail',
        headers: await api.getNormalHeaders());

    String regResponse = json.decode(response.body);

    return regResponse;
  }

  Future<void> doChangePass(
      String oldPass, String newPass, String newPassReinput) async {
    final body = {
      "old_password": oldPass,
      "new_password": newPass,
      "new_password_reinput": newPassReinput
    };
    final response = await client.post('${api.base_url}/users/changepass',
        body: body, headers: await api.getNormalHeaders());

    String regResponse = json.decode(response.body);
  }

  Future<int> doCount() async {
    final response = await client.get('${api.base_url}/users/count',
        headers: await api.getNormalHeaders());

    int count = json.decode(response.body);

    return count;
  }

  Future<String> doUpdateOne(
      int id,
      String username,
      String password,
      String passwordVerified,
      String email,
      String phone,
      int gender,
      String dob) async {
    final body = {
      "Username": username,
      "Password": password,
      "Password_Verified": passwordVerified,
      "Email": email,
      "Email_Verified": false,
      "Phone": phone,
      "Role": 3,
      "Gender": gender,
      "Date_of_Birth": dob
    };
    final response = await client.patch(
      '${api.base_url}/users/update/$id',
      body: body,
      headers: await api.getNormalHeaders(),
    );

    String status = json.decode(response.body);

    return status;
  }

  Future<String> doDeleteOne(
    int id,
  ) async {
    final response = await client.delete('${api.base_url}/users/delete/$id',
        headers: await api.getNormalHeaders());

    return response.body;
  }

  Future<void> doUploadAvatar(int id, File img) async {
    final body = {"avatar": img};
    final response = await client.patch(
      '${api.base_url}/users/changeavatar/$id',
      headers: await api.getNormalHeaders(),
      body: body,
    );
  }
}
