import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';

import 'menue.dart';

class SaviorScore extends StatefulWidget {
  const SaviorScore({Key? key}) : super(key: key);

  @override
  State<SaviorScore> createState() => _SaviorScoreState();
}

class _SaviorScoreState extends State<SaviorScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Menue().getAppBar(title: "Savior Score"),
        drawer: const Menue().getDrawer(context),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 85,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Palette.terraCotta,
                      shape: BoxShape.circle,
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('5', style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "weggeworfen",
                      style: TextStyle(
                        color: Palette.terraCotta,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Palette.illuminatingEmerald,
                      shape: BoxShape.circle,
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('13', style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "gerettet",
                      style: TextStyle(
                        color: Palette.illuminatingEmerald,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
