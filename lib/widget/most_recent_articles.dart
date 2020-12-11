import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/utils/reformat_title.dart';
import 'package:lesoirdebko/widget/article_published_date.dart';

class MostRecentArticle extends StatelessWidget {
  final Article article;
  MostRecentArticle({this.article});
  @override
  Widget build(BuildContext context) {
    return Card(
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
                child: Image.network(
                  article.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
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
                    style: GoogleFonts.podkova(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 210,
                  child: Text(
                    article.excerpt
                        .replaceAll('<p>', '')
                        .replaceAll('</p>', '')
                        .replaceAll('[&hellip;]', ''),
                    style: GoogleFonts.poppins(
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
    );
    ;
  }
}
