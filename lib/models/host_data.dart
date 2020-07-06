import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class HostData {
  final int hostName;
  final List<HostMember> member;
  final DateTime dateCreated;
  final DateTime dateModified;

  HostData({this.hostName, this.member, this.dateCreated, this.dateModified,});
  HostData.fromJson(Map<String, dynamic> parsedJson) : hostName = parsedJson["Host_Name"],
  member = parsedJson["Member"],
  dateCreated = parsedJson["Date_Created"],
  dateModified = parsedJson["Date_Modified"];
}

@JsonSerializable()
class HostMember {
  final int idUser;
  final String username;

  HostMember({this.idUser, this.username});
  HostMember.fromJson(Map<String, dynamic> parsedJson) : idUser = parsedJson["ID_User"], username = parsedJson["Username"];
}