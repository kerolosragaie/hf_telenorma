import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {
  final String imageLocation;
  final String text;
  final EdgeInsetsGeometry? margin;
  final Function onTap;
  final bool addBackground;
  const MenuItem(
      {Key? key,
      required this.imageLocation,
      required this.text,
      this.margin,
      required this.onTap,
      this.addBackground = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          SizedBox(
            height: 88,
            width: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                addBackground
                    ? const Image(
                        image: AssetImage("assets/icons/background_icon.png"),
                      )
                    : const SizedBox.shrink(),
                Image(
                  image: AssetImage(imageLocation),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 19.05),
            height: 30,
            width: 120,
            child: AutoSizeText(
              text.toUpperCase(),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: HexColor("424D51"),
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
