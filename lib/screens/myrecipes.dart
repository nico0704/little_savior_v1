import 'package:flutter/material.dart';
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
        appBar: Menue().getAppBar(),
        drawer: Menue().getDrawer(context),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeEntry(
                    title: _recipes[index].title,
                  );
                },
              ));
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
        color: Color.fromRGBO(11, 110, 79, 1.0),
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
