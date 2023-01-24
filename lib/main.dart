import 'package:flutter/material.dart';
import 'package:little_savior_v1/screens/menue.dart';
import 'package:little_savior_v1/screens/myrecipes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyRecipes(),
    );
  }
}
