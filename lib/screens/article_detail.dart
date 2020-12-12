import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/utils/reformat_title.dart';

class ArticleDetailsPage extends StatelessWidget {
  final Article article;
  ArticleDetailsPage({this.article});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Html(
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
          ),
          Container(
            height: 270,
            width: double.infinity,
            child: article.imageUrl == null
                ? Container(
                    height: 270,
                    width: double.infinity,
                    child: Image.asset(
                      'images/subscribe.png',
                      fit: BoxFit.cover,
                    ),
                  )
                : CachedNetworkImage(
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
                        height: 270,
                        width: double.infinity,
                        child: Image.asset(
                          'images/no_image.png',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Html(
              data: article.content,
              style: {
                "html": Style(
                  fontFamily: GoogleFonts.montserrat(
                          //fontWeight: FontWeight.w700,
                          )
                      .fontFamily,
                  fontSize: FontSize(18),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
