// To parse this JSON data, do
//
//     final submissionData = submissionDataFromJson(jsonString);

import 'dart:convert';

SubmissionData submissionDataFromJson(String str) => SubmissionData.fromJson(json.decode(str));

String submissionDataToJson(SubmissionData data) => json.encode(data.toJson());

class SubmissionData {
    SubmissionData({
        this.idSubmission,
        this.participant,
        this.title,
        this.description,
        this.link,
        this.status,
        this.score,
        this.dateCreated,
        this.dateModified,
    });

    final int idSubmission;
    final Participant participant;
    final String title;
    final String description;
    final String link;
    final int status;
    final int score;
    final DateTime dateCreated;
    final DateTime dateModified;

    factory SubmissionData.fromJson(Map<String, dynamic> json) => SubmissionData(
        idSubmission: json["ID_Submission"],
        participant: Participant.fromJson(json["Participant"]),
        title: json["Title"],
        description: json["Description"],
        link: json["Link"],
        status: json["Status"],
        score: json["Score"],
        dateCreated: DateTime.parse(json["Date_Created"]),
        dateModified: DateTime.parse(json["Date_Modified"]),
    );

    Map<String, dynamic> toJson() => {
        "ID_Submission": idSubmission,
        "Participant": participant.toJson(),
        "Title": title,
        "Description": description,
        "Link": link,
        "Status": status,
        "Score": score,
        "Date_Created": dateCreated.toIso8601String(),
        "Date_Modified": dateModified.toIso8601String(),
    };
}

class Participant {
    Participant({
        this.idParticipant,
        this.participantName,
    });

    final int idParticipant;
    final String participantName;

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        idParticipant: json["ID_Participant"],
        participantName: json["Participant_Name"],
    );

    Map<String, dynamic> toJson() => {
        "ID_Participant": idParticipant,
        "Participant_Name": participantName,
    };
}
