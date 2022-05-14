// To parse this JSON data, do
//
//     final taskviewResponse = taskviewResponseFromJson(jsonString);

import 'dart:convert';

TaskviewResponse taskviewResponseFromJson(String str) => TaskviewResponse.fromJson(json.decode(str));

String taskviewResponseToJson(TaskviewResponse data) => json.encode(data.toJson());

class TaskviewResponse {
  TaskviewResponse({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  bool success;
  Data data;
  String message;
  int code;

  factory TaskviewResponse.fromJson(Map<String, dynamic> json) => TaskviewResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.taskTypeId,
    this.title,
    this.description,
    this.fromLocation,
    this.toLocation,
    this.fromLat,
    this.fromLong,
    this.toLat,
    this.toLong,
    this.cost,
    this.isNegotiable,
    this.taskerId,
    this.rateByCustomer,
    this.rateByTasker,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.master,
    this.hero,
  });

  int id;
  int userId;
  int taskTypeId;
  String title;
  String description;
  String fromLocation;
  String toLocation;
  String fromLat;
  String fromLong;
  String toLat;
  String toLong;
  String cost;
  int isNegotiable;
  dynamic taskerId;
  dynamic rateByCustomer;
  dynamic rateByTasker;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Master master;
  dynamic hero;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    taskTypeId: json["task_type_id"],
    title: json["title"],
    description: json["description"],
    fromLocation: json["from_location"],
    toLocation: json["to_location"],
    fromLat: json["from_lat"],
    fromLong: json["from_long"],
    toLat: json["to_lat"],
    toLong: json["to_long"],
    cost: json["cost"],
    isNegotiable: json["is_negotiable"],
    taskerId: json["tasker_id"],
    rateByCustomer: json["rate_by_customer"],
    rateByTasker: json["rate_by_tasker"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    master: Master.fromJson(json["master"]),
    hero: json["hero"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "task_type_id": taskTypeId,
    "title": title,
    "description": description,
    "from_location": fromLocation,
    "to_location": toLocation,
    "from_lat": fromLat,
    "from_long": fromLong,
    "to_lat": toLat,
    "to_long": toLong,
    "cost": cost,
    "is_negotiable": isNegotiable,
    "tasker_id": taskerId,
    "rate_by_customer": rateByCustomer,
    "rate_by_tasker": rateByTasker,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "master": master.toJson(),
    "hero": hero,
  };
}

class Master {
  Master({
    this.id,
    this.name,
    this.roleId,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.image,
    this.status,
    this.balance,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int roleId;
  String email;
  String phone;
  dynamic emailVerifiedAt;
  String image;
  String status;
  String balance;
  DateTime createdAt;
  DateTime updatedAt;

  factory Master.fromJson(Map<String, dynamic> json) => Master(
    id: json["id"],
    name: json["name"],
    roleId: json["role_id"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    image: json["image"],
    status: json["status"],
    balance: json["balance"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "balance": balance,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
