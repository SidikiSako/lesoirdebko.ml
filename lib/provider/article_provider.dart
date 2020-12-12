import 'package:flutter/material.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/models/category.dart';
import 'package:lesoirdebko/services/wordpress_service.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _articleList = new List();
  List<Article> _actualitesRegionalesList = new List();
  List<Article> _actualitesnationnaleList = new List();
  bool _canFetchActualiteRegionale = true;
  bool _canFetchActualiteNationnale = true;
  WordpressService _wordpressService = WordpressService();

  //getters
  List<Article> get articleList => _articleList;
  List<Article> get actualitesRegionalesList => _actualitesRegionalesList;
  List<Article> get actualitesnationnaleList => _actualitesnationnaleList;
  bool get canFetchActualiteNationnale => _canFetchActualiteNationnale;
  bool get canFetchActualiteRegionale => _canFetchActualiteRegionale;

  //function
  fetchLastArticles() async {
    List<Article> articles = await _wordpressService.fetchLastTenArticles();
    for (Article article in articles) {
      _articleList.add(article);
    }
    notifyListeners();
  }

  Future<void> fetchCategoryArticles(Category category) async {
    String url;

    switch (category.id) {
      case 7:
        {
          url =
              'http://lesoirdebko.ml/wp-json/wp/v2/posts?_embed&categories=${category.id}&offset=${_actualitesRegionalesList.length}&_fields=id,modified_gmt,excerpt,title,content,_links';
        }
        break;
      case 6:
        {
          url =
              'http://lesoirdebko.ml/wp-json/wp/v2/posts?_embed&categories=${category.id}&offset=${_actualitesnationnaleList.length}&_fields=id,modified_gmt,excerpt,title,content,_links';
        }
        break;

      default:
        {}
    }

    // List<Article> articles = await _wordpressService.fetchCategoryArticles(
    //   category.id,
    // );
    List<Article> articles = await _wordpressService.fetchCategoryArticles(url);

    if (category.id == 7) {
      if (articles.length > 0) {
        _canFetchActualiteRegionale = true;
        for (Article article in articles) {
          _actualitesRegionalesList.add(article);
        }
      } else {
        _canFetchActualiteRegionale = false;
      }
    } else if (category.id == 6) {
      if (articles.length > 0) {
        _canFetchActualiteNationnale = true;
        for (Article article in articles) {
          _actualitesnationnaleList.add(article);
        }
      } else {
        _canFetchActualiteNationnale = false;
      }
    }
    notifyListeners();
  }
}
