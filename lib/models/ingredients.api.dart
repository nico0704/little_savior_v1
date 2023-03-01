import 'dart:convert';
import 'package:little_savior_v1/models/ingredients.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class IngredientsApi {
  static Future<List<Ingredients>> getIngredients() async {
    var uri = Uri.https("medsrv.informatik.hs-fulda.de", "/lsbackend/api/v1/ingredients", {'format': 'json'});
    final response = await http.get(uri);
    List<dynamic> dataList = jsonDecode(response.body);
    //print(response.body);
    return Ingredients.ingredientsFromSnapshot(dataList);
  }

  static deleteIngredient(int id) async {
    print("deleting product with id $id");
    var uri = Uri.https("medsrv.informatik.hs-fulda.de", "/lsbackend/api/v1/ingredients/$id");
    final response = await http.delete(uri);
  }
}

//http://medsrv.informatik.hs-fulda.de/lsbackend/api/v1/ingredients.json