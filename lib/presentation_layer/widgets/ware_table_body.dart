import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';

//Table body in row:
class WareTableBody extends StatelessWidget {
  final List<dynamic> data;
  const WareTableBody({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: HexColor("E2E2E2")),
          bottom: BorderSide(width: 1.0, color: HexColor("E2E2E2")),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(data.length - 2, (index) {
            return SizedBox(
              height: 60,
              width: index == 0 ? 140 : 60,
              child: Center(
                child: Column(
                  crossAxisAlignment: index == 0
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data[index].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (index == 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('EAN : ${data[4]}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey)),
                          Text('${data[5]}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey))
                        ],
                      )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
