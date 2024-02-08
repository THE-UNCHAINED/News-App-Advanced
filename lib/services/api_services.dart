import 'dart:convert';

import 'package:first_app/model/categoryNews.dart';
import 'package:first_app/model/new_headLine.dart';
import 'package:http/http.dart'as http;

class ApiService {


  Future<NewHeadLine> fetchNewsHeadline(String channelName) async {
    final response =
    await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=35d4f6c0966f492a9bf6f9c4c182cba5'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return NewHeadLine.fromJson(data);
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<CategoryNews> fetchCategoryNews(String category) async {
    final response =
    await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=de&category=$category&apiKey=35d4f6c0966f492a9bf6f9c4c182cba5'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(response.body.toString());
      return CategoryNews.fromJson(data);
    } else {
      throw Exception("Failed to load data");
    }
  }
}