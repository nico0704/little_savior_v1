import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import '../models/checkbox_notification_setting.dart';
import 'menue.dart';

class MyStockIngredients extends StatefulWidget {
  const MyStockIngredients({Key? key}) : super(key: key);

  @override
  State<MyStockIngredients> createState() => _MyStockIngredientsState();
}

class _MyStockIngredientsState extends State<MyStockIngredients> {
  final bool _isLoading = false;

  // following code is just dummy data for testing...
  late List<Product> _products;
  List<CheckboxNotificationSetting> productNotificationsRed = [CheckboxNotificationSetting(title: "Produkt1"), CheckboxNotificationSetting(title: "Produkt2"), CheckboxNotificationSetting(title: "Produkt3"), CheckboxNotificationSetting(title: "Produkt4")];
  List<CheckboxNotificationSetting> productNotificationsYellow = [CheckboxNotificationSetting(title: "Produkt5"), CheckboxNotificationSetting(title: "Produkt6"), CheckboxNotificationSetting(title: "Produkt7"), CheckboxNotificationSetting(title: "Produkt8")];
  List<CheckboxNotificationSetting> productNotificationsGreen = [CheckboxNotificationSetting(title: "Produkt9"), CheckboxNotificationSetting(title: "Produkt10"), CheckboxNotificationSetting(title: "Produkt11"), CheckboxNotificationSetting(title: "Produkt12")];
  // end of test code
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Menue().getAppBar(title: "Mein Kühlschrank"),
        // get title from database
        drawer: Menue().getDrawer(context),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ProductList("Läuft diese Woche ab", Palette.terraCottaHalf),
                    ...productNotificationsRed
                        .map(buildSingleProductCheckbox)
                        .toList(),
                    ProductList("Läuft nächste Woche ab",
                        Palette.macaroniAndCheeseHalf),
                    ...productNotificationsYellow
                        .map(buildSingleProductCheckbox)
                        .toList(),
                    ProductList(
                        "Länger als 2 Wochen haltbar", Palette.honeydew),
                    ...productNotificationsGreen
                        .map(buildSingleProductCheckbox)
                        .toList(),
                  ],
                ),
              ));
  }

  Widget buildProductCheckbox({
    required CheckboxNotificationSetting notification,
    required VoidCallback onClicked,
  }) =>
      buildCheckbox(onClicked, notification);

  Widget buildSingleProductCheckbox(
          CheckboxNotificationSetting checkboxNotification) =>
      buildProductCheckbox(
          notification: checkboxNotification,
          onClicked: () {
            setState(() {
              //print(checkboxNotification.title);
              checkboxNotification.value = !checkboxNotification.value;
            });
          },
      );

  Padding buildCheckbox(
      VoidCallback onClicked, CheckboxNotificationSetting notification) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 50, 0),
      child: ListTile(
        onTap: onClicked,
        leading: Checkbox(
          shape: const CircleBorder(),
          side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 2, color: Palette.bottleGreen)),
          activeColor: Palette.bottleGreen,
          checkColor: Colors.transparent,
          value: notification.value,
          onChanged: (value) => onClicked(),
        ),
        title: Container(
          decoration: const BoxDecoration(
            color: Palette.honeydewHalf,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
}

class ProductList extends StatelessWidget {
  final String title;
  final Color color;

  const ProductList(
    this.title,
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        color: color,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: Palette.bottleGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// dummy class

class Product {
  Product({
    required this.name,
    required this.bbd,
  });

  String name;
  String bbd;
}
