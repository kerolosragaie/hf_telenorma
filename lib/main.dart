import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/splash_screen.dart';

void main() {
  //SystemUiOverlayStyle is for Upper icons (wifi,etc...)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  );
  runApp(const HF());
}

class HF extends StatelessWidget {
  const HF({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HF',
      theme: ThemeData(
          //primarySwatch: Colors.blue,
          primaryColor: HexColor("FF9800")),
      home: const SplashScreen(),
    );
  }
}
