import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/provider/article_provider.dart';
import 'package:lesoirdebko/utils/reformat_title.dart';
import 'package:lesoirdebko/widget/grid_article.dart';
import 'package:lesoirdebko/widget/main_article.dart';
import 'package:lesoirdebko/widget/most_recent_articles.dart';
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
    await articleProvider.fetchLastArticles();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var articleProvider = Provider.of<ArticleProvider>(context);
    List<Article> articles = articleProvider.articleList;

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
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Dernières nouvelles',
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  //height: 800,
                  height: 190,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Votre journal est maintenant disponible en version numérique et imprimé !',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 270,
                  color: Colors.green,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 300,
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        color: Color(0xFF0A6CBA),
                      ),
                      Positioned(
                        top: 10,
                        left: 15,
                        child: Text(
                          'ACTUALITÉS REGIONALES',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 15,
                        child: Container(
                          height: 230,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 160,
                                        width: 152,
                                        color: Colors.purple,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 152,
                                        child: Text(
                                          'Titre de mon article : flutter , le nouveau framework à la mode',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
