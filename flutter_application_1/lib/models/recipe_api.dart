import 'dart:convert';
import 'package:flutter_application_1/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>?> getRecipe() async {
    var uri = Uri.https(
      "yummly2.p.rapidapi.com",
      "/feeds/list",
      {"limit": "24", "start": "0", "tag": "list.recipe.popular"},
    );
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'ffa92fb369mshdd5d0f11fe8c3bep1184f4jsnf730f10cbc1c',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com',
      "useQueryString": "true",
    });
    Map data = jsonDecode(response.body);
    List? _temp = [];
    for (var i in data["feed"]) {
      _temp.add(i["content"]["details"]);
    }
    return Recipe.recipeSnapShot(_temp);
  }
}
