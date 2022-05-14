// To parse this JSON data, do
//
//     final singleTaskModel = singleTaskModelFromJson(jsonString);

import 'dart:convert';

SingleTaskModel singleTaskModelFromJson(String str) => SingleTaskModel.fromJson(json.decode(str));

String singleTaskModelToJson(SingleTaskModel data) => json.encode(data.toJson());

class SingleTaskModel {
  SingleTaskModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  bool success;
  Data data;
  String message;
  int code;

  factory SingleTaskModel.fromJson(Map<String, dynamic> json) => SingleTaskModel(
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
    this.name,
    this.price,
    this.formattedPrice,
  });

  int id;
  String name;
  String price;
  String formattedPrice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
