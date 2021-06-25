// To parse this JSON data, do
//
//     final searchReviewModel = searchReviewModelFromJson(jsonString);

import 'dart:convert';

SearchReviewModel searchReviewModelFromJson(String str) => SearchReviewModel.fromJson(json.decode(str));

String searchReviewModelToJson(SearchReviewModel data) => json.encode(data.toJson());

class SearchReviewModel {
  SearchReviewModel({
    this.status,
    this.results,
    this.data,
  });

  String status;
  int results;
  Data data;

  factory SearchReviewModel.fromJson(Map<String, dynamic> json) => SearchReviewModel(
    status: json["status"],
    results: json["results"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": results,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.data,
  });

  List<Datum> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.review,
    this.rating,
    this.tour,
    this.user,
    this.datumId,
  });

  String id;
  String review;
  int rating;
  Tour tour;
  User user;
  String datumId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    review: json["review"],
    rating: json["rating"],
    tour: tourValues.map[json["tour"]],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "review": review,
    "rating": rating,
    "tour": tourValues.reverse[tour],
    "user": user == null ? null : user.toJson(),
    "id": datumId,
  };
}

enum Tour { THE_5_C88_FA8_CF4_AFDA39709_C2951 }

final tourValues = EnumValues({
  "5c88fa8cf4afda39709c2951": Tour.THE_5_C88_FA8_CF4_AFDA39709_C2951
});

class User {
  User({
    this.photo,
    this.id,
    this.name,
  });

  String photo;
  String id;
  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
    photo: json["photo"],
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
    "_id": id,
    "name": name,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
