// To parse this JSON data, do
//
//     final failedModel = failedModelFromJson(jsonString);

import 'dart:convert';

FailedModel failedModelFromJson(String str) => FailedModel.fromJson(json.decode(str));

String failedModelToJson(FailedModel data) => json.encode(data.toJson());

class FailedModel {
  FailedModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory FailedModel.fromJson(Map<String, dynamic> json) => FailedModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}