import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiRequestHelper {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    // print("Place Response: ${response.body}");
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodedData = jsonDecode(jsonData);
        return decodedData;
      } else {
        return "failed";
      }
    } catch (error) {
      return "failed";
    }
  }

}