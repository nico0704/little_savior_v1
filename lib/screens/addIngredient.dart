import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'menue.dart';

class AddIngredient extends StatefulWidget {
  @override
  _MyAddRecipeState createState() => _MyAddRecipeState();
}

class _MyAddRecipeState extends State<AddIngredient> {
  List<Widget> inputElements = [];
  String? currentState;

  @override
  void initState() {
    inputElements.add(_buildNameInputField());
    super.initState();
    currentState = "nameOfIngredient";
    //_focus.addListener(_onFocusChange);
    //myController.addListener(_valueChangeOfName);
  }

  //FocusNode _focus = FocusNode();
  // Controller for inputs
  //final myController = TextEditingController();
  //void _valueChangeOfName() {
  // change of input
  //}
  //void _onFocusChange() {
  //if (_focus.hasFocus == false) {
  //_expandMHDWidget();
  //}
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Menue().getAppBar(title: "Rezept hinzufügen"),
        drawer: Menue().getDrawer(context),
        body: SingleChildScrollView(
          child: Column(
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
                      children: inputElements,
                    )),
              )
            ],
          ),
        ));
  }

  _buildNameInputField() {
    print("adding ingredient");
    return TextFormField(
      //controller: myController,
      //focusNode: _focus,
      onEditingComplete: () {
        //print("Completed it mate");
        inputElements.add(_buildMHDInputField());
        setState(() {
          currentState = "MHD";
        });
      },
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Lebensmittel',
      ),
    );
  }

  _buildMHDInputField() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 2000)));
    return Text("jetzt ausgewähltes mhd kompakt anzeigen...");
  }
}
