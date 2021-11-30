import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/app_router.dart';
import 'package:hf/constants/strings.dart';

void main() {
  //SystemUiOverlayStyle is for Upper icons (wifi,etc...)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  );
  runApp(HF(
    appRouter: AppRouter(),
  ));
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
