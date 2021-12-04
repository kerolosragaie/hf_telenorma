import 'package:flutter/material.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  List<MenuItem> menuItems = [
    MenuItem(
      imageLocation: "assets/icons/scanner.png",
      text: "Teil-Inventur",
      onTap: () {},
    ),
    MenuItem(
      imageLocation: "assets/icons/inventory_icon.png",
      text: "Inventur",
      onTap: () {},
    ),
    MenuItem(
      imageLocation: "assets/icons/wareneingang_icon.png",
      text: "Wareneingang",
      onTap: () {},
    ),
    MenuItem(
      imageLocation: "assets/icons/bestellung_icon.png",
      text: "Bestellung",
      onTap: () {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HfLogo(),
            const Slogan(
              text: "Hallo Alex",
              fontSize: 23,
              margin: EdgeInsets.only(top: 40.56, left: 51, right: 52),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 73,
                left: 35,
                right: 49,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 0.2,
                    mainAxisSpacing: 1),
                itemCount: menuItems.length,
                itemBuilder: (ctx, index) {
                  return menuItems[index];
                },
              ),
            ),
            const TelenormaCopyrights(),
          ],
        ),
      ),
    );
  }
}
