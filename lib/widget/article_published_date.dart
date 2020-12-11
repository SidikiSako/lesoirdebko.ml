import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesoirdebko/utils/reformat_date.dart';

class ArticlePublishDate extends StatelessWidget {
  final String date;
  ArticlePublishDate({this.date});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          size: 15,
        ),
        SizedBox(width: 5),
        Text(
          'Publié le ${reformatDate(date)}',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF575757),
          ),
        ),
      ],
    );
  }
}
