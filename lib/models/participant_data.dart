import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class ParticipantData {
  final int teamName;
  final List<ParticipantMember> member;
  final DateTime dateCreated;
  final DateTime dateModified;

  ParticipantData({this.teamName, this.member, this.dateCreated, this.dateModified,});
  ParticipantData.fromJson(Map<String, dynamic> parsedJson) : teamName = parsedJson["Team_Name"],
  member = parsedJson["Member"],
  dateCreated = parsedJson["Date_Created"],
  dateModified = parsedJson["Date_Modified"];
}

@JsonSerializable()
class ParticipantMember {
  final int idUser;
  final String username;

  ParticipantMember({this.idUser, this.username});
  ParticipantMember.fromJson(Map<String, dynamic> parsedJson) : idUser = parsedJson["ID_User"], username = parsedJson["Username"];
}