// To parse this JSON data, do
//
//     final roleChangeRequestData = roleChangeRequestDataFromJson(jsonString);

import 'dart:convert';

RoleChangeRequestData roleChangeRequestDataFromJson(String str) => RoleChangeRequestData.fromJson(json.decode(str));

String roleChangeRequestDataToJson(RoleChangeRequestData data) => json.encode(data.toJson());

class RoleChangeRequestData {
    RoleChangeRequestData({
        this.idRequest,
        this.idUser,
        this.status,
        this.dateRequest,
    });

    final int idRequest;
    final int idUser;
    final int status;
    final DateTime dateRequest;

    factory RoleChangeRequestData.fromJson(Map<String, dynamic> json) => RoleChangeRequestData(
        idRequest: json["ID_Request"],
        idUser: json["ID_User"],
        status: json["Status"],
        dateRequest: DateTime.parse(json["Date_Request"]),
    );

    Map<String, dynamic> toJson() => {
        "ID_Request": idRequest,
        "ID_User": idUser,
        "Status": status,
        "Date_Request": dateRequest.toIso8601String(),
    };
}
