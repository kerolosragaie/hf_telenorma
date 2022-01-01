import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/models/inventurs.dart';
import 'package:hf/data_layer/models/products.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'package:hf/data_layer/models/teil_inventur.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class TeilInventurArtikelScreen extends StatefulWidget {
  final TeilInventur? currTeilInventur;
  final Shop? currentShop;

  const TeilInventurArtikelScreen(
      {Key? key, this.currTeilInventur, this.currentShop})
      : super(key: key);

  @override
  _TeilInventurArtikelScreenState createState() =>
      _TeilInventurArtikelScreenState();
}

class _TeilInventurArtikelScreenState extends State<TeilInventurArtikelScreen> {
//For calling APIs:
  late List<Products> currentShopProducts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPro(
        addBackButton: true,
        title: widget.currTeilInventur!.id,
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
                //TODO: !NEXT Something wrong with model:
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
