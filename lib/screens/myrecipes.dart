import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/models/recipe.api.dart';
import 'package:little_savior_v1/models/recipe.dart';
import 'package:little_savior_v1/screens/menue.dart';

class MyRecipes extends StatefulWidget {
  @override
  _MyRecipesState createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Menue().getAppBar(title: "Meine Rezepte"),
      drawer: Menue().getDrawer(context),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  if (index == _recipes.length - 1) {
                    return Column(
                      children: [
                        RecipeEntry(title: _recipes[index].title),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.add_circle,
                            color: Palette.bottleGreen,
                            size: 60,
                          ),
                        )
                      ],
                    );
                  }
                  return RecipeEntry(
                    title: _recipes[index].title,
                  );
                },
              ),
            ),
    );
  }
}

class RecipeEntry extends StatelessWidget {
  final String title;

  RecipeEntry({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: Palette.bottleGreen,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // title text
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
              child: Container(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Lupe und Stift:
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    Icon(
                      // Stift-Icon ist erstmal nur provisiorisch weil der scheiße aussieht...
                      Icons.draw_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
