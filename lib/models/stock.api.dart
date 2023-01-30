import 'dart:convert';
import 'package:little_savior_v1/models/stock.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class StockApi {
  static Future<List<Stock>> getStocks() async {
    var uri = Uri.http("medsrv.informatik.hs-fulda.de", "/lsbackend/api/v1/stocks", {'format': 'json'});
    final response = await http.get(uri);
    List<dynamic> dataList = jsonDecode(response.body);
    print(response.body);
    return Stock.stockFromSnapshot(dataList);
  }
}