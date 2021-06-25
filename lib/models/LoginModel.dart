// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.token,
    this.data,
  });

  String status;
  String token;
  Data data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    token: json["token"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.user,
  });

  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  User({
    this.photo,
    this.role,
    this.id,
    this.name,
    this.email,
    this.v,
  });

  String photo;
  String role;
  String id;
  String name;
  String email;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    photo: json["photo"],
    role: json["role"],
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
    "role": role,
    "_id": id,
    "name": name,
    "email": email,
    "__v": v,
  };
}
