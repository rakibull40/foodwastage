// To parse this JSON data, do
//
//     final completeTaskModel = completeTaskModelFromJson(jsonString);

import 'dart:convert';

CompleteTaskModel completeTaskModelFromJson(String str) => CompleteTaskModel.fromJson(json.decode(str));

String completeTaskModelToJson(CompleteTaskModel data) => json.encode(data.toJson());

class CompleteTaskModel {
  CompleteTaskModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  bool success;
  List<Datum> data;
  String message;
  int code;

  factory CompleteTaskModel.fromJson(Map<String, dynamic> json) => CompleteTaskModel(
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    taskTypeId: json["task_type_id"],
    title: json["title"],
    description: json["description"],
    fromLocation: json["from_location"],
    toLocation: json["to_location"],
    fromLat: json["from_lat"] == null ? null : json["from_lat"],
    fromLong: json["from_long"] == null ? null : json["from_long"],
    toLat: json["to_lat"] == null ? null : json["to_lat"],
    toLong: json["to_long"] == null ? null : json["to_long"],
    cost: json["cost"],
    isNegotiable: json["is_negotiable"],
    taskerId: json["tasker_id"],
    rateByCustomer: json["rate_by_customer"],
    rateByTasker: json["rate_by_tasker"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "task_type_id": taskTypeId,
    "title": title,
    "description": description,
    "from_location": fromLocation,
    "to_location": toLocation,
    "from_lat": fromLat == null ? null : fromLat,
    "from_long": fromLong == null ? null : fromLong,
    "to_lat": toLat == null ? null : toLat,
    "to_long": toLong == null ? null : toLong,
    "cost": cost,
    "is_negotiable": isNegotiable,
    "tasker_id": taskerId,
    "rate_by_customer": rateByCustomer,
    "rate_by_tasker": rateByTasker,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
