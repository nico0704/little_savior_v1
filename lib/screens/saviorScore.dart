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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 85,
                        width: 90,
                        decoration: const BoxDecoration(
                          color: Palette.terraCotta,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('5',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "weggeworfen",
                          style: TextStyle(
                            color: Palette.terraCotta,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Palette.illuminatingEmerald,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('13',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
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
              Container(
                //color: Palette.peach,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 15),
                      child: Container(
                        //color: Palette.terraCotta,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                              child: Text(
                                "ca.",
                                style: TextStyle(
                                  color: Palette.bottleGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              "78 Kilo",
                              style: TextStyle(
                                color: Palette.bottleGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Text("Lebensmittel werden jährlich pro Person", style: TextStyle(color: Palette.bottleGreen, fontSize: 20),),
                    const Text("in Privathaushalten weggeworfen", style: TextStyle(color: Palette.bottleGreen, fontSize: 20)),
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 8),
                      child: Text("das sind etwa", style: TextStyle(color: Palette.bottleGreen, fontSize: 20)),
                    ),
                    const Text("59%", style: TextStyle(color: Palette.bottleGreen, fontSize: 28, fontWeight: FontWeight.bold)),
                    const Text("der gesamten Lebensmittelabfälle", style: TextStyle(color: Palette.bottleGreen, fontSize: 20)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
