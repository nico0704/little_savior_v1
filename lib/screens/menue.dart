import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/screens/dashboard.dart';
import 'package:little_savior_v1/screens/mygroceries.dart';
import 'package:little_savior_v1/screens/mypantry.dart';
import 'package:little_savior_v1/screens/myrecipes.dart';

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
          buildListTile(context, Menue(), title: 'Ist das noch gut?',),
          buildListTile(context, Menue(), title: 'Savior Score'),
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
