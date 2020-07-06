import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class UserData {
  final int idUser;
  final String username;
  final String email;
  final String password;
  final String phone;
  final String address;
  final int role;
  final String description;
  final String affiliation;
  final int gender;
  final String dob;
  final String avatarPath;

  UserData({this.username, this.idUser, this.password, this.email, this.phone, this.address, this.role, this.description, this.affiliation, this.gender, this.dob, this.avatarPath,});
  UserData.fromJson(Map<String, dynamic> parsedJson) : username = parsedJson["Username"],
  idUser = parsedJson["ID_User"],
  password = parsedJson["Password"],
  email = parsedJson["Email"],
  phone = parsedJson["Phone"],
  address = parsedJson["Address"],
  role = parsedJson["Role"],
  description = parsedJson["Description"],
  affiliation = parsedJson["Affiliation"],
  gender = parsedJson["Gender"],
  dob = parsedJson["Date_of_Birth"],
  avatarPath = parsedJson["Avatar_Path"];
}