import 'package:flutter/material.dart';
import 'package:little_savior_v1/screens/dashboard.dart';
import 'package:little_savior_v1/screens/myrecipes.dart';

class Menue extends StatelessWidget  {
  const Menue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      drawer: getDrawer(context),
    );
  }


  Drawer getDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(230, 243, 236, 1.0),
      child: ListView(
        children: [
          buildListTile(context, Dashboard(), title: 'Dashboard', ),
          buildListTile(context, Menue(), title: 'Lebensmittel', ),
          buildListTile(context, Menue(), title: 'Vorratskammer', ),
          buildListTile(context, MyRecipes(), title: 'Meine Rezepte', ),
          buildListTile(context, Menue(), title: 'Rezeptvorschläge', ),
          buildListTile(context, Menue(), title: 'Ist das noch gut?',),
          buildListTile(context, Menue(), title: 'Savior Score'),
        ],
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: Text(
        "Little Savior",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromRGBO(11, 110, 79, 1.0),
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
            color: Color.fromRGBO(8, 83, 59, 1.0),
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
