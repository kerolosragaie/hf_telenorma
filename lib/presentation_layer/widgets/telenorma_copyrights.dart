import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class TelenormaCopyrights extends StatelessWidget {
  const TelenormaCopyrights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Powered by",
          style: TextStyle(fontSize: 14),
        ),
        Text(
          "TELENORMA",
          style: TextStyle(fontSize: 14, color: HexColor("#F89921")),
        ),
      ],
    );
  }
}
