// To parse this JSON data, do
//
//     final competitionData = competitionDataFromJson(jsonString);

import 'dart:convert';

CompetitionData competitionDataFromJson(String str) => CompetitionData.fromJson(json.decode(str));

String competitionDataToJson(CompetitionData data) => json.encode(data.toJson());

class CompetitionData {
    CompetitionData({
        this.idCompetition,
        this.idHost,
        this.title,
        this.description,
        this.registrationStart,
        this.registrationEnd,
        this.verificationEnd,
        this.executionStart,
        this.executionEnd,
        this.announcementDate,
        this.tags,
    });

    final int idCompetition;
    final int idHost;
    final String title;
    final String description;
    final DateTime registrationStart;
    final DateTime registrationEnd;
    final DateTime verificationEnd;
    final DateTime executionStart;
    final DateTime executionEnd;
    final DateTime announcementDate;
    final List<String> tags;

    factory CompetitionData.fromJson(Map<String, dynamic> json) => CompetitionData(
        idCompetition: json["ID_Competition"],
        idHost: json["ID_Host"],
        title: json["Title"],
        description: json["Description"],
        registrationStart: DateTime.parse(json["Registration_Start"]),
        registrationEnd: DateTime.parse(json["Registration_End"]),
        verificationEnd: DateTime.parse(json["Verification_End"]),
        executionStart: DateTime.parse(json["Execution_Start"]),
        executionEnd: DateTime.parse(json["Execution_End"]),
        announcementDate: DateTime.parse(json["Announcement_Date"]),
        tags: List<String>.from(json["Tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "ID_Competition": idCompetition,
        "ID_Host": idHost,
        "Title": title,
        "Description": description,
        "Registration_Start": registrationStart.toIso8601String(),
        "Registration_End": registrationEnd.toIso8601String(),
        "Verification_End": verificationEnd.toIso8601String(),
        "Execution_Start": executionStart.toIso8601String(),
        "Execution_End": executionEnd.toIso8601String(),
        "Announcement_Date": announcementDate.toIso8601String(),
        "Tags": List<dynamic>.from(tags.map((x) => x)),
    };
}
