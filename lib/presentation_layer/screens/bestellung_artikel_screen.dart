
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/business_logic_layer/cubit/bestellung_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/bestellung_artikel_state.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/models/bestellung.dart';
import 'package:hf/data_layer/models/bestellung_artikel.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/widgets/appbar_pro.dart';
import 'package:hf/presentation_layer/widgets/table_body.dart';
import 'package:hf/presentation_layer/widgets/table_header.dart';
import 'package:hf/presentation_layer/widgets/textbutton_pro.dart';
class BestellungArtikelScreen extends StatefulWidget {
  final Bestellung? currBestellung;
  const BestellungArtikelScreen({Key? key, this.currBestellung}) : super(key: key);

  @override
  _BestellungArtikelScreenState createState() => _BestellungArtikelScreenState();
}

class _BestellungArtikelScreenState extends State<BestellungArtikelScreen> {

  late List<BestellungArtikel> allBestellungArtikelList;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<BestellungArtikelCubit>(context)
          .getAllBestellungArtikels(
        bestellungId: widget.currBestellung!.id!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPro(
        addBackButton: true,
        title: widget.currBestellung!.id,
      ),
      body: BlocBuilder<BestellungArtikelCubit, BestellungArtikelState>(
        builder: (context, teilInventurArtikelState){
          if (teilInventurArtikelState is BestellungArtikelLoadedState) {
            allBestellungArtikelList =
                (teilInventurArtikelState).bestellungArtikel;

            double totalMenge = 0;
            double totalVK = 0;

            allBestellungArtikelList.forEach((element) {
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
                        width: 100,
                        child: TextButtonPro(
                          title: "HF IMPORT",
                          onPressed: () {
                            BlocProvider.of<BestellungArtikelCubit>(context)
                                .updateBestellungStatus(
                                widget.currBestellung?.id)
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
                  child: allBestellungArtikelList.length <= 0
                      ? Text("keine Daten")
                      : ListView.builder(
                    itemCount: allBestellungArtikelList.length,
                    itemBuilder: (context, index) {
                      return _BestellungViewerItem(
                        currentBestellungArtikel:
                        allBestellungArtikelList[index],
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
                        widget.currBestellung,type: "bestellung",)),));
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
        }

      ),
    );
  }
}

//Single item of table:
class _BestellungViewerItem extends StatelessWidget {
  final BestellungArtikel currentBestellungArtikel;
  final Function? onTap;

  const _BestellungViewerItem(
      {Key? key, required this.currentBestellungArtikel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentBestellungArtikel.artikel.toString(),
          currentBestellungArtikel.ean.toString(),
          currentBestellungArtikel.vk.toString(),
          currentBestellungArtikel.menge.toString(),
          '0'
        ],
      ),
    );
  }
}
