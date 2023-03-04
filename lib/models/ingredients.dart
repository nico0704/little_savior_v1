// To parse this JSON data, do
//
//     final ingredients = ingredientsFromJson(jsonString);

import 'dart:convert';

List<Ingredient> ingredientsFromJson(String str) => List<Ingredient>.from(
    json.decode(str).map((x) => Ingredient.fromJson(x)));

String ingredientsToJson(List<Ingredient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ingredient {
  Ingredient({
    required this.id,
    required this.name,
    this.defaultDdb,
    required this.expiry,
    required this.barcode,
    required this.category,
    required this.instock,
    required this.inrecipe,
  });

  int id;
  String name;
  dynamic defaultDdb;
  int expiry;
  int barcode;
  int category;
  List<dynamic> instock;
  List<dynamic> inrecipe;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        defaultDdb: json["default_ddb"],
        expiry: json["expiry"],
        barcode: json["barcode"],
        category: json["category"],
        instock: List<dynamic>.from(json["instock"].map((x) => x)),
        inrecipe: List<dynamic>.from(json["inrecipe"].map((x) => x)),
      );

  static List<Ingredient> ingredientsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Ingredient.fromJson(data);
    }).toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "default_ddb": defaultDdb,
        "expiry": expiry,
        "barcode": barcode,
        "category": category,
        "instock": List<dynamic>.from(instock.map((x) => x)),
        "inrecipe": List<dynamic>.from(inrecipe.map((x) => x)),
      };
}
