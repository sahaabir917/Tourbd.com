import 'dart:convert';

TourModel tourModelFromJson(String str) => TourModel.fromJson(json.decode(str));

String tourModelToJson(TourModel data) => json.encode(data.toJson());

class TourModel {
  TourModel({
    this.status,
    this.results,
    this.data,
  });

  String status;
  int results;
  Data data;

  factory TourModel.fromJson(Map<String, dynamic> json) => TourModel(
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
    this.startLocation,
    this.ratingsAverage,
    this.ratingsQuantity,
    this.images,
    this.startDates,
    this.secrateTour,
    this.guides,
    this.id,
    this.name,
    this.duration,
    this.maxGroupSize,
    this.difficulty,
    this.price,
    this.summary,
    this.description,
    this.imageCover,
    this.locations,
    this.slug,
    this.durationWeeks,
    this.datumId,
  });

  StartLocation startLocation;
  double ratingsAverage;
  int ratingsQuantity;
  List<String> images;
  List<DateTime> startDates;
  bool secrateTour;
  List<Guide> guides;
  String id;
  String name;
  int duration;
  int maxGroupSize;
  Difficulty difficulty;
  int price;
  String summary;
  String description;
  String imageCover;
  List<Location> locations;
  String slug;
  double durationWeeks;
  String datumId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    startLocation: StartLocation.fromJson(json["startLocation"]),
    ratingsAverage: json["ratingsAverage"].toDouble(),
    ratingsQuantity: json["ratingsQuantity"],
    images: List<String>.from(json["images"].map((x) => x)),
    startDates: List<DateTime>.from(json["startDates"].map((x) => DateTime.parse(x))),
    secrateTour: json["secrateTour"],
    guides: List<Guide>.from(json["guides"].map((x) => Guide.fromJson(x))),
    id: json["_id"],
    name: json["name"],
    duration: json["duration"],
    maxGroupSize: json["maxGroupSize"],
    difficulty: difficultyValues.map[json["difficulty"]],
    price: json["price"],
    summary: json["summary"],
    description: json["description"],
    imageCover: json["imageCover"],
    locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
    slug: json["slug"],
    durationWeeks: json["durationWeeks"].toDouble(),
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "startLocation": startLocation.toJson(),
    "ratingsAverage": ratingsAverage,
    "ratingsQuantity": ratingsQuantity,
    "images": List<dynamic>.from(images.map((x) => x)),
    "startDates": List<dynamic>.from(startDates.map((x) => x.toIso8601String())),
    "secrateTour": secrateTour,
    "guides": List<dynamic>.from(guides.map((x) => x.toJson())),
    "_id": id,
    "name": name,
    "duration": duration,
    "maxGroupSize": maxGroupSize,
    "difficulty": difficultyValues.reverse[difficulty],
    "price": price,
    "summary": summary,
    "description": description,
    "imageCover": imageCover,
    "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
    "slug": slug,
    "durationWeeks": durationWeeks,
    "id": datumId,
  };
}

enum Difficulty { MEDIUM, EASY, DIFFICULT }

final difficultyValues = EnumValues({
  "difficult": Difficulty.DIFFICULT,
  "easy": Difficulty.EASY,
  "medium": Difficulty.MEDIUM
});

class Guide {
  Guide({
    this.photo,
    this.role,
    this.id,
    this.name,
    this.email,
  });

  String photo;
  Role role;
  String id;
  String name;
  String email;

  factory Guide.fromJson(Map<String, dynamic> json) => Guide(
    photo: json["photo"],
    role: roleValues.map[json["role"]],
    id: json["_id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
    "role": roleValues.reverse[role],
    "_id": id,
    "name": name,
    "email": email,
  };
}

enum Role { LEAD_GUIDE, GUIDE }

final roleValues = EnumValues({
  "guide": Role.GUIDE,
  "lead-guide": Role.LEAD_GUIDE
});

class Location {
  Location({
    this.type,
    this.coordinates,
    this.id,
    this.description,
    this.day,
  });

  Type type;
  List<double> coordinates;
  String id;
  String description;
  int day;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: typeValues.map[json["type"]],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    id: json["_id"],
    description: json["description"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "_id": id,
    "description": description,
    "day": day,
  };
}

enum Type { POINT }

final typeValues = EnumValues({
  "Point": Type.POINT
});

class StartLocation {
  StartLocation({
    this.type,
    this.coordinates,
    this.description,
    this.address,
  });

  Type type;
  List<double> coordinates;
  String description;
  String address;

  factory StartLocation.fromJson(Map<String, dynamic> json) => StartLocation(
    type: typeValues.map[json["type"]],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    description: json["description"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "description": description,
    "address": address,
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
