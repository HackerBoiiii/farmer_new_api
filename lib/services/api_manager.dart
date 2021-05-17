import 'dart:convert';
import 'package:farmer_api_second/constants/strings.dart';
import 'package:http/http.dart' as http;
import '../models/newsInfo.dart';


// ignore: camel_case_types
  class API_Manager {
    Future<Welcome> getNews() async {
      var client = http.Client();
      var newsModel;

      try {
        var response = await client.get(Uri.parse(Strings.news_url));
        if (response.statusCode == 200) {
          var jsonString = response.body;
          print(response.body);
          var jsonMap = json.decode(jsonString);

          newsModel = Welcome.fromJson(jsonMap);
        }
      } catch (Exception) {
        return newsModel;
      }

      return newsModel;
    }
  }
