import 'package:flutter/material.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/data_layer/api/shops_services.dart';
import 'package:hf/data_layer/models/inventurs.dart';
import 'package:hf/data_layer/repository/shops_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/screens/teilinventur_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/presentation_layer/screens/teilinventur_viewer_screen.dart';
import 'constants/strings.dart';
import 'presentation_layer/screens/pages.dart';

class AppRouter {
  //For APIs:
  late ShopsRepository shopsRepository;
  late ShopsCubit shopsCubit;

  AppRouter() {
    shopsRepository = ShopsRepository(ShopServices());
    shopsCubit = ShopsCubit(shopsRepository);
  }

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
      case teilInventurScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => ShopsCubit(shopsRepository),
            child: const TeilInventurScreen(),
          ),
        );
      case teilInventurViewerScreen:
        //TODO: pass value from TeilInventurScreen:
        return MaterialPageRoute(
          builder: (_) => TeilInventurViewerScreen(
            currentInventur: Inventurs(),
          ),
        );
    }
  }
}
