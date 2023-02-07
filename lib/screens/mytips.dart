import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/screens/menue.dart';

class MyTips extends StatefulWidget {
  const MyTips({Key? key}) : super(key: key);

  @override
  State<MyTips> createState() => _MyTipsState();
}

class _MyTipsState extends State<MyTips> {
  bool _visibility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Menue().getAppBar(title: "Ist das noch gut?"),
      drawer: Menue().getDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSearchBar(),
            _buildIngredientTip(),
            _buildIngredientTip(),
            _buildIngredientTip(),
            _buildIngredientTip(),
            _buildIngredientTip(),
          ],
        ),
      ),
    );
  }

  Padding _buildIngredientTip() {


    return Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 20.0, right: 20.0),
          child: Container(
            decoration: BoxDecoration(
                color: Palette.honeydewHalf,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ElevatedButton(
                      child:
                      Text(
                        "ingredient",
                        style: TextStyle(
                          color: Palette.castletonGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _visibility = !_visibility;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.honeydewHalf,
                        shape: RoundedRectangleBorder(),
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _visibility,
                    child: Column(
                      children: [
                        _buildIconPlusText("Sind -ingredients- noch gut?", Icons.add),
                        _buildIconPlusText("text tip", Icons.question_mark),
                        _buildIconPlusText("text tip", Icons.question_mark),
                        _buildIconPlusText("text tip", Icons.question_mark),
                        _buildIconPlusText("text tip", Icons.question_mark),
                        _buildIconPlusText("Wie lagert man -ingredient- richtig?", Icons.add),
                        _buildIconPlusText("text tip", Icons.question_mark),
                        _buildIconPlusText("text tip", Icons.question_mark),
                        _buildIconPlusText("text tip", Icons.question_mark),
                        _buildIconPlusText("text tip", Icons.question_mark),
                        _buildIconPlusText("text tip", Icons.question_mark),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  Row _buildIconPlusText(String inhalt, IconData getIcon) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            getIcon,
            color: Palette.castletonGreen,
          ),
        ),
        Text(
          inhalt,
          style: TextStyle(
            color: Palette.castletonGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Padding buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.honeydewHalf,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 8.0, right: 20.0),
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
    );
  }
}
