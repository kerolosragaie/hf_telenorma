import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/business_logic_layer/cubit/teil_inventur_artikel_cubit.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'package:hf/data_layer/models/teil_inventur.dart';
import 'package:hf/data_layer/models/teil_inventur_artikel.dart';
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
  late List<TeilInventurArtikel> allTeilInventurArtikelList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<TeilInventurArtikelCubit>(context)
          .getAllTeilInventurArtikels(
        inventurId: widget.currTeilInventur!.id!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPro(
        addBackButton: true,
        title: widget.currTeilInventur!.id,
      ),
      body: BlocBuilder<TeilInventurArtikelCubit, TeilInventurArtikelState>(
        builder: (context, teilInventurArtikelState) {
          if (teilInventurArtikelState is TeilInventurArtikelLoadedState) {
            allTeilInventurArtikelList =
                (teilInventurArtikelState).teilInventurArtikels;
            return Column(
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
                  child: allTeilInventurArtikelList.length <= 0
                      ? Text("No data found!")
                      : ListView.builder(
                          itemCount: allTeilInventurArtikelList.length,
                          itemBuilder: (context, index) {
                            return _TeilInventurViewerItem(
                              currentTeilInventurArtikel:
                                  allTeilInventurArtikelList[index],
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
            );
          } else {
            return const Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}

//Single item of table:
class _TeilInventurViewerItem extends StatelessWidget {
  final TeilInventurArtikel currentTeilInventurArtikel;
  final Function? onTap;

  const _TeilInventurViewerItem(
      {Key? key, required this.currentTeilInventurArtikel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentTeilInventurArtikel.artikel.toString(),
          currentTeilInventurArtikel.ean.toString(),
          currentTeilInventurArtikel.vk.toString(),
          currentTeilInventurArtikel.kasse.toString(),
          currentTeilInventurArtikel.menge.toString(),
        ],
      ),
    );
  }
}
