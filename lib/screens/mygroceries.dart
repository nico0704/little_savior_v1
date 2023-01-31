import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/screens/menue.dart';
import 'package:intl/intl.dart';
import '../models/product_checkbox_notification_setting.dart';

class MyGroceries extends StatefulWidget {
  const MyGroceries({Key? key}) : super(key: key);

  @override
  State<MyGroceries> createState() => _MyGroceriesState();
}

class _MyGroceriesState extends State<MyGroceries> {
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
        appBar: const Menue().getAppBar(title: "Meine Lebensmittel"),
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
              const ProductList("Läuft nächste Woche ab", Palette.macaroniAndCheeseHalf),
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

/*class MyGroceries extends StatelessWidget {
  const MyGroceries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Menue().getAppBar(title: "Meine Lebensmittel"),
      drawer: Menue().getDrawer(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView(children: [
          ListTile(
            tileColor: Palette.terraCottaHalf,
            title: Text(
              "Läuft diese Woche ab",
              style: TextStyle(color: Palette.castletonGreen, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 10, 20, 0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              tileColor: Palette.honeydewHalf,
              title: Text(
                "Zucchini - morgen",
                style: TextStyle(color: Palette.castletonGreen),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Padding buildCategory(int entries, {required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Color.fromRGBO(11, 110, 79, 1.0),
        title: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Text(
                    "${entries} Einträge",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.draw_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

 */
