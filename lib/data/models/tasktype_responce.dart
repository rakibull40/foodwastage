// To parse this JSON data, do
//
//     final tasktypeModel = tasktypeModelFromJson(jsonString);

import 'dart:convert';

TasktypeModel tasktypeModelFromJson(String str) =>
    TasktypeModel.fromJson(json.decode(str));

String tasktypeModelToJson(TasktypeModel data) => json.encode(data.toJson());

class TasktypeModel {
  TasktypeModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  bool success;
  List<Datum> data;
  String message;
  int code;

  factory TasktypeModel.fromJson(Map<String, dynamic> json) => TasktypeModel(
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
    this.price,
    this.formattedPrice,
  });

  int id;
  String name;
  String price;
  String formattedPrice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        formattedPrice: json["formatted_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "formatted_price": formattedPrice,
      };
}
