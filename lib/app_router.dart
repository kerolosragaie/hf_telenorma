import 'package:flutter/material.dart';
import 'package:hf/business_logic_layer/cubit/bestellung_cubit.dart';
import 'package:hf/business_logic_layer/cubit/inventur_cubit.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/business_logic_layer/cubit/teil_inventur_cubit.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/business_logic_layer/cubit/wareneingang_cubit.dart';
import 'package:hf/data_layer/api/bestellung_services.dart';
import 'package:hf/data_layer/api/inventur_services.dart';
import 'package:hf/data_layer/api/shop_services.dart';
import 'package:hf/data_layer/api/teil_inventur_services.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/api/wareneingang_services.dart';
import 'package:hf/data_layer/repository/shop_repository.dart';
import 'package:hf/data_layer/repository/teil_inventur_repository.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/data_layer/repository/wareneingang_repository.dart';
import 'package:hf/presentation_layer/screens/bestellung_screen.dart';
import 'package:hf/presentation_layer/screens/inventur_screen.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/screens/teilinventur_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/presentation_layer/screens/teilinventur_artikel_screen.dart';
import 'package:hf/presentation_layer/screens/umlagerung_screen.dart';
import 'package:hf/presentation_layer/screens/ware_screen.dart';
import 'package:hf/presentation_layer/screens/wareneingang_screen.dart';
import 'business_logic_layer/cubit/umlagerung_cubit.dart';
import 'constants/strings.dart';
import 'data_layer/api/umlagerung_services.dart';
import 'data_layer/repository/Inventur_repository.dart';
import 'data_layer/repository/bestellung_repository.dart';
import 'data_layer/repository/umlagerung_repository.dart';
import 'presentation_layer/screens/pages.dart';

class AppRouter {
  //For APIs:
  late ShopRepository shopsRepository;
  late ShopCubit shopsCubit;

  late TeilInventurRepository teilInventurRepository;
  late TeilInventurCubit teilInventurCubit;

  late InventurRepository inventurRepository;
  late InventurCubit inventurCubit;

  late WareneingangCubit wareneingangCubit;
  late WareneingangRepository wareneingangRepository;

  late BestellungCubit bestellungCubit;
  late BestellungRepository bestellungRepository;

  late UmlagerungCubit umlagerungCubit;
  late UmlagerungRepository umlagerungRepository;
  late WareRepository wareRepository;

  AppRouter() {
    shopsRepository = ShopRepository(ShopServices());

    teilInventurRepository = TeilInventurRepository(TeilInventurServices());

    inventurRepository = InventurRepository(InventurServices());

    wareneingangRepository = WareneingangRepository(WareneingangServices());

    bestellungRepository = BestellungRepository(BestellungServices());

    umlagerungRepository = UmlagerungRepository(UmlagerungServices());

    wareRepository = WareRepository(WareServices());
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
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<ShopCubit>(
                      create: (context) => ShopCubit(shopsRepository),
                    ),
                    BlocProvider<InventurCubit>(
                        create: (context) => InventurCubit(inventurRepository))
                  ],
                  child: const InventurScreen(),
                ));
      case wareneingangScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<WareneingangCubit>(
            create: (context) => WareneingangCubit(wareneingangRepository),
            child: const WareneingangScreen(),
          ),
        );
      case bestellungScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<BestellungCubit>(
            create: (context) => BestellungCubit(bestellungRepository),
            child: const BestellungScreen(),
          ),
        );
      case umlagerungScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<UmlagerungCubit>(
            create: (context) => UmlagerungCubit(umlagerungRepository),
            child: const UmlagerungScreen(),
          ),
        );
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
      case warenScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<WareCubit>(
            create: (context) => WareCubit(wareRepository),
            child: const WareScreen(),
          ),
        );
    }
    return null;
  }
}
