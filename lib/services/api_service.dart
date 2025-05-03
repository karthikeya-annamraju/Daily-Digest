import 'dart:convert';

import 'package:daily_digest/models/article_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

  List<ArticleModel> news = [];

  Future<void> fetchNewsFromApi() async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3dd5fdf498ba48e294791ec690f6d5de";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description']!= null) {
          ArticleModel article = ArticleModel(
              author: element["author"],
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
          );
          news.add(article);
        }
      });
    }
  }
}