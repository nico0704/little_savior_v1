import 'dart:convert';
import 'package:little_savior_v1/models/unit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class UnitApi {
  static Future<List<Unit>> getUnits() async {
    var uri = Uri.https("medsrv.informatik.hs-fulda.de", "/lsbackend/api/v1/units", {'format': 'json'});
    final response = await http.get(uri);
    List<dynamic> dataList = jsonDecode(response.body);
    //print(response.body);
    return Unit.unitFromSnapshot(dataList);
  }
}