import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/screens/dashboard.dart';
import 'package:little_savior_v1/screens/menue.dart';

class MyPantry extends StatelessWidget {
  const MyPantry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Menue().getAppBar(title: "Vorratskammer"),
      drawer: Menue().getDrawer(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView(children: [
          buildCategory(context, Dashboard(),20, title: 'Kühlschrank'),
          buildCategory(context, Dashboard(),20, title: 'Gefrierschrank'),
          buildCategory(context, Dashboard(),20, title: 'Vorrat'),
          //addButton
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20.0),
                backgroundColor: Palette.bottleGreen,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              },
              child: Text(
                "+",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              )
            ),
          ),
        ]),
      ),
    );
  }

  Padding buildCategory(BuildContext context, Widget route, int entries, {required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => route));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        tileColor: Palette.bottleGreen,
        title: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Text(
                    "${entries} Einträge",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.draw_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
