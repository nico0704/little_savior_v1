import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'menue.dart';

class AddIngredient extends StatefulWidget {
  @override
  _MyAddRecipeState createState() => _MyAddRecipeState();
}

class _MyAddRecipeState extends State<AddIngredient> {
  List<Widget> inputElements = [];
  String? currentState;
  String? name;
  String? mhd;
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  void initState() {
    inputElements.add(_buildNameInputField());
    super.initState();
    currentState = "nameOfIngredient";
    //_focus.addListener(_onFocusChange);
    myController.addListener(_valueChangeOfName);
  }

  // Controller for input
  final myController = TextEditingController();

  void _valueChangeOfName() {
    //print(myController.text);
    name = myController.text;
  }

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
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Lebensmittel",
      ),
      controller: myController,
      //focusNode: _focus,
      onEditingComplete: () {
        if (currentState != "MHD") {
          inputElements.add(_buildMHDInputField());
          setState(() {
            currentState = "MHD";
          });
        }
      },
    );
  }

  _buildMHDInputField() {
    _selectDate(context);
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "MHD",
      ),
      onTap: () {
        _selectDate(context);
      },
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 2000)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        inputElements[1] = ElevatedButton(
          onPressed: () {
            _selectDate(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              formatter.format(selectedDate),
            ),
          ),
        );
        //print(selectedDate);
      });
      return selectedDate;
    }
    return DateTime.now();
  }
}
