import 'package:flutter/material.dart';

class Menue extends StatelessWidget {
  const Menue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Little Savior", style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(8, 83, 59, 1.0),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(8, 83, 59, 1.0),
                ),
                child: Text("Menü"))
          ],
        ),
      ),
    );
  }
}
