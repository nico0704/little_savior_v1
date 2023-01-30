import 'dart:convert';

List<Stock> stockFromJson(String str) =>
    List<Stock>.from(json.decode(str).map((x) => Stock.fromJson(x)));

String stockToJson(List<Stock> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stock {
  Stock({
    required this.id,
    required this.name,
    required this.stores,
  });

  int id;
  String name;
  List<int> stores;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        id: json["id"],
        name: json["name"],
        stores: List<int>.from(json["stores"].map((x) => x)),
      );

  static List<Stock> stockFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Stock.fromJson(data);
    }).toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stores": List<dynamic>.from(stores.map((x) => x)),
      };
}
