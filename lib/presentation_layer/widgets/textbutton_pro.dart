import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class TextButtonPro extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color? buttonColor;
  const TextButtonPro(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      width: 329,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(HexColor("F7941D"))),
        child: Center(
          child: AutoSizeText(
            title.toUpperCase(),
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              color: buttonColor ?? HexColor("FFFFFF"),
            ),
          ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
