import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/palette.dart';

class addbutton extends StatelessWidget {
  final subpage;
  const addbutton({Key? key, required this.subpage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              subpage), //Hier Muss die Seite des Rezeptes noch rein
        );
      },

      elevation: 2.0,
      fillColor: Palette.bottleGreen,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 35.0,
      ),
      padding: EdgeInsets.all(9.0),
      shape: CircleBorder(),
    );
  }
}
