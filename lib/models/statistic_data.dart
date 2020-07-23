// To parse this JSON data, do
//
//     final statisticData = statisticDataFromJson(jsonString);

import 'dart:convert';

List<StatisticData> statisticDataFromJson(String str) =>
    List<StatisticData>.from(
        json.decode(str).map((x) => StatisticData.fromJson(x)));

String statisticDataToJson(List<StatisticData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatisticData {
  StatisticData({
    this.idUser,
    this.username,
    this.affiliation,
    this.winCount,
    this.winRatio,
    this.competitionWon,
    this.participationCount,
    this.participation,
  });

  int idUser;
  String username;
  String affiliation;
  int winCount;
  double winRatio;
  List<CompetitionWon> competitionWon;
  int participationCount;
  List<Participation> participation;

  factory StatisticData.fromJson(Map<String, dynamic> json) => StatisticData(
        idUser: json["ID_User"],
        username: json["Username"],
        affiliation: json["Affiliation"],
        winCount: json["Win_Count"],
        winRatio: double.parse(json["Win_Ratio"].toStringAsFixed(2)),
        competitionWon: List<CompetitionWon>.from(
            json["Competition_Won"].map((x) => CompetitionWon.fromJson(x))),
        participationCount: json["Participation_Count"],
        participation: List<Participation>.from(
            json["Participation"].map((x) => Participation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ID_User": idUser,
        "Username": username,
        "Affiliation": affiliation,
        "Win_Count": winCount,
        "Win_Ratio": winRatio,
        "Competition_Won":
            List<dynamic>.from(competitionWon.map((x) => x.toJson())),
        "Participation_Count": participationCount,
        "Participation":
            List<dynamic>.from(participation.map((x) => x.toJson())),
      };
}

class CompetitionWon {
  CompetitionWon({
    this.idCompetition,
    this.competitionName,
  });

  int idCompetition;
  String competitionName;

  factory CompetitionWon.fromJson(Map<String, dynamic> json) => CompetitionWon(
        idCompetition: json["ID_Competition"],
        competitionName: json["Competition_Name"],
      );

  Map<String, dynamic> toJson() => {
        "ID_Competition": idCompetition,
        "Competition_Name": competitionName,
      };
}

class Participation {
  Participation({
    this.idParticipation,
    this.idParticipant,
    this.teamName,
  });

  int idParticipation;
  int idParticipant;
  String teamName;

  factory Participation.fromJson(Map<String, dynamic> json) => Participation(
        idParticipation: json["ID_Participation"],
        idParticipant: json["ID_Participant"],
        teamName: json["Team_Name"],
      );

  Map<String, dynamic> toJson() => {
        "ID_Participation": idParticipation,
        "ID_Participant": idParticipant,
        "Team_Name": teamName,
      };
}
