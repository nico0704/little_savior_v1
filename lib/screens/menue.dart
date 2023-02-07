import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/screens/addIngredient.dart';
import 'package:little_savior_v1/screens/dashboard.dart';
import 'package:little_savior_v1/screens/myStockIngredients.dart';
import 'package:little_savior_v1/screens/mygroceries.dart';
import 'package:little_savior_v1/screens/mypantry.dart';
import 'package:little_savior_v1/screens/myrecipes.dart';
import 'package:little_savior_v1/screens/mytips.dart';

class Menue extends StatelessWidget  {
  const Menue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: 'Little Savior'),
      drawer: getDrawer(context),
    );
  }


  Drawer getDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Palette.honeydewHalf,
      child: ListView(
        children: [
          buildListTile(context, Dashboard(), title: 'Dashboard', ),
          buildListTile(context, MyGroceries(), title: 'Lebensmittel', ),
          buildListTile(context, MyPantry(), title: 'Vorratskammer', ),
          buildListTile(context, MyRecipes(), title: 'Meine Rezepte', ),
          buildListTile(context, Menue(), title: 'Rezeptvorschläge', ),
          buildListTile(context, MyTips(), title: 'Ist das noch gut?',),
          buildListTile(context, Menue(), title: 'Savior Score'),
          buildListTile(context, AddIngredient(), title: "Lebensmittel adden (Nur zum testen hier drin)"),
          buildListTile(context, MyStockIngredients(), title: "random stock zum testen"),
        ],
      ),
    );
  }

  AppBar getAppBar({required String title}) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Palette.bottleGreen,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  Widget buildListTile(BuildContext context, Widget route,{required String title}) {
    return ListTile(
      dense: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Text(
          title,
          style: TextStyle(
            color: Palette.castletonGreen,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
       Navigator.push(context,
       MaterialPageRoute(builder: (context) => route));
      },
    );
  }
}
