import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:little_savior_v1/config/palette.dart';
import '../models/product_checkbox_notification_setting.dart';
import 'menue.dart';

class MyStockIngredients extends StatefulWidget {
  const MyStockIngredients({Key? key}) : super(key: key);

  @override
  State<MyStockIngredients> createState() => _MyStockIngredientsState();
}

class _MyStockIngredientsState extends State<MyStockIngredients> {
  final bool _isLoading = false;
  final DateFormat formatter = DateFormat('dd.MM');

  // following code is just dummy data for testing...
  late List<Product> _products;
  List<ProductCheckboxNotificationSetting> productNotificationsRed = [ProductCheckboxNotificationSetting(title: "Produkt1", bbd: DateTime.now().add(new Duration(days: 3))), ProductCheckboxNotificationSetting(title: "Produkt2", bbd: DateTime.now().add(new Duration(days: 3))), ProductCheckboxNotificationSetting(title: "Produkt3", bbd: DateTime.now().add(new Duration(days: 3))), ProductCheckboxNotificationSetting(title: "Produkt4", bbd: DateTime.now().add(new Duration(days: 3)))];
  List<ProductCheckboxNotificationSetting> productNotificationsYellow = [ProductCheckboxNotificationSetting(title: "Produkt5", bbd: DateTime.now().add(new Duration(days: 10))), ProductCheckboxNotificationSetting(title: "Produkt6", bbd: DateTime.now().add(new Duration(days: 10))), ProductCheckboxNotificationSetting(title: "Produkt7", bbd: DateTime.now().add(new Duration(days: 10))), ProductCheckboxNotificationSetting(title: "Produkt8", bbd: DateTime.now().add(new Duration(days: 10)))];
  List<ProductCheckboxNotificationSetting> productNotificationsGreen = [ProductCheckboxNotificationSetting(title: "Produkt9", bbd: DateTime.now().add(new Duration(days: 20))), ProductCheckboxNotificationSetting(title: "Produkt10", bbd: DateTime.now().add(new Duration(days: 20))), ProductCheckboxNotificationSetting(title: "Produkt11", bbd: DateTime.now().add(new Duration(days: 20))), ProductCheckboxNotificationSetting(title: "Produkt12", bbd: DateTime.now().add(new Duration(days: 20)))];
  // end of test code
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Menue().getAppBar(title: "Mein Kühlschrank"),
        // get title from database
        drawer: const Menue().getDrawer(context),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const ProductList("Läuft diese Woche ab", Palette.terraCottaHalf),
                    ...productNotificationsRed
                        .map(buildSingleProductCheckbox)
                        .toList(),
                    const ProductList("Läuft nächste Woche ab",
                        Palette.macaroniAndCheeseHalf),
                    ...productNotificationsYellow
                        .map(buildSingleProductCheckbox)
                        .toList(),
                    const ProductList(
                        "Länger als 2 Wochen haltbar", Palette.honeydew),
                    ...productNotificationsGreen
                        .map(buildSingleProductCheckbox)
                        .toList(),
                  ],
                ),
              ));
  }

  Widget buildProductCheckbox({
    required ProductCheckboxNotificationSetting notification,
    required VoidCallback onClicked,
  }) =>
      buildCheckbox(onClicked, notification);

  Widget buildSingleProductCheckbox(
          ProductCheckboxNotificationSetting checkboxNotification) =>
      buildProductCheckbox(
          notification: checkboxNotification,
          onClicked: () {
            setState(() {
              checkboxNotification.value = !checkboxNotification.value;
            });
          },
      );

  Padding buildCheckbox(
      VoidCallback onClicked, ProductCheckboxNotificationSetting notification) {
    Color color = calcColor(notification.bbd); // get color according to bbd
    String displayedText = "${notification.title} - ${formatter.format(notification.bbd)}";
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 50, 0),
      child: ListTile(
        onTap: onClicked,
        leading: Checkbox(
          shape: const CircleBorder(),
          side: MaterialStateBorderSide.resolveWith((states) => BorderSide(width: 2, color: color)),
          activeColor: color,
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
                displayedText,
                style: const TextStyle(
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

  Color calcColor(DateTime bbd) {
    // helper method to calculate color according to bbd
    DateTime now = DateTime.now();
    if (bbd.difference(now).inDays < 7) {
      // läuft diese Woche ab
      return Palette.terraCottaHalf;
    }
    if (bbd.difference(now).inDays < 14) {
      // läuft nächste Woche ab
      return Palette.macaroniAndCheeseHalf;
    }
    // noch mindestens 2 Wochen haltbar
    return Palette.honeydew;
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
      padding: const EdgeInsets.only(top: 25),
      child: Card(
        color: color,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
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
