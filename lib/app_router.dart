import 'package:flutter/material.dart';
import 'package:hf/presentation_layer/screens/license_key.dart';
import 'package:hf/presentation_layer/screens/splash_screen.dart';

import 'constants/strings.dart';


class AppRouter{
  Route? generateRoute(RouteSettings settings){
    switch (settings.name){
      case splashScreen:
        return MaterialPageRoute(builder: (_)=> SplashScreen());
      case licenseKeyScreen:
        return MaterialPageRoute(builder: (_)=> LicenseKeyScreen());
    }
  }


}