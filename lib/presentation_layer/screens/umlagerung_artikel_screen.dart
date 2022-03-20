
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/business_logic_layer/cubit/umlagerung_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/umlagerung_artikel_state.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/models/umlagerung.dart';
import 'package:hf/data_layer/models/umlagerung_artikel.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/widgets/appbar_pro.dart';
import 'package:hf/presentation_layer/widgets/table_body.dart';
import 'package:hf/presentation_layer/widgets/table_header.dart';
import 'package:hf/presentation_layer/widgets/textbutton_pro.dart';
class UmlagerungArtikelScreen extends StatefulWidget {
  final Umlagerung? currUmlagerung;
  const UmlagerungArtikelScreen({Key? key, this.currUmlagerung}) : super(key: key);

  @override
  _UmlagerungArtikelScreenState createState() => _UmlagerungArtikelScreenState();
}

class _UmlagerungArtikelScreenState extends State<UmlagerungArtikelScreen> {

  late List<UmlagerungArtikel> allUmlagerungArtikelList;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<UmlagerungArtikelCubit>(context)
          .getAllUmlagerungArtikels(
        umlagerungId: widget.currUmlagerung!.id!,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPro(
        addBackButton: true,
        title: widget.currUmlagerung!.id,
      ),
      body: BlocBuilder<UmlagerungArtikelCubit, UmlagerungArtikelState>(
          builder: (context, teilInventurArtikelState){
            if (teilInventurArtikelState is UmlagerungArtikelLoadedState) {
              allUmlagerungArtikelList =
                  (teilInventurArtikelState).umlagerungArtikels;

              double totalMenge = 0;
              double totalVK = 0;

              allUmlagerungArtikelList.forEach((element) {
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
                          width: 100,
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
                              BlocProvider.of<UmlagerungArtikelCubit>(context)
                                  .updateUmlagerungStatus(
                                  widget.currUmlagerung?.id)
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
                    child: allUmlagerungArtikelList.length <= 0
                        ? Text("keine Daten")
                        : ListView.builder(
                      itemCount: allUmlagerungArtikelList.length,
                      itemBuilder: (context, index) {
                        return _UmlagerungViewerItem(
                          currentUmlagerungArtikel:
                          allUmlagerungArtikelList[index],
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
                          widget.currUmlagerung,type: "umlagerung",)),));
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
class _UmlagerungViewerItem extends StatelessWidget {
  final UmlagerungArtikel currentUmlagerungArtikel;
  final Function? onTap;

  const _UmlagerungViewerItem(
      {Key? key, required this.currentUmlagerungArtikel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentUmlagerungArtikel.artikel.toString(),
          currentUmlagerungArtikel.ean.toString(),
          currentUmlagerungArtikel.vk.toString(),
          currentUmlagerungArtikel.menge.toString(),
          '0'
        ],
      ),
    );
  }
}

