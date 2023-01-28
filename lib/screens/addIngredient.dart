import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/models/checkbox_notification_setting.dart';
import '../models/stock.dart';
import '../models/stock.api.dart';
import 'menue.dart';

class AddIngredient extends StatefulWidget {
  @override
  _MyAddRecipeState createState() => _MyAddRecipeState();
}

class _MyAddRecipeState extends State<AddIngredient> {
  List<Stock> stocks = [];
  String? currentStock = "";
  List<CheckboxNotificationSetting> notifications = [];
  List<Widget> inputElements = [];
  String? currentState;
  String? name;
  String? mhd;
  DateTime selectedDate = DateTime.now();
  bool _isLoading = true;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  void initState() {
    inputElements.add(_buildNameInputRow());
    super.initState();
    getStocks();
    currentState = "build_not_finished";
    nameController.addListener(_valueChangeOfName);
    mhdController.addListener(_valueChangeOfMHD);
  }

  Future<void> getStocks() async {
    stocks = await StockApi.getStocks();
    for (var i = 0; i < stocks.length; i++) {
      notifications.add(CheckboxNotificationSetting(title: stocks[i].name));
    }
    setState(() {
      _isLoading = false;
    });
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
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      color: Palette.honeydew,
                      child: Column(
                        children: inputElements,
                      ),
                    ),
                    currentState == "build_not_finished"
                        ? Text("") // Empty on purpose
                        : Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Palette.honeydew,
                            child: Column(
                              children: [
                                _buildStockRow(),
                                ...notifications
                                    .map(buildSingleCheckbox)
                                    .toList(),
                              ],
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _buildNameInputRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: new BoxDecoration(
              color: Palette.bottleGreen,
              shape: BoxShape.circle,
            ),
          ),
          Flexible(
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Lebensmittel",
                border: InputBorder.none,
              ),
              controller: nameController,
              //focusNode: _focus,
              onEditingComplete: () {
                if (currentState != "build_finished") {
                  inputElements.add(_buildMHDInputRow());
                  _selectDate(context);
                  setState(() {
                    currentState = "build_finished";
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckbox({
    required CheckboxNotificationSetting notification,
    required VoidCallback onClicked,
  }) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
        child: ListTile(
          onTap: onClicked,
          leading: Checkbox(
            shape: CircleBorder(),
            activeColor: Palette.bottleGreen,
            checkColor: Colors.transparent,
            value: notification.value,
            onChanged: (value) => onClicked(),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              notification.title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ),
      );

  Widget buildSingleCheckbox(
          CheckboxNotificationSetting checkboxNotification) =>
      buildCheckbox(
          notification: checkboxNotification,
          onClicked: () {
            setState(() {
              //final newValue = !checkboxNotification.value;
              currentStock = checkboxNotification.title;
              notifications.forEach((element) {
                element.value = false;
              });
              checkboxNotification.value = true;
            });
          });

  _buildStockRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: new BoxDecoration(
              color: Palette.bottleGreen,
              shape: BoxShape.circle,
            ),
          ),
          Flexible(
            child: TextField(
              textAlign: TextAlign.center,
              readOnly: true,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                hintText: currentStock,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildMHDInputRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: new BoxDecoration(
              color: Palette.honeydewHalf,
              shape: BoxShape.circle,
            ),
          ),
          Flexible(
            child: TextField(
              controller: mhdController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "MHD",
                border: InputBorder.none,
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
          ),
        ],
      ),
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
