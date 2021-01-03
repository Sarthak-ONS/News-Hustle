import 'dart:convert';
import 'package:http/http.dart' as http;
import 'NewsModel.dart';

List<NewsData> news = [];

class NewsGetter {
  static const url =
      "http://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=27421b8e03c54d4f9f18b581d04f1709";

  Future<List<NewsData>> getNews() async {
    var response = await http.get(url);
    var decoded = jsonDecode(response.body);
    var loopOver = decoded['articles'];
    print(loopOver.length);
    for (var item in loopOver) {
      NewsData n = NewsData(item['url'], item['urlToImage'], item['title'],
          item['publishedAt'], item['author']);
      news.add(n);
    }
    return news;
  }
}
