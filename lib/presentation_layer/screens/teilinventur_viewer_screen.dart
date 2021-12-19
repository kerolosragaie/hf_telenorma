import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/models/inventurs.dart';
import 'package:hf/data_layer/models/products.dart';
import 'package:hf/data_layer/models/shops.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class TeilInventurViewerScreen extends StatefulWidget {
  final Shops currentShop;
  const TeilInventurViewerScreen({Key? key, required this.currentShop})
      : super(key: key);

  @override
  _TeilInventurViewerScreenState createState() =>
      _TeilInventurViewerScreenState();
}

class _TeilInventurViewerScreenState extends State<TeilInventurViewerScreen> {
//For calling APIs:
  late List<Products> currentShopProducts;

  @override
  void initState() {
    super.initState();
    //TODO:how to connect Shops with products API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPro(
        addBackButton: true,
        title: widget.currentShop.id,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 43,
                  width: 150,
                  child: TextButtonPro(
                    title: "SPEICHERN",
                    onPressed: () {},
                  ),
                ),
                Column(
                  children: const [
                    Text("Menge: 0"),
                    Text("VK: 0 E"),
                  ],
                ),
                SizedBox(
                  height: 43,
                  width: 150,
                  child: TextButtonPro(
                    title: "HF IMPORT",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          //Table header here:
          const TableHeader(
            titles: [
              "Artikel",
              "EAN",
              "VK",
              "Menge Kasse",
              "Menge",
            ],
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                //Something wrong with model:
                return _TeilInventurViewerItem(
                  currentInventur: Inventurs(
                    id: "${index + 2}",
                    shopId: "42515",
                    modifiedAt: "16.9.2021",
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(scannerScreen);
              },
              child: Container(
                color: HexColor("F89720"),
                child: const Center(
                  child: Image(
                    height: 65,
                    width: 65,
                    image: AssetImage("assets/icons/scan_button.png"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Single item of table:
class _TeilInventurViewerItem extends StatelessWidget {
  final Inventurs currentInventur;
  final Function? onTap;
  const _TeilInventurViewerItem(
      {Key? key, required this.currentInventur, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: const TableBody(
        data: [
          "null",
          "null",
          "null",
          "null",
          "null",
        ],
      ),
    );
  }
}
