import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/screens/article_detail.dart';
import 'package:lesoirdebko/utils/reformat_title.dart';
import 'package:lesoirdebko/widget/article_published_date.dart';

class MostRecentArticle extends StatelessWidget {
  final Article article;
  MostRecentArticle({this.article});
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
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
                          height: double.infinity,
                          width: 140,
                          child: Image.asset(
                            'images/no_image.png',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    )),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //padding: EdgeInsets.only(left: 5),
                    width: 210,
                    child: Text(
                      reformatTitle(article.title),
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 210,
                    child: Text(
                      article.excerpt
                          .replaceAll('<p>', '')
                          .replaceAll('</p>', '')
                          .replaceAll('[&hellip;]', ''),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    // child: Html(
                    //   data: article.excerpt,
                    //   style: {
                    //     "html": Style(
                    //       fontFamily: GoogleFonts.poppins(
                    //         color: Colors.black,
                    //       ).fontFamily,
                    //       fontSize: FontSize(14),
                    //       // overflow: TextOverflow.ellipsis,
                    //       //                       maxLines: 3,
                    //     ),
                    //   },
                    // ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ArticlePublishDate(
                    date: article.date,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
