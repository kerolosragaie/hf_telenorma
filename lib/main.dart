import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/app_router.dart';
import 'package:hf/business_logic_layer/bloc_observer.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/custom_bloc_provider.dart';

void main() {
  //SystemUiOverlayStyle is for Upper icons (wifi,etc...)
  // بيتأكد ان كل حاجة هنا في الميثود خلصت وبعدين يفتح ال App
  WidgetsFlutterBinding.ensureInitialized();
  MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  );
  runApp(const Core());
}

class HF extends StatelessWidget {
  final AppRouter appRouter;

  const HF({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HF',
      theme: ThemeData(
          //primarySwatch: Colors.blue,
          primaryColor: HexColor("FF9800")),
      initialRoute: splashScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
