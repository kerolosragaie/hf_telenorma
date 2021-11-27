import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hf/presentation_layer/screens/login_screen.dart';
import 'package:hf/presentation_layer/screens/pages.dart';

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
      splash: Image(image: AssetImage('assets/logo_HF.jpg'),),
      /*SvgPicture.asset(
        'assets/hf_logo.svg',
        width: 80,
        height: 80,
        color: HexColor("FF9800"),
      ),*/
      nextScreen: const LoginScreen(),
    );
  }
}