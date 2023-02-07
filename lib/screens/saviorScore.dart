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
        body: Container(
          //color: Palette.macaroniAndCheeseHalf,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Palette.terraCotta,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
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
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
