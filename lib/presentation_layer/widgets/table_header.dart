import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';

//Titles in column of the table:
class TableHeader extends StatelessWidget {
  final List<String> titles;
  const TableHeader({Key? key, required this.titles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: HexColor("E2E2E2")),
          bottom: BorderSide(width: 1.0, color: HexColor("E2E2E2")),
        ),
        color: HexColor("F7941D"),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(titles.length, (index) {
          return SizedBox(
            height: 30,
            width: 70,
            child: Center(
              child: Text(
                titles[index],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      color: HexColor("424D51"),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
