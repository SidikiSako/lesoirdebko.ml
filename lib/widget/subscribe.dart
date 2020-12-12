import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscribeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Votre journal est maintenant disponible en version numérique et imprimé !',
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: 270,
          child: Image.asset(
            'images/subscribe.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
