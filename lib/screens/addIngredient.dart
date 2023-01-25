import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'menue.dart';

class AddIngredient extends StatefulWidget {
  @override
  _MyAddRecipeState createState() => _MyAddRecipeState();
}

class _MyAddRecipeState extends State<AddIngredient> {
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    myController.addListener(_valueChangeOfName);
  }

  FocusNode _focus = FocusNode();
  // Controller for inputs
  final myController = TextEditingController();
  void _valueChangeOfName() {
    // change of input
  }
  void _onFocusChange() {
    // print("Focus: ${_focus.hasFocus.toString()}");
    if (_focus.hasFocus == false) {
      print("expand...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Menue().getAppBar(title: "Rezept hinzufügen"),
        drawer: Menue().getDrawer(context),
        body: Column(
          children: [
            // camera icon
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 40),
                child: ElevatedButton(
                    onPressed: () {
                      // open camera to scan barcode...
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Palette.honeydewHalf,
                      shadowColor: Colors.transparent,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Palette.bottleGreen,
                      size: 100,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                  color: Palette.honeydew,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: myController,
                        focusNode: _focus,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Lebensmittel',
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}