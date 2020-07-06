import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class SubmissionData {
  final int idSubmission;
  final int idParticipation;
  final String title;
  final String description;
  final String link;
  final int status;
  final DateTime dateCreated;
  final DateTime dateModified;

  SubmissionData({this.idSubmission, this.idParticipation, this.title, this.description, this.link, this.status, this.dateCreated, this.dateModified,});
  SubmissionData.fromJson(Map<String, dynamic> parsedJson) : idSubmission = parsedJson["ID_Submission"],
  idParticipation = parsedJson["ID_Participation"],
  title = parsedJson["Title"],
  description = parsedJson["Description"],
  link = parsedJson["Link"],
  status = parsedJson["Status"],
  dateCreated = parsedJson["Date_Created"],
  dateModified = parsedJson["Date_Modified"];
}