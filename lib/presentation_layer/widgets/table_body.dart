import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';

//Table body in row:
class TableBody extends StatelessWidget {
  final List<dynamic> data;
  const TableBody({Key? key, required this.data}) : super(key: key);

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
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(data.length, (index) {
          return SizedBox(
            height: 30,
            width: 70,
            child: Center(
              child: Text(
                data[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      color: HexColor("424D51"),
                      fontSize: 13,
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
