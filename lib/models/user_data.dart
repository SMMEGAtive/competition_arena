// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

import 'package:competition_arena/http/api_service.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.username,
    this.idUser,
    this.email,
    this.emailVerified,
    this.password,
    this.phone,
    this.address,
    this.role,
    this.description,
    this.affiliation,
    this.gender,
    this.dateOfBirth,
    this.avatarPath,
  });

  final String username;
  final int idUser;
  final String email;
  final bool emailVerified;
  final String password;
  final String phone;
  final String address;
  final int role;
  final String description;
  final String affiliation;
  final int gender;
  final DateTime dateOfBirth;
  final String avatarPath;

  String url() {
    ApiServices api = ApiServices();
    return api.base_url;
  }

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        username: json["Username"],
        idUser: json["ID_User"],
        email: json["Email"],
        emailVerified: json["Email_Verified"],
        password: json["Password"],
        phone: json["Phone"],
        address: json["Address"],
        role: json["Role"],
        description: json["Description"],
        affiliation: json["Affiliation"],
        gender: json["Gender"],
        dateOfBirth: DateTime.parse(json["Date_of_Birth"]),
        avatarPath: json["Avatar_Path"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "ID_User": idUser,
        "Email": email,
        "Email_Verified": emailVerified,
        "Password": password,
        "Phone": phone,
        "Address": address,
        "Role": role,
        "Description": description,
        "Affiliation": affiliation,
        "Gender": gender,
        "Date_of_Birth": dateOfBirth.toIso8601String(),
        "Avatar_Path": avatarPath,
      };
}
