import 'package:flutter/material.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/screens/start_screen.dart';
import 'constants/strings.dart';
import 'presentation_layer/screens/pages.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case licenseKeyScreen:
        return MaterialPageRoute(builder: (_) => const LicenseKeyScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case startScreen:
        return MaterialPageRoute(builder: (_) => const StartScreen());
      case scannerScreen:
        return MaterialPageRoute(builder: (_) => const ScannerScreen());
    }
  }
}
