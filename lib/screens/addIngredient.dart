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
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: [
                    buildNameInputRow(),
                    nameInputFinished ? buildMHDInputRow() : Container(),
                    mhdInputFinished ? buildStockRow() : Container(),
                    // build rest...
                    if (mhdInputFinished)
                      Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Palette.honeydew,
                        child: Column(
                          children: [
                            ...stockNotifications
                                .map(buildSingleStockCheckbox)
                                .toList(),
                          ],
                        ),
                      ),
                    mhdInputFinished ? buildQuantityRow() : Container(),
                    mhdInputFinished ? buildUnitRow() : Container(),
                    if (mhdInputFinished)
                      Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Palette.honeydew,
                        child: Column(
                          children: [
                            ...unitNotifications
                                .map(buildSingleUnitCheckbox)
                                .toList(),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget buildNameInputRow() => (Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydew,
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
                      nameInputFinished = true;
                      _selectDate(context);
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
        margin: EdgeInsets.only(top: 5),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydew,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Row(
            children: [
              FormCircle(),
              Flexible(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Menge",
                    border: InputBorder.none,
                  ),
                  //controller: nameController,
                  onEditingComplete: () {},
                ),
              ),
            ],
          ),
        ),
      ));

  Widget buildUnitRow() => Card(
        margin: EdgeInsets.only(top: 5),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydew,
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
        margin: EdgeInsets.only(top: 5),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydew,
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

  Widget buildMHDInputRow() => (Card(
        margin: EdgeInsets.only(top: 5),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Palette.honeydew,
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
        context: context,
        initialDate: DateTime.now(),
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
