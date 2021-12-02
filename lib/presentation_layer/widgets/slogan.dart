import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';

class Slogan extends StatelessWidget {
  final String text;
  final double fontSize;
  final EdgeInsetsGeometry? margin;
  const Slogan(
      {Key? key, required this.text, this.margin, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 54.56, left: 61, right: 61),
      child: AutoSizeText(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
              color: HexColor("424D51"),
              fontSize: fontSize,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
