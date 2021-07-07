import 'dart:convert';

CreateReviewModel createReviewModelFromJson(String str) => CreateReviewModel.fromJson(json.decode(str));

String createReviewModelToJson(CreateReviewModel data) => json.encode(data.toJson());

class CreateReviewModel {
  CreateReviewModel({
    this.review,
    this.rating,
    this.tour,
    this.user,
  });

  String review;
  int rating;
  String tour;
  String user;

  factory CreateReviewModel.fromJson(Map<String, dynamic> json) => CreateReviewModel(
    review: json["review"],
    rating: json["rating"],
    tour: json["tour"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "review": review,
    "rating": rating,
    "tour": tour,
    "user": user,
  };
}
