import 'package:flutter/material.dart';
import 'package:hf/splash_screen.dart';

void main() {
  runApp(const HF());
}

class HF extends StatelessWidget {
  const HF({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
