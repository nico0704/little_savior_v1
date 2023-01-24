import 'package:flutter/material.dart';

class Menue extends StatelessWidget {
  const Menue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Little Savior",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(11, 110, 79, 1.0),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(230, 243, 236, 1.0),
        child: ListView(
          children: [
            _buildListTile(title: 'Dashboard'),
            _buildListTile(title: 'Lebensmittel'),
            _buildListTile(title: 'Vorratskammer'),
            _buildListTile(title: 'Meine Rezepte'),
            _buildListTile(title: 'Rezeptvorschläge'),
            _buildListTile(title: 'Ist das noch gut?'),
            _buildListTile(title: 'Savior Score'),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required String title}) {
    return ListTile(
      dense: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(8, 83, 59, 1.0),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //onTap: () {
      //  Navigator.pop(context);
      //},
    );
  }
}
