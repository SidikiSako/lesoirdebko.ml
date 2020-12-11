import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/utils/reformat_date.dart';
import 'package:lesoirdebko/utils/reformat_title.dart';

class ArticleInGridView extends StatelessWidget {
  final Article article;
  ArticleInGridView({this.article});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Card(
        child: Column(
          children: [
            Container(
              height: 120,
              width: 190,
              child: Image.network(
                article.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.timer,
                  size: 15,
                ),
                SizedBox(width: 5),
                Text(
                  'Publié le ${reformatDate(article.date)}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575757),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 90,
              width: 190,
              child: Text(
                reformatTitle(article.title),
                style: GoogleFonts.podkova(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
