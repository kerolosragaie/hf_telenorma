import 'package:flutter/material.dart';

class HfLogo extends StatelessWidget {
  const HfLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 53, left: 70, right: 70),
      child: const Image(
        height: 65.44,
        width: 235,
        image: AssetImage('assets/logo_HF.jpg'),
      ),
    );
  }
}
