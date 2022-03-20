import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/business_logic_layer/cubit/wareneingang_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/wareneingang_artikel_state.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/models/Wareneingang.dart';
import 'package:hf/data_layer/models/wareneingang_artikel.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class WareneingangArtikelScreen extends StatefulWidget {
  final Wareneingang? currWareneingang;

  const WareneingangArtikelScreen(
      {Key? key, this.currWareneingang})
      : super(key: key);

  @override
  _WareneingangArtikelScreenState createState() =>
      _WareneingangArtikelScreenState();
}

class _WareneingangArtikelScreenState extends State<WareneingangArtikelScreen> {
  //For calling APIs:
  late List<WareneingangArtikel> allWareneingangArtikelList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<WareneingangArtikelCubit>(context)
          .getAllWareneingangArtikels(
        wareneingangId: widget.currWareneingang!.id!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPro(
        addBackButton: true,
        title: widget.currWareneingang!.id,
      ),
      body: BlocBuilder<WareneingangArtikelCubit, WareneingangArtikelState>(
        builder: (context, teilInventurArtikelState) {

          if (teilInventurArtikelState is WareneingangArtikelLoadedState) {
            allWareneingangArtikelList =
                (teilInventurArtikelState).teilInventurArtikels;

            double totalMenge  = 0;
            double totalVK = 0;

            allWareneingangArtikelList.forEach((element) {
              totalMenge = totalMenge + double.parse(element.menge.toString());
              totalVK = totalVK + double.parse(element.vk.toString());
            });

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
                        children:  [
                          Text("Menge: $totalMenge"),
                          Text("VK: $totalVK E"),
                        ],
                      ),
                      SizedBox(
                        height: 43,
                        width: 150,
                        child: TextButtonPro(
                          title: "HF IMPORT",
                          onPressed: () {
                            BlocProvider.of<WareneingangArtikelCubit>(context)
                                .updateWareneingangStatus(
                                widget.currWareneingang?.id)
                                .then((value) {
                              Navigator.pop(context, true);
                            });
                          },
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
                    "Menge",
                    "HF"
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: allWareneingangArtikelList.length <= 0
                      ? Text("keine Daten")
                      : ListView.builder(
                    itemCount: allWareneingangArtikelList.length,
                    itemBuilder: (context, index) {
                      return _WareneingangViewerItem(
                        currentWareneingangArtikel:
                        allWareneingangArtikelList[index],
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      WareRepository wareRepository = WareRepository(WareServices());

                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>BlocProvider(create: (context)=>
                          WareCubit(wareRepository),child: ScannerScreen(
                        currItem:
                        widget.currWareneingang,type: "wareneingang",)),));
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
class _WareneingangViewerItem extends StatelessWidget {
  final WareneingangArtikel currentWareneingangArtikel;
  final Function? onTap;

  const _WareneingangViewerItem(
      {Key? key, required this.currentWareneingangArtikel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentWareneingangArtikel.artikel.toString(),
          currentWareneingangArtikel.ean.toString(),
          currentWareneingangArtikel.vk.toString(),
          currentWareneingangArtikel.menge.toString(),
          '0'
        ],
      ),
    );
  }
}
