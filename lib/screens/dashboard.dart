import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Simple Flutter Page'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Läuft diese Woche ab',style:TextStyle(color: Color.fromRGBO(8, 83, 59, 1.0))),

              SizedBox(height: 25,),
              Text("Hallo")



            ],
          ),
        ),
      ),
    );
  }

}


