import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckBoxTilePro extends StatelessWidget {
  final String title;
  final Function onChanged;
  final bool value;

  const CheckBoxTilePro(
      {Key? key,
      required this.title,
      required this.onChanged,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: (val) => onChanged(val)),
        const SizedBox(
          width: 8,
        ),
        AutoSizeText(title,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                  fontSize: 12,
                  color: HexColor("#000000"),
                  fontWeight: FontWeight.w100),
            )),
      ],
    );
  }
}

/* 
Row(
      children: [
        Expanded(
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(title,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      fontSize: 12,
                      color: HexColor("#000000"),
                      fontWeight: FontWeight.w100),
                )),
            value: value,
            onChanged: (bool? value) => onChanged(value),
          ),
        ),
      ],
    ); */