import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/business_logic_layer/cubit/inventur_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/inventur_artikel_states.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/models/Inventur.dart';
import 'package:hf/data_layer/models/inventur_artikel.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class InventurArtikelScreen extends StatefulWidget {
  final Inventur? currInventur;

  const InventurArtikelScreen(
      {Key? key, this.currInventur})
      : super(key: key);

  @override
  _InventurArtikelScreenState createState() =>
      _InventurArtikelScreenState();
}

class _InventurArtikelScreenState extends State<InventurArtikelScreen> {
  //For calling APIs:
  late List<InventurArtikel> allInventurArtikelList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<InventurArtikelCubit>(context)
          .getAllInventurArtikels(
        inventurId: widget.currInventur!.id!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPro(
        addBackButton: true,
        title: widget.currInventur!.id,
      ),
      body: BlocBuilder<InventurArtikelCubit, InventurArtikelState>(
        builder: (context, teilInventurArtikelState) {

          if (teilInventurArtikelState is InventurArtikelLoadedState) {
            allInventurArtikelList =
                (teilInventurArtikelState).teilInventurArtikels;

            double totalMenge  = 0;
            double totalVK = 0;

            allInventurArtikelList.forEach((element) {
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
                            BlocProvider.of<InventurArtikelCubit>(context)
                                .updateInventurStatus(
                                widget.currInventur?.id)
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
                  child: allInventurArtikelList.length <= 0
                      ? Text("keine Daten")
                      : ListView.builder(
                    itemCount: allInventurArtikelList.length,
                    itemBuilder: (context, index) {
                      return _InventurViewerItem(
                        currentInventurArtikel:
                        allInventurArtikelList[index],
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
                      widget.currInventur,type: "Inventur",)),));
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
class _InventurViewerItem extends StatelessWidget {
  final InventurArtikel currentInventurArtikel;
  final Function? onTap;

  const _InventurViewerItem(
      {Key? key, required this.currentInventurArtikel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentInventurArtikel.artikel.toString(),
          currentInventurArtikel.ean.toString(),
          currentInventurArtikel.vk.toString(),
          currentInventurArtikel.menge.toString(),
          '0'
        ],
      ),
    );
  }
}
