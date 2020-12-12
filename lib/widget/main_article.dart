import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/screens/article_detail.dart';
import 'package:lesoirdebko/utils/reformat_date.dart';
import 'package:lesoirdebko/utils/reformat_title.dart';
import 'package:html/dom.dart' as dom;

class MainArticle extends StatelessWidget {
  final Article article;
  MainArticle({this.article});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ArticleDetailsPage(
            article: article,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.red,
              child: Text(
                'À LA UNE',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 25),
              ),
            ),
            Html(
              data: reformatTitle(article.title),
              style: {
                "html": Style(
                  fontFamily:
                      GoogleFonts.montserrat(fontWeight: FontWeight.w700)
                          .fontFamily,
                  fontSize: FontSize(25),
                ),
              },
            ),
            // Html(
            //   data: article.excerpt,
            //   style: {
            //     "html": Style(
            //         fontFamily: GoogleFonts.poppins(
            //           color: Colors.black,
            //         ).fontFamily,
            //         fontSize: FontSize(18),
            //         padding: EdgeInsets.symmetric(horizontal: 0)),
            //   },
            // ),
            // Row(
            //   children: [
            //     Icon(Icons.timer),
            //     SizedBox(width: 5),
            //     Text(
            //       'Publié le ${reformatDate(article.date)}',
            //       style: GoogleFonts.poppins(
            //         fontSize: 14,
            //         fontWeight: FontWeight.bold,
            //         color: Color(0xFF575757),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) {
                        print('Error in CachedNetworkImage with url = $url');

                        return Container(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset(
                            'images/no_image.png',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    )

                    // Image.network(
                    //   article.imageUrl,
                    //   fit: BoxFit.cover,
                    // ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// create customRender for asset images
Widget getTextCustomRender(RenderContext context, Widget parsedChild,
    Map<String, String> attributes, dom.Element element) {
  print(attributes);
  //return new Image.asset("assets/drawables/${attributes["src"]}");
}
