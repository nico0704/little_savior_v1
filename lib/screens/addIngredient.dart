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
    currentState = "build_not_finished";
    //_focus.addListener(_onFocusChange);
    nameController.addListener(_valueChangeOfName);
    mhdController.addListener(_valueChangeOfMHD);
  }

  // Controller for input
  final nameController = TextEditingController();
  final mhdController = TextEditingController();

  void _valueChangeOfName() {
    name = nameController.text;
  }

  void _valueChangeOfMHD() {
    mhd = mhdController.text;
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
      controller: nameController,
      //focusNode: _focus,
      onEditingComplete: () {
        if (currentState != "build_finished") {
          inputElements.add(_buildMHDInputField());
          inputElements.add(_buildStockInputFields());
          _selectDate(context);
          setState(() {
            currentState = "build_finished";
          });
        }
      },
    );
  }

  _buildMHDInputField() {
    return TextField(
      controller: mhdController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "MHD",
      ),
      onTap: () {
        _selectDate(context);
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 2000)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        mhdController.text = formatter.format(selectedDate);
      });
    }
  }
}

_buildStockInputFields() {
  return TextField(
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      hintText: "Stock",
    ),
  );
}
