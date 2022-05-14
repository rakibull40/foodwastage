// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.message,
    this.token,
    this.userInfo,
  });

  bool status;
  String message;
  String token;
  UserInfo userInfo;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    message: json["message"],
    token: json["token"],
    userInfo: UserInfo.fromJson(json["user_info"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
    "user_info": userInfo.toJson(),
  };
}

class UserInfo {
  UserInfo({
    this.id,
    this.name,
    this.role,
    this.email,
    this.phone,
    this.image,
    this.balance,
  });

  int id;
  String name;
  String role;
  String email;
  String phone;
  String image;
  String balance;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "email": email,
    "phone": phone,
    "image": image,
    "balance": balance,
  };
}
