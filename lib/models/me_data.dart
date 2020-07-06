// To parse this JSON data, do
//
//     final meData = meDataFromJson(jsonString);

import 'dart:convert';

MeData meDataFromJson(String str) => MeData.fromJson(json.decode(str));

String meDataToJson(MeData data) => json.encode(data.toJson());

class MeData {
    MeData({
        this.name,
        this.email,
        this.id,
        this.role,
        this.verified,
        this.iat,
        this.exp,
    });

    final String name;
    final String email;
    final int id;
    final int role;
    final bool verified;
    final int iat;
    final int exp;

    factory MeData.fromJson(Map<String, dynamic> json) => MeData(
        name: json["name"],
        email: json["email"],
        id: json["id"],
        role: json["role"],
        verified: json["verified"],
        iat: json["iat"],
        exp: json["exp"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "id": id,
        "role": role,
        "verified": verified,
        "iat": iat,
        "exp": exp,
    };
}
