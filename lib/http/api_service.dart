import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  String base_url = "https://8d197392d0f3.ngrok.io";
  Client client = Client();

  Future<String> authHeader() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var type = "Bearer";
    var token = preferences.getString('token');

    return "$type $token";
  }

  String getBaseUrl() {
    return base_url;
  }

  Future<Map<String, String>> getNormalHeaders() async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: await authHeader()
    };
    return headers;
  }

  /* String authHeader() {
    var type = "Basic";
    var str = 'spklu:spklu';
    var data = base64.encode(utf8.encode(str));

    return "$type $data";
  }

  Future<RegisterResponse> doRegister(String email, String nama, String nohp,
      String password, String repassword) async {
    /* ---------------------------------
    Loading data into the body
    --------------------------------- */
    final body = {
      "email": email,
      "nama": nama,
      "nohp": nohp,
      "password": password,
      "repassword": repassword,
    };

    final response = await client.post(
      '$base_url/user/register',
      body: body,
      headers: <String, String>{
        'Authorization': authHeader(),
      },
    );

    RegisterResponse regResponse =
        RegisterResponse.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      print('success');
      return regResponse;
    } else if (response.statusCode == 401) {
      print('Unauthorized');
      return regResponse;
    } else if (response.statusCode == 403) {
      print('Forbidden');
      return regResponse;
    } else if (response.statusCode == 404) {
      print('Not Found');
      return regResponse;
    } else {
      print('Error Unknown');
      throw 'Error Unknown';
    }
  }

  Future<SetPasswordResponse> setChangePassword(
    String oldPass,
    String newPass,
    String email,
  ) async {
    /* ---------------------------------
    Loading data into the body
    --------------------------------- */
    final body = {
      "password_lama": oldPass,
      "password_baru": newPass,
      "email": email
    };

    final response = await client.post(
      '$base_url/user/setchangepassword',
      body: body,
      headers: <String, String>{
        'Authorization': authHeader(),
      },
    );

    SetPasswordResponse passResponse =
        SetPasswordResponse.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      print('success');
    } else if (response.statusCode == 401) {
      print('Unauthorized');
    } else if (response.statusCode == 403) {
      print('Forbidden');
    } else if (response.statusCode == 404) {
      print('Not Found');
      throw 'Not Found';
    } else {
      print('Error Unknown');
      throw 'Error Unknown';
    }
    return passResponse;
  }

  Future<LoginResponse> doLogin(
    String email,
    String password,
  ) async {
    /* ---------------------------------
    Loading data into the body
    --------------------------------- */
    final body = {
      "email": email,
      "password": password,
    };

    final response = await client.post(
      '$base_url/user/login',
      body: body,
      headers: <String, String>{
        'Authorization': authHeader(),
      },
    );

    LoginResponse loginResponse = LoginResponse.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      print('success');
      return loginResponse;
    } else if (response.statusCode == 401) {
      print('Unauthorized');
      throw 'Unauthorized';
    } else if (response.statusCode == 403) {
      print('Forbidden');
      throw 'Forbidden';
    } else if (response.statusCode == 404) {
      print('Not Found');
      throw 'Not Found';
    } else {
      print('Error Unknown');
      throw 'Error Unknown';
    }
  }

  Future<GetVerificationResponse> getForgotPassword(
    String email,
  ) async {
    /* ---------------------------------
    Loading data into the body
    --------------------------------- */
    final body = {
      "email": email,
    };

    final response = await client.post(
      '$base_url/user/getforgotpassword',
      body: body,
      headers: <String, String>{
        'Authorization': authHeader(),
      },
    );

    GetVerificationResponse verifResponse =
        GetVerificationResponse.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      print('success');
    } else if (response.statusCode == 401) {
      print('Unauthorized');
      throw 'Unauthorized';
    } else if (response.statusCode == 403) {
      print('Forbidden');
      throw 'Forbidden';
    } else if (response.statusCode == 404) {
      print('Not Found');
      throw 'Not Found';
    } else {
      print('Error Unknown');
      throw 'Error Unknown';
    }

    return verifResponse;
  }

  Future<SetPasswordResponse> setForgotPassword(
    String email,
    String password,
  ) async {
    /* ---------------------------------
    Loading data into the body
    --------------------------------- */
    final body = {
      "email": email,
      "password": password,
    };

    final response = await client.post(
      '$base_url/user/setforgotpassword',
      body: body,
      headers: <String, String>{
        'Authorization': authHeader(),
      },
    );

    SetPasswordResponse passResponse =
        SetPasswordResponse.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      print('success');
    } else if (response.statusCode == 401) {
      print('Unauthorized');
      throw 'Unauthorized';
    } else if (response.statusCode == 403) {
      print('Forbidden');
      throw 'Forbidden';
    } else if (response.statusCode == 404) {
      print('Not Found');
      throw 'Not Found';
    } else {
      print('Error Unknown');
      throw 'Error Unknown';
    }

    return passResponse;
  } */
}
