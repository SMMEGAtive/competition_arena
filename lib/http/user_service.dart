import 'dart:convert';
import 'dart:html';

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
    final body = {"Email": email, "Password": password};
    final response = await client.post(
      '${api.base_url}/users/login/',
      body: body,
    );

    String token = json.decode(response.body);
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
      listUser.add(UserData.fromJson(json.decode(list[i])));
    }

    return listUser;
  }

  Future<UserData> doGetOne(int id) async {
    final response = await client.get(
      '${api.base_url}/users/get/$id',
    );

    UserData regResponse = UserData.fromJson(json.decode(response.body));

    return regResponse;
  }

  Future<MeData> doGetLogged() async {
    final response = await client.get(
      '${api.base_url}/users/me',
    );

    MeData regResponse = MeData.fromJson(json.decode(response.body));

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

  Future<String> doRequestForgotPass() async {
    final response = await client.post(
      '${api.base_url}/users/forgotpass/request',
    );

    String regResponse = json.decode(response.body);

    return regResponse;
  }

  Future<String> doForgotPass(String newPass, String newPassReinput) async {
    final body = {
      "new_password": newPass,
      "new_password_reinput": newPassReinput
    };
    final response = await client
        .post('${api.base_url}/users/forgotpass/change', body: body);

    String regResponse = json.decode(response.body);

    return regResponse;
  }

  Future<String> doVerifyEmail() async {
    final response = await client.post('${api.base_url}/users/verifyemail');

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
    final response =
        await client.post('${api.base_url}/users/changepass', body: body);

    String regResponse = json.decode(response.body);
  }

  Future<int> doCount() async {
    final response = await client.get(
      '${api.base_url}/users/count',
    );

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
      '${api.base_url}/users/delete/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
    );

    return response.body;
  }

  Future<void> doUploadAvatar(int id, File img) async {
    final body = {"avatar": img};
    final response = await client.patch(
      '${api.base_url}/users/changeavatar/$id',
      headers: <String, String>{
        'Authorization': await api.authHeader(),
      },
      body: body,
    );
  }
}
