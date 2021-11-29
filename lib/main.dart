import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/app_router.dart';
import 'package:hf/presentation_layer/screens/splash_screen.dart';

void main() {

  runApp(HF(appRouter: AppRouter(),));
  //SystemUiOverlayStyle is for Upper icons (wifi,etc...)

  /*
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  );
  */


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
      initialRoute: '/',
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
