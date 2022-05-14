// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.message,
    this.success,
    this.data,
  });

  String message;
  bool success;
  Data data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    message: json["message"],
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.role,
    this.email,
    this.dob,
    this.phone,
    this.emailVerifiedAt,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String role;
  String email;
  DateTime dob;
  dynamic phone;
  dynamic emailVerifiedAt;
  String image;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    email: json["email"],
    dob: DateTime.parse(json["dob"]),
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "email": email,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "image": image,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
