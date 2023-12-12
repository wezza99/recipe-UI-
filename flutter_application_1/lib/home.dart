import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recipe_api.dart';
import 'package:flutter_application_1/views/widgets/recipe_card.dart';
import 'models/recipe.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe>? _recipes=[];

  final bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getRecipies();
  }

  Future<void>getRecipies() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading != false;
    });
    print(_recipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(
              width: 10,
            ),
            Text('food recipe'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(),)
          : ListView.builder(
              itemCount: _recipes!.length,
              itemBuilder: (BuildContext context, index) {
                return RecipeCard(
                    title: _recipes![index].name,
                    cookTime: _recipes![index].totalTime,
                    rating: _recipes![index].rating.toString(),
                    thumbnailUrl: _recipes![index].images);
              },
            ),
    );
  }
}
