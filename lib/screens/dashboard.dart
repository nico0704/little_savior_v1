import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_savior_v1/screens/menue.dart';
import 'package:little_savior_v1/config/palette.dart';

import 'myrecipes.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Menue().getAppBar(title: "LittleSavior"),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Palette.terraCotta,
                    borderRadius: BorderRadius.circular(100),
                    //more than 50% of width makes circle
                  ),
                  child: const Center(
                      child: Text("2",
                          style: TextStyle(color: Colors.white, fontSize: 44))),
                ),
              ),
              const Text('laufen diese Woche ab',
                  style: TextStyle(
                      color: Palette.terraCotta, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 180,
                child: ListView(
                  padding: const EdgeInsets.all(8),

                  children: <Widget>[
                    Container(
                      height: 50,
                      color: Palette.honeydewHalf,
                      child: Center(child: Text("Champions")),
                    ),
                    Container(
                      height: 50,
                      color: Palette.honeydewHalf,
                      child: Center(child: Text("Champions")),
                    ),
                    Container(
                      height: 50,
                      color: Palette.honeydewHalf,
                        child: Center(child: Text("Champions")),
                    ),
                  ],
                ),
              ),




              Padding(
                padding: const EdgeInsets.only(right: 42,bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 52,
                      width: 55,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Palette.bottleGreen,
                        padding: EdgeInsets.all(5.0),
                        shape: CircleBorder(),
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Palette.bottleGreen,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 35.0,
                      ),
                      padding: EdgeInsets.all(9.0),
                      shape: CircleBorder(),
                    ),
                  ],

                ),
              ),

              const Text(
                "Versuch's mal hiermit:",
                style: TextStyle(
                    fontSize: 22,
                    color: Palette.castletonGreen,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Pasta mit Tomaten-Sahne Sauce",
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.castletonGreen,
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView(
                  padding: const EdgeInsets.all(8),

                  children: <Widget>[
                    Container(
                      height: 50,
                      color: Palette.honeydewHalf,
                      child: Center(child: Text("Champions")),
                    ),
                    Container(
                      height: 50,
                      color: Palette.honeydewHalf,
                        child: Center(child: Text("Champions"))
                    ),
                    Container(
                      height: 50,
                      color: Palette.honeydewHalf,
                      child: Center(child: Text("Champions")),
                    ),
                  ],
                ),
              ),


              SizedBox( height: 40,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.castletonGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyRecipes()), //Hier Muss die Seite des Rezeptes noch rein
                      );
                    },
                    child: Text("Rezept ansehen"),
                  ),
                ),
              )
            ],
          ),
        ),
        drawer: Menue().getDrawer(context),
      ),
    );
  }
}
