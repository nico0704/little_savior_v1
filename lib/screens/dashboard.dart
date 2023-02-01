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
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height:200,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Palette.terraCotta,
                      borderRadius: BorderRadius.circular(100),
                    //more than 50% of width makes circle
                  ),
                ),
              ),
              Text('Läuft diese Woche ab',
                  style: TextStyle(color: Color.fromRGBO(8, 83, 59, 1.0))),
              SizedBox(
                height: 75,
              ),
              Text("Versuch's mal hiermit:",style: TextStyle(
                  fontSize: 22,
                  color: Palette.castletonGreen,
                  fontWeight: FontWeight.bold),),
              Text("Pasta mit Tomaten-Sahne Sauce",style: TextStyle(
                  fontSize: 18,
                  color: Palette.castletonGreen,
              ),),
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.castletonGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                    ),

                  ),
                    onPressed:(){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyRecipes()), //Hier Muss die Seite des Rezeptes noch rein
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
