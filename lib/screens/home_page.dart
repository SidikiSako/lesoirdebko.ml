import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/provider/article_provider.dart';
import 'package:lesoirdebko/utils/constant.dart';
import 'package:lesoirdebko/utils/reformat_title.dart';
import 'package:lesoirdebko/widget/category_widget.dart';
import 'package:lesoirdebko/widget/grid_article.dart';
import 'package:lesoirdebko/widget/main_article.dart';
import 'package:lesoirdebko/widget/most_recent_articles.dart';
import 'package:lesoirdebko/widget/subscribe.dart';
import 'package:provider/provider.dart';

//http://lesoirdebko.ml/wp-json//wp/v2/posts?_embed&_fields=id,modified_gmt,excerpt,title,content,_links
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  @override
  void initState() {
    getArticles();
    super.initState();
  }

  void getArticles() async {
    var articleProvider = Provider.of<ArticleProvider>(context, listen: false);
    //fetch les premiers articles de chaque categorie
    await articleProvider.fetchLastArticles();
    await articleProvider.fetchCategoryArticles(kActualitesRegionaleCategory);
    await articleProvider.fetchCategoryArticles(kActualitesNationnaleCategory);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var articleProvider = Provider.of<ArticleProvider>(context);
    List<Article> articles = articleProvider.articleList;
    // List<Article> actualiteRegionalesList =
    //     articleProvider.actualitesRegionalesList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Le Soir de Bamako',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                MainArticle(article: articleProvider.articleList.first),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xFF5751E3),
                  margin: const EdgeInsets.only(left: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    'Dernières nouvelles',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      //fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  //height: 800,
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return MostRecentArticle(
                          article: articles[index],
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                SubscribeWidget(),
                SizedBox(
                  height: 20,
                ),
                CategoryWidget(
                  category: kActualitesRegionaleCategory,
                ),
                CategoryWidget(
                  category: kActualitesNationnaleCategory,
                ),
              ],
            ),
    );
  }
}
