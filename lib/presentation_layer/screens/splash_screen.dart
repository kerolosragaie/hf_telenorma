import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hf/presentation_layer/screens/pages.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      duration: 2800,
      splash: const Image(
        width: 250,
        height: 250,
        image: AssetImage('assets/logo_HF.jpg'),
      ),
      /*SvgPicture.asset(
        'assets/hf_logo.svg',
        width: 80,
        height: 80,
        color: HexColor("FF9800"),
      ),*/
      nextScreen: const StartScreen(),
    );
  }
}
