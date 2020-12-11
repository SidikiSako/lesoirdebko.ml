import 'package:flutter/material.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/services/wordpress_service.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _articleList = new List();
  WordpressService _wordpressService = WordpressService();
  //getters
  List<Article> get articleList => _articleList;

  //function
  fetchLastArticles() async {
    List<Article> articles = await _wordpressService.fetchLastTenArticles();
    for (Article article in articles) {
      _articleList.add(article);
    }
    notifyListeners();
  }
}
