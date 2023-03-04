import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:little_savior_v1/screens/menue.dart';
import 'package:little_savior_v1/config/palette.dart';

import '../models/addButton.dart';
import '../models/product_checkbox_notification_setting.dart';
import 'myrecipes.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  List<ProductCheckboxNotificationSetting> productNotificationsRed = [
    ProductCheckboxNotificationSetting(
        title: "Produkt1", expiry: 3, bbd: DateTime.now().add(new Duration(days: 3)), id: 99),
    ProductCheckboxNotificationSetting(
        title: "Produkt2", expiry: 3, bbd: DateTime.now().add(new Duration(days: 3)), id: 99),
    ProductCheckboxNotificationSetting(
        title: "Produkt3", expiry: 3, bbd: DateTime.now().add(new Duration(days: 3)), id: 99),
    ProductCheckboxNotificationSetting(
        title: "Produkt4", expiry: 3, bbd: DateTime.now().add(new Duration(days: 3)), id: 99)
  ];
  final DateFormat formatter = DateFormat('dd.MM');
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Menue().getAppBar(title: "LittleSavior"),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Palette.terraCotta,
                    borderRadius: BorderRadius.circular(100),
                    //more than 50% of width makes circle
                  ),
                  child: const Center(
                      child: Text("2",
                          style: TextStyle(color: Colors.white, fontSize: 44))),
                ),
              ),
              const Text('laufen diese Woche ab',
                  style: TextStyle(
                      color: Palette.terraCotta, fontWeight: FontWeight.bold)),
              //Produkte
              SizedBox(
               child: showList(productNotificationsRed),
              ),
              //Button für Kamera und fürs Adden
              Padding(
                padding: const EdgeInsets.only(right: 14, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 52,
                      width: 55,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Palette.bottleGreen,
                        padding: EdgeInsets.all(5.0),
                        shape: CircleBorder(),
                      ),
                    ),
                    addbutton(subpage: MyRecipes(),),
                  ],
                ),
              ),
              const Text(
                "Versuch's mal hiermit:",
                style: TextStyle(
                    fontSize: 22,
                    color: Palette.castletonGreen,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Pasta mit Tomaten-Sahne Sauce",
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.castletonGreen,
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(

                            width: 30,
                            height: 30,

                            decoration: BoxDecoration(
                              color: Palette.terraCotta,
                              borderRadius: BorderRadius.circular(100),
                              //more than 50% of width makes circle
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: 30,

                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Palette.honeydewHalf,
                                ),
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Palette.honeydewHalf,
                              ),
                              child: Center(child: Text("Champions")),

                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(

                            width: 30,
                            height: 30,

                            decoration: BoxDecoration(
                              color: Palette.terraCotta,
                              borderRadius: BorderRadius.circular(100),

                              //more than 50% of width makes circle
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: 30,

                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Palette.honeydewHalf,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Palette.honeydewHalf,
                              ),
                              child: Center(child: Text("Champions")),

                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(

                            width: 30,
                            height: 30,

                            decoration: BoxDecoration(
                              color: Palette.terraCotta,
                              borderRadius: BorderRadius.circular(100),
                              //more than 50% of width makes circle
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: 30,

                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Palette.honeydewHalf,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Palette.honeydewHalf,
                              ),
                              child: Center(child: Text("Champions")),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.castletonGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyRecipes()), //Hier Muss die Seite des Rezeptes noch rein
                      );
                    },
                    child: Text("Rezept ansehen"),
                  ),
                ),
              )
            ],
          ),
        ),
        drawer: Menue().getDrawer(context),
      ),
    );
  }
  showList(productNotificationsList) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        itemCount: productNotificationsList.length,
        itemBuilder: (BuildContext context, int index) {
          return rowItem(context, index, productNotificationsList);
        });
  }

  rowItem(BuildContext context, int index, productNotificationsList) {
    // code for rowItem to delete via slide...
    return Dismissible(
      key: Key(productNotificationsList[index].title),
      movementDuration: const Duration(seconds: 1),
      background: deleteBgItem(calcColor(productNotificationsList[index].bbd)),
      onDismissed: (direction) {
        var product = productNotificationsList[index];
        showSnackBar(context, product, index, productNotificationsList);
        removeProduct(index, productNotificationsList);
      },
      child: buildSingleProductCheckbox(context, productNotificationsList[index],
          index, productNotificationsList),
    );
    // code for rowItem to delete only via click
    /*
    return buildSingleProductCheckbox(context, productNotificationsList[index],
        index, productNotificationsList);
     */
  }

  Widget deleteBgItem(color) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: color,
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  showSnackBar(context, product, index, productNotificationsList) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      content: Text("${product.title} gelöscht..."),
      action: SnackBarAction(
        label: "Rückgängig",
        onPressed: () {
          undoDelete(index, product, productNotificationsList);
        },
      ),
    ));
  }

  undoDelete(index, product, productNotificationsList) {
    setState(() {
      productNotificationsList.insert(index, product);
      productNotificationsList[index].value = false;
    });
  }

  removeProduct(index, productNotificationsList) {
    setState(() {
      productNotificationsList.removeAt(index);
    });
  }

  Widget buildProductCheckbox({
    required BuildContext context,
    required ProductCheckboxNotificationSetting notification,
    required VoidCallback onClicked,
    required int index,
    required productNotificationsList,
  }) =>
      buildCheckbox(onClicked, notification);

  Widget buildSingleProductCheckbox(
      context,
      ProductCheckboxNotificationSetting checkboxNotification,
      index,
      productNotificationsList) =>
      buildProductCheckbox(
        productNotificationsList: productNotificationsList,
        index: index,
        context: context,
        notification: checkboxNotification,
        onClicked: () {
          setState(() {
            // removing an item...
            /*checkboxNotification.value = !checkboxNotification.value;
            var product = productNotificationsList[index];
            showSnackBar(context, product, index, productNotificationsList);
            removeProduct(index, productNotificationsList);

             */
          });
        },
      );

  Padding buildCheckbox(
      VoidCallback onClicked, ProductCheckboxNotificationSetting notification) {
    Color color = calcColor(notification.bbd); // get color according to bbd
    String displayedText =
        "${notification.title} - ${formatter.format(notification.bbd)}";
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 50, 0),
      child: ListTile(
        onTap: onClicked,
        leading: Checkbox(
          shape: const CircleBorder(),
          side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(width: 3, color: color)),
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

