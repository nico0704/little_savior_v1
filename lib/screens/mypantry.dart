import 'package:flutter/material.dart';
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
          buildCategory(20, title: 'Kühlschrank'),
          buildCategory(20, title: 'Gefrierschrank'),
          buildCategory(20, title: 'Vorrat'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20.0),
                backgroundColor: Color.fromRGBO(11, 110, 79, 1.0),
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

  Padding buildCategory(int entries, {required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
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
