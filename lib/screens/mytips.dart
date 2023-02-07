import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/screens/menue.dart';

class MyTips extends StatelessWidget {
  const MyTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Menue().getAppBar(title: "Ist das noch gut?"),
      drawer: Menue().getDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Palette.honeydewHalf,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Suche',
                        fillColor: Palette.honeydew,
                        filled: true,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
