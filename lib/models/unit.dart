// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';

List<Unit> unitFromJson(String str) => List<Unit>.from(json.decode(str).map((x) => Unit.fromJson(x)));

String unitToJson(List<Unit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Unit {
  Unit({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    name: json["name"],
  );

  static List<Unit> unitFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Unit.fromJson(data);
    }).toList();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}