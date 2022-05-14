// To parse this JSON data, do
//
//     final taskListResponse = taskListResponseFromJson(jsonString);

import 'dart:convert';

TaskListResponse taskListResponseFromJson(String str) =>
    TaskListResponse.fromJson(json.decode(str));

String taskListResponseToJson(TaskListResponse data) =>
    json.encode(data.toJson());

class TaskListResponse {
  TaskListResponse({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  bool success;
  List<Datum> data;
  String message;
  int code;

  factory TaskListResponse.fromJson(Map<String, dynamic> json) =>
      TaskListResponse(
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
    this.taskTypeId,
    this.title,
    this.cost,
    this.status,
  });

  int id;
  int taskTypeId;
  String title;
  String cost;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        taskTypeId: json["task_type_id"],
        title: json["title"],
        cost: json["cost"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_type_id": taskTypeId,
        "title": title,
        "cost": cost,
        "status": status,
      };
}
