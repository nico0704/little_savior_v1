import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/screens/menue.dart';

class MyGroceries extends StatelessWidget {
  const MyGroceries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Menue().getAppBar(title: "Meine Lebensmittel"),
      drawer: Menue().getDrawer(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView(children: [
          ListTile(
            tileColor: Palette.terraCottaHalf,
            title: Text(
              "Läuft diese Woche ab",
              style: TextStyle(color: Palette.castletonGreen, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 10, 20, 0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              tileColor: Palette.honeydewHalf,
              title: Text(
                "Zucchini - morgen",
                style: TextStyle(color: Palette.castletonGreen),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Padding buildCategory(int entries, {required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Color.fromRGBO(11, 110, 79, 1.0),
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
