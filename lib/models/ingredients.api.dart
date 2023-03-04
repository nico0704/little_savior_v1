import 'dart:convert';
import 'package:little_savior_v1/models/ingredients.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class IngredientApi {
  static Future<List<Ingredient>> getIngredients() async {
    var uri = Uri.https("medsrv.informatik.hs-fulda.de",
        "/lsbackend/api/v1/ingredients", {'format': 'json'});
    final response = await http.get(uri);
    List<dynamic> dataList = jsonDecode(utf8.decode(response.bodyBytes));
    return Ingredient.ingredientsFromSnapshot(dataList);
  }

  static deleteIngredient(int id) async {
    print("deleting product with id $id");
    var uri = Uri.https(
        "medsrv.informatik.hs-fulda.de", "/lsbackend/api/v1/ingredients/$id");
    final response = await http.delete(uri);
  }

  static Future addIngredient({
    required data,
  }) async {
    var url = Uri.https(
        "medsrv.informatik.hs-fulda.de", "/lsbackend/api/v1/ingredients/");
    var json = jsonEncode(data.toJson());
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json,
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
