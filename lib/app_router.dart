import 'package:flutter/material.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/business_logic_layer/cubit/teil_inventur_cubit.dart';
import 'package:hf/data_layer/api/shop_services.dart';
import 'package:hf/data_layer/api/teil_inventur_services.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'package:hf/data_layer/repository/shop_repository.dart';
import 'package:hf/data_layer/repository/teil_inventur_repository.dart';
import 'package:hf/presentation_layer/screens/inventur_screen.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/screens/teilinventur_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/presentation_layer/screens/teilinventur_artikel_screen.dart';
import 'constants/strings.dart';
import 'presentation_layer/screens/pages.dart';

class AppRouter {
  //For APIs:
  late ShopRepository shopsRepository;
  late ShopCubit shopsCubit;

  late TeilInventurRepository teilInventurRepository;
  late TeilInventurCubit teilInventurCubit;

  AppRouter() {
    shopsRepository = ShopRepository(ShopServices());
    shopsCubit = ShopCubit(shopsRepository);

    teilInventurRepository = TeilInventurRepository(TeilInventurServices());
    teilInventurCubit = TeilInventurCubit(teilInventurRepository);
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
      case inventurScreen:
        return MaterialPageRoute(builder: (_) => const InventurScreen());
      case teilInventurScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ShopCubit>(
                create: (context) => ShopCubit(shopsRepository),
              ),
              BlocProvider<TeilInventurCubit>(
                create: (context) => TeilInventurCubit(teilInventurRepository),
              ),
            ],
            child: const TeilInventurScreen(),
          ),
        );
      case teilInventurViewerScreen:
        return MaterialPageRoute(
          builder: (_) => TeilInventurArtikelScreen(),
        );
    }
  }
}
