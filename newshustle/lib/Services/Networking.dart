import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/NewsModel.dart';

List<NewsData> news = [];

class NewsGetter {
  String country;
  String category;

  Future<List<NewsData>> getNews() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String country =
          prefs.get("Country") == null ? 'in' : prefs.get("Country");
      String category =
          prefs.get("Category") == null ? 'sports' : prefs.get("Category");

      print("/////////////////////////");
      print(country);
      print(category);
      print("////////////////////////////");
      var url =
          "http://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=27421b8e03c54d4f9f18b581d04f1709";
      var response = await http.get(url);
      var decoded = jsonDecode(response.body);
      var loopOver = decoded['articles'];
     // print(loopOver[0]);

      for (var item in loopOver) {
        NewsData n = NewsData(item['url'], item['urlToImage'], item['title'],
            item['publishedAt'], item['author'],item['content']);
            //print(item['description']);
        news.add(n);
      }
      //print(news[0].description);
      return news;
    } catch (e) {
      return [];
    }
  }
}
