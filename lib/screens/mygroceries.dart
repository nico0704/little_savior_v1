import 'package:flutter/material.dart';
import 'package:little_savior_v1/config/palette.dart';
import 'package:little_savior_v1/models/ingredients.dart';
import 'package:little_savior_v1/screens/menue.dart';
import 'package:intl/intl.dart';
import '../models/ingredients.api.dart';
import '../models/product_checkbox_notification_setting.dart';

class MyGroceries extends StatefulWidget {
  const MyGroceries({Key? key}) : super(key: key);

  @override
  State<MyGroceries> createState() => _MyGroceriesState();
}

class _MyGroceriesState extends State<MyGroceries> {
  bool _isLoading = true;
  final DateFormat formatter = DateFormat('dd.MM');
  late List<Ingredients> _ingredients;
  late List<ProductCheckboxNotificationSetting> productNotificationsRed = [];
  late List<ProductCheckboxNotificationSetting> productNotificationsYellow = [];
  late List<ProductCheckboxNotificationSetting> productNotificationsGreen = [];

  @override
  void initState() {
    super.initState();
    getIngredients();
  }

  Future<void> getIngredients() async {
    _ingredients = await IngredientsApi.getIngredients();
    setState(() {
      sortIngredients();
      _isLoading = false;
    });
  }

  Future<void> deleteIngredient(int id) async {
    await IngredientsApi.deleteIngredient(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Menue().getAppBar(title: "Meine Lebensmittel"),
        // get title from database
        drawer: const Menue().getDrawer(context),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const ProductList(
                        "Läuft diese Woche ab", Palette.terraCottaHalf),
                    showList(productNotificationsRed),
                    const ProductList("Läuft nächste Woche ab",
                        Palette.macaroniAndCheeseHalf),
                    showList(productNotificationsYellow),
                    const ProductList(
                        "Länger als 2 Wochen haltbar", Palette.honeydew),
                    showList(productNotificationsGreen),
                  ],
                ),
              ));
  }

  showList(productNotificationsList) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
      child: buildSingleProductCheckbox(context,
          productNotificationsList[index], index, productNotificationsList),
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
      content: Text("${product.title} deleted"),
      action: SnackBarAction(
        label: "Rückgängig",
        onPressed: () {
          undoDelete(index, product, productNotificationsList);
        },
      ),
    )).closed.then((SnackBarClosedReason reason) {
      if (reason == SnackBarClosedReason.timeout) {
        // make api call to ultimately delete product from db
        deleteIngredient(product.id);
      }
    });
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
            checkboxNotification.value = !checkboxNotification.value;
            var product = productNotificationsList[index];
            showSnackBar(context, product, index, productNotificationsList);
            removeProduct(index, productNotificationsList);
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

  void sortIngredients() {
    DateTime now = DateTime.now();
    for (var element in _ingredients) {
      if (element.expiry <= 7) {
        productNotificationsRed.add(ProductCheckboxNotificationSetting(
            title: element.name,
            expiry: element.expiry,
            bbd: now.add(Duration(days: element.expiry)),
            id: element.id,
        ));
      } else if (element.expiry < 14) {
        productNotificationsYellow.add(ProductCheckboxNotificationSetting(
            title: element.name,
            expiry: element.expiry,
            bbd: now.add(Duration(days: element.expiry)), id: element.id));
      } else {
        productNotificationsGreen.add(ProductCheckboxNotificationSetting(
            title: element.name,
            expiry: element.expiry,
            bbd: now.add(Duration(days: element.expiry)), id: element.id));
      }
    }
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