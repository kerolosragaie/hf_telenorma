import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    List<MenuItem> menuItems = [
      MenuItem(
        imageLocation: "assets/icons/scanner.png",
        text: "Teil-Inventur",
        addBackground: true,
        onTap: () {
          Navigator.of(context).pushNamed(teilInventurScreen);
        },
      ),
      MenuItem(
        imageLocation: "assets/icons/inventory_icon.png",
        text: "Inventur",
        addBackground: true,
        onTap: () {},
      ),
      MenuItem(
        imageLocation: "assets/icons/wareneingang_icon.png",
        text: "Wareneingang",
        addBackground: true,
        onTap: () {},
      ),
      MenuItem(
        imageLocation: "assets/icons/bestellung_icon.png",
        text: "Bestellung",
        addBackground: true,
        onTap: () {},
      ),
      MenuItem(
        imageLocation: "assets/icons/shop2shop_icon.png",
        text: "Umlagerung",
        onTap: () {},
      ),
      MenuItem(
        imageLocation: "assets/icons/artikel_icon.png",
        text: "Waren",
        onTap: () {},
      ),
    ];
    return Scaffold(
      appBar: AppBarPro(
        actions: [
          //TODO: add functionallty here:
          IconButton(
            iconSize: 24,
            icon: Icon(
              Icons.shop,
              color: HexColor("424D51"),
            ),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 24,
            icon: Icon(
              Icons.logout,
              color: HexColor("424D51"),
            ),
            onPressed: () {},
          ),
        ],
      ),
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
          ],
        ),
      ),
    );
  }
}
