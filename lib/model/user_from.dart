import 'package:meta/meta.dart';
import 'dart:convert';

class UserRespo {
    final bool status;
    final List<UserData> data;

    UserRespo({
        required this.status,
        required this.data,
    });

    UserRespo copyWith({
        bool? status,
        List<UserData>? data,
    }) => 
        UserRespo(
            status: status ?? this.status,
            data: data ?? this.data,
        );

    factory UserRespo.fromRawJson(String str) => UserRespo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserRespo.fromJson(Map<String, dynamic> json) => UserRespo(
        status: json["status"],
        data: List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class UserData {
    final String userId;
    final String userName;
    final String userEmail;
    final String userPassword;

    UserData({
        required this.userId,
        required this.userName,
        required this.userEmail,
        required this.userPassword,
    });

    UserData copyWith({
        String? userId,
        String? userName,
        String? userEmail,
        String? userPassword,
    }) => 
        UserData(
            userId: userId ?? this.userId,
            userName: userName ?? this.userName,
            userEmail: userEmail ?? this.userEmail,
            userPassword: userPassword ?? this.userPassword,
        );

    factory UserData.fromRawJson(String str) => UserData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_password": userPassword,
    };
}
