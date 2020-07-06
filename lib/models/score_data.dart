// To parse this JSON data, do
//
//     final scoreData = scoreDataFromJson(jsonString);

import 'dart:convert';

List<ScoreData> scoreDataFromJson(String str) => List<ScoreData>.from(json.decode(str).map((x) => ScoreData.fromJson(x)));

String scoreDataToJson(List<ScoreData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScoreData {
    ScoreData({
        this.idScore,
        this.idSubmission,
        this.idUser,
        this.score,
        this.impression,
        this.dateCreated,
        this.dateModified,
    });

    final int idScore;
    final int idSubmission;
    final int idUser;
    final int score;
    final String impression;
    final DateTime dateCreated;
    final DateTime dateModified;

    factory ScoreData.fromJson(Map<String, dynamic> json) => ScoreData(
        idScore: json["ID_Score"],
        idSubmission: json["ID_Submission"],
        idUser: json["ID_User"],
        score: json["Score"],
        impression: json["Impression"],
        dateCreated: DateTime.parse(json["Date_Created"]),
        dateModified: DateTime.parse(json["Date_Modified"]),
    );

    Map<String, dynamic> toJson() => {
        "ID_Score": idScore,
        "ID_Submission": idSubmission,
        "ID_User": idUser,
        "Score": score,
        "Impression": impression,
        "Date_Created": dateCreated.toIso8601String(),
        "Date_Modified": dateModified.toIso8601String(),
    };
}
