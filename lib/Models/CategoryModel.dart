import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  String message;
  List<Datum> data;

  Categories({
    required this.message,
    required this.data,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String value;
  String description;
  String image;
  DateTime createdAt;
  String updatedAt;

  Datum({
    required this.id,
    required this.value,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    value: json["value"],
    description: json["description"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "description": description,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}
