import 'dart:convert';
import 'package:little_savior_v1/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.http("medsrv.informatik.hs-fulda.de", "/lsbackend/api/v1/recipes", {'format': 'json'});
    final response = await http.get(uri);
    List<dynamic> dataList = jsonDecode(response.body);
    //print(response.body);
    return Recipe.recipesFromSnapshot(dataList);
  }
}

//http://medsrv.informatik.hs-fulda.de/lsbackend/api/v1/recipes.json