import 'dart:convert';
import 'package:lesoirdebko/models/article.dart';
import 'package:http/http.dart' as http;

class WordpressService {
  //params

  //functions
  //get last 10 articles from wordpress
  Future<List<Article>> fetchLastTenArticles() async {
    List<Article> articles = new List();
    String url =
        'http://lesoirdebko.ml/wp-json//wp/v2/posts?_embed&_fields=id,modified_gmt,excerpt,title,content,_links';
    print('fetching articles...');
    http.Response response = await http.get(url);
    //check if request is OK
    if (response.statusCode == 200) {
      print('DONE fetching articles...');
      List<dynamic> body = jsonDecode(response.body);
      body.forEach((item) {
        print(item);
        articles.add(Article.fromJson(item));
      });
      //Map<String, String> head = response.headers;

    } else {
      print('Something went wrong with statusCode = ${response.statusCode}');
    }
    return articles;
  }
}
