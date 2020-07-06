// To parse this JSON data, do
//
//     final participationData = participationDataFromJson(jsonString);

import 'dart:convert';

ParticipationData participationDataFromJson(String str) => ParticipationData.fromJson(json.decode(str));

String participationDataToJson(ParticipationData data) => json.encode(data.toJson());

class ParticipationData {
    ParticipationData({
        this.idParticipation,
        this.idParticipant,
        this.idCompetition,
        this.idPaymentStatus,
    });

    final int idParticipation;
    final int idParticipant;
    final int idCompetition;
    final int idPaymentStatus;

    factory ParticipationData.fromJson(Map<String, dynamic> json) => ParticipationData(
        idParticipation: json["ID_Participation"],
        idParticipant: json["ID_Participant"],
        idCompetition: json["ID_Competition"],
        idPaymentStatus: json["ID_Payment_Status"],
    );

    Map<String, dynamic> toJson() => {
        "ID_Participation": idParticipation,
        "ID_Participant": idParticipant,
        "ID_Competition": idCompetition,
        "ID_Payment_Status": idPaymentStatus,
    };
}
