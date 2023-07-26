
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:planeta_uz/data/api/api_utils.dart';
import 'package:planeta_uz/data/model/universal.dart';
import 'package:planeta_uz/data/model/wtf_model.dart';

class ApiProvider {
   Future<UniversalData> fetchWtf() async {
    String url = 'https://jsonplaceholder.typicode.com/albums';

    Uri uri = Uri.parse(url);

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> jsonData = wtfModelFromJson(response.body);
        

        return UniversalData(data: jsonData);
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalData(
          error: "Internet bilan ulanishda XATOLIK sodir bo'ldi!!");
    } on FormatException {
      return UniversalData(error: "Format Error!");
    } catch (err) {
      debugPrint("ERROR: $err. ERROR TYPE: ${err.runtimeType}");
      return UniversalData(error: err.toString());
    }
  }
}
