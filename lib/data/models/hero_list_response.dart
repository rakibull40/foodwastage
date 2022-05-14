// To parse this JSON data, do
//
//     final heroListResponse = heroListResponseFromJson(jsonString);

import 'dart:convert';

HeroListResponse heroListResponseFromJson(String str) => HeroListResponse.fromJson(json.decode(str));

String heroListResponseToJson(HeroListResponse data) => json.encode(data.toJson());

class HeroListResponse {
  HeroListResponse({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  bool success;
  List<Datum> data;
  String message;
  int code;

  factory HeroListResponse.fromJson(Map<String, dynamic> json) => HeroListResponse(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.users,
  });

  int id;
  String name;
  String slug;
  String status;
  dynamic description;
  dynamic createdAt;
  dynamic updatedAt;
  List<User> users;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "status": status,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.roleId,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.balance,
  });

  int id;
  String name;
  int roleId;
  String email;
  String phone;
  dynamic emailVerifiedAt;
  String image;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String balance;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    roleId: json["role_id"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role_id": roleId,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "image": image,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "balance": balance,
  };
}
