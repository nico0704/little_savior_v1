import 'package:http/http.dart';
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
  List<CheckboxNotificationSetting> stockNotifications = [];

  // dummy data... später von DB holen
  List<CheckboxNotificationSetting> unitNotifications = [
    CheckboxNotificationSetting(title: "Gramm"),
    CheckboxNotificationSetting(title: "Kilo"),
    CheckboxNotificationSetting(title: "Stück"),
    CheckboxNotificationSetting(title: "Packungen"),
  ];

  List<Widget> inputElements = [];
  String? currentState;
  String? name;
  String? mhd;
  String? quantity;
  String? currentStock = ""; // currently selected stock
  String? currentUnit = ""; // currently selected unit
  DateTime selectedDate = DateTime.now();
  bool _isLoading = true;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  // booleans for form logic
  bool nameInputFinished = false;
  bool mhdInputFinished = false;

  @override
  void initState() {
    inputElements.add(buildNameInputRow());
    super.initState();
    getStocks();
    currentState = "build_not_finished";
    nameController.addListener(_valueChangeOfName);
    mhdController.addListener(_valueChangeOfMHD);
    quantityController.addListener(_valueChangeOfQuantity);
  }

  Future<void> getStocks() async {
    stocks = await StockApi.getStocks();
    for (var i = 0; i < stocks.length; i++) {
      stockNotifications
          .add(CheckboxNotificationSetting(title: stocks[i].name));
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Controller for input
  final nameController = TextEditingController();
  final mhdController = TextEditingController();
  final quantityController = TextEditingController();

  void _valueChangeOfName() {
    name = nameController.text;
  }

  void _valueChangeOfMHD() {
    mhd = mhdController.text;
  }

  void _valueChangeOfQuantity() {
    quantity = quantityController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Menue().getAppBar(title: "Lebensmittel hinzufügen"),
        drawer: Menue().getDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // camera icon
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
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
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Palette.bottleGreen),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Palette.bottleGreen,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      children: [
                        buildNameInputRow(),
                        nameInputFinished ? buildMHDInputRow() : Container(),
                        // build rest...
                        if (mhdInputFinished) ...[
                          Card(
                            margin: EdgeInsets.only(top: 1),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black26),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Palette.honeydewHalf,
                            child: Column(
                              children: [
                                buildStockRow(),
                                ...stockNotifications
                                    .map(buildSingleStockCheckbox)
                                    .toList(),
                              ],
                            ),
                          ),
                          buildQuantityRow(),
                          Card(
                            margin: EdgeInsets.only(top: 1),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black26),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Palette.honeydewHalf,
                            child: Column(
                              children: [
                                buildUnitRow(),
                                ...unitNotifications
                                    .map(buildSingleUnitCheckbox)
                                    .toList(),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
              if (mhdInputFinished) buildOptionButtons(),
            ],
          ),
        ));
  }

  Widget buildNameInputRow() => (Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydewHalf,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Row(
            children: [
              FormCircle(),
              Flexible(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Lebensmittel",
                    border: InputBorder.none,
                  ),
                  controller: nameController,
                  onEditingComplete: () {
                    setState(() {
                      if (nameInputFinished == false) {
                        nameInputFinished = true;
                        _selectDate(context);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ));

  Widget buildStockCheckbox({
    required CheckboxNotificationSetting notification,
    required VoidCallback onClicked,
  }) =>
      buildCheckbox(onClicked, notification);

  Widget buildSingleStockCheckbox(
          CheckboxNotificationSetting checkboxNotification) =>
      buildStockCheckbox(
          notification: checkboxNotification,
          onClicked: () {
            setState(() {
              currentStock = checkboxNotification.title;
              for (var element in stockNotifications) {
                element.value = false;
              }
              checkboxNotification.value = true;
            });
          });

  Widget buildUnitCheckbox({
    required CheckboxNotificationSetting notification,
    required VoidCallback onClicked,
  }) =>
      buildCheckbox(onClicked, notification);

  Widget buildSingleUnitCheckbox(
          CheckboxNotificationSetting checkboxNotification) =>
      buildUnitCheckbox(
          notification: checkboxNotification,
          onClicked: () {
            setState(() {
              currentUnit = checkboxNotification.title;
              for (var element in unitNotifications) {
                element.value = false;
              }
              checkboxNotification.value = true;
            });
          });

  Widget buildQuantityRow() => (Card(
        margin: EdgeInsets.only(top: 1),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydewHalf,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Row(
            children: [
              FormCircle(),
              Flexible(
                child: TextField(
                  controller: quantityController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Menge",
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  onEditingComplete: () {},
                ),
              ),
            ],
          ),
        ),
      ));

  Widget buildUnitRow() => Card(
        margin: EdgeInsets.only(top: 1),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydewHalf,
        child: (Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Row(
            children: [
              FormCircle(),
              Flexible(
                child: TextField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: currentUnit == "" ? Colors.black26 : Colors.black,
                    ),
                    hintText: currentUnit == "" ? "Einheit" : currentUnit,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        )),
      );

  Widget buildStockRow() => Card(
        margin: EdgeInsets.only(top: 1),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydewHalf,
        child: (Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Row(
            children: [
              FormCircle(),
              Flexible(
                child: TextField(
                  keyboardType: TextInputType.none,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: currentStock == "" ? Colors.black26 : Colors.black,
                    ),
                    hintText:
                        currentStock == "" ? "Aufbewahrungsort" : currentStock,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        )),
      );

  Padding buildCheckbox(
      VoidCallback onClicked, CheckboxNotificationSetting notification) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 50, 0),
      child: ListTile(
        onTap: onClicked,
        leading: Checkbox(
          shape: CircleBorder(),
          activeColor: Palette.bottleGreen,
          checkColor: Colors.transparent,
          value: notification.value,
          onChanged: (value) => onClicked(),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Palette.honeydew,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                notification.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMHDInputRow() => (Card(
        margin: EdgeInsets.only(top: 2),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydewHalf,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Row(
            children: [
              FormCircle(),
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
        ),
      ));

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        helpText: "Wann läuft dein Produkt ab?",
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 2000)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        mhdController.text = formatter.format(selectedDate);
        mhdInputFinished = true;
      });
    }
  }

  Widget buildOptionButtons() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: (Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptionButton("wegwerfen", Palette.terraCotta),
            OptionButton("abbrechen", Palette.macaroniAndCheese),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () {
                  //postData();
                },
                child: Text("speichern", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.bottleGreen,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
          ],
        )),
      );
}

class OptionButton extends StatelessWidget {
  final String title;
  final Color color;

  const OptionButton(
    this.title,
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(title, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }
}

class FormCircle extends StatelessWidget {
  const FormCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: new BoxDecoration(
        color: Palette.bottleGreen,
        shape: BoxShape.circle,
      ),
    );
  }
}

// post data to add a new ingredient
/*
void postData() async {
  print("posting data...");
  final url =
      "http://medsrv.informatik.hs-fulda.de/lsbackend/api/v1/ingredients/";
  try {
    final response = await post(Uri.parse(url), body: {
      // example data
      "name": name,
      "default_ddb": selectedDate.toString(),
      "barcode": "12345678",
      "category": "2",
    });
    print(response.body);
  } catch (err) {
    print(err);
  }
}
*/