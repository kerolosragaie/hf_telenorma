import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/business_logic_layer/cubit/umlagerung_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/umlagerung_cubit.dart';
import 'package:hf/business_logic_layer/cubit/umlagerung_state.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/api/umlagerung_artikel_services.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'package:hf/data_layer/models/umlagerung.dart';
import 'package:hf/data_layer/repository/umlagerung_artikel_repository.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/screens/umlagerung_artikel_screen.dart';
import 'package:hf/presentation_layer/widgets/appbar_pro.dart';
import 'package:hf/presentation_layer/widgets/display_dialog2.dart';
import 'package:hf/presentation_layer/widgets/table_body.dart';
import 'package:hf/presentation_layer/widgets/table_header.dart';
import 'package:hf/presentation_layer/widgets/textbutton_pro.dart';
import 'package:hf/presentation_layer/widgets/togglebutton_pro.dart';

class UmlagerungScreen extends StatefulWidget {
  const UmlagerungScreen({Key? key}) : super(key: key);

  @override
  _UmlagerungScreenState createState() => _UmlagerungScreenState();
}

class _UmlagerungScreenState extends State<UmlagerungScreen> {
  //varaibles to change between aktiv page and archiv page
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.aktiv;

  //For calling APIs:
  late List<Umlagerung> allUmlagerungs;
  late List<Umlagerung> archivUmlagerungs;
  late List<Shop> allShops;

  void moveToAktiv() {
    formKey.currentState!.reset();
    setState(() {
      _formType = FormType.aktiv;
    });
  }

  //To switch between forms:
  void moveToArchiv() {
    formKey.currentState!.reset();
    setState(() {
      _formType = FormType.archiv;
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<ShopCubit>(context).getAllShops();
      BlocProvider.of<UmlagerungCubit>(context).getAllUmlagerung();
      BlocProvider.of<UmlagerungCubit>(context).getArchiveAllUmlagerung();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
        title: "Umlagerung",
      ),
      body: BlocBuilder<UmlagerungCubit, UmlagerungState>(
          builder: (context, UmlagerungState) {
        allUmlagerungs =
            BlocProvider.of<UmlagerungCubit>(context).allUmlagerungsList;
        archivUmlagerungs =
            BlocProvider.of<UmlagerungCubit>(context).archivUmlagerungsList;
        if (allUmlagerungs.isNotEmpty) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: ToggleButtonPro(
                    onTapAktiv: () {
                      moveToAktiv();
                    },
                    onTapArchiv: () {
                      moveToArchiv();
                    },
                  ),
                ),
                Column(
                  children: forms(),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Loading..."),
          );
        }
      }),
    );
  }

  List<Widget> forms() {
    if (_formType == FormType.aktiv) {
      return [
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: TextButtonPro(
            title: "UMLAGERUNG ERSTELLEN",
            onPressed: () {
              TextEditingController kommentarController =
                  TextEditingController();
              Shop currentDropDownValue = allShops[0];
              Shop currentDropDownValue2 = allShops[1];
              showNeue(
                context: context,
                toastMessgeNein:
                    "Sie müssen zuerst die Bestände im Kassensystem auf Null setzen",
                shopsList: allShops,
                onSelectInventurStarten: () {
                  Map<String, dynamic> data = {
                    'von_shop_id': currentDropDownValue.id,
                    'zu_shop_id': currentDropDownValue2.id,
                    'bemerkung': kommentarController.text,
                    'kasse_id': currentDropDownValue.kasseId,
                  };

                  BlocProvider.of<UmlagerungCubit>(context)
                      .addUmlagerung(data)
                      .then((value) {
                    print(value);
                    WareRepository wareRepository =
                        WareRepository(WareServices());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      WareCubit(wareRepository),
                                  child: ScannerScreen(
                                    currItem: value,
                                    type: 'umlagerung',
                                  ),
                                ))).then((value) {
                      BlocProvider.of<UmlagerungCubit>(context)
                          .getAllUmlagerung();
                    });
                  });
                },
                kommentarController: kommentarController,
                onChangeValue2: (val) {
                  setState(() {
                    currentDropDownValue2 = val;
                  });
                },
                onChangeValue: (val) {
                  setState(() {
                    currentDropDownValue = val;
                  });
                },
              );
            },
          ),
        ),
        //Table header:
        const TableHeader(
          titles: [
            "ID",
            "Shop(von)",
            "Shop(zu)",
            "Erstel Datum",
            "Benutzer",
          ],
        ),
        //Table body:
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          child: ListView.builder(
            itemCount: allUmlagerungs.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  if (shopState is ShopLoadedState) {
                    allShops = (shopState).shopsList;

                    return _UmlagerungItem(
                      currentUmlagerung: allUmlagerungs[index],
                      currentShopvon:
                          _getShopData(allUmlagerungs[index], allShops),
                      currentShopzu:
                          _getShopData(allUmlagerungs[index], allShops),
                      onTap: () {
                        UmlagerungArtikelRepository
                            umlagerungArtikelRepository =
                            UmlagerungArtikelRepository(
                                UmlagerungArtikelServices());
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<UmlagerungArtikelCubit>(
                                  create: (context) => UmlagerungArtikelCubit(
                                      umlagerungArtikelRepository),
                                ),
                              ],
                              child: UmlagerungArtikelScreen(
                                currUmlagerung: allUmlagerungs[index],
                                // currentShop: _getShopData(
                                //     allWareneingangs[index], allShops),
                              )),
                        ))
                            .then((value) {
                          BlocProvider.of<ShopCubit>(context).getAllShops();
                          BlocProvider.of<UmlagerungCubit>(context)
                              .getAllUmlagerung();
                          BlocProvider.of<UmlagerungCubit>(context)
                              .getArchiveAllUmlagerung();
                        });
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  }
                },
              );
            },
          ),
        ),
      ];
    } else {
      return [
        //Table header:
        const TableHeader(
          titles: [
            "ID",
            "Shop(von)",
            "Shop(zu)",
            "Erstel Datum",
            "Benutzer",
          ],
        ),
        //Table body:
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          child: ListView.builder(
            itemCount: archivUmlagerungs.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  print('archivTeilInvedanturs $archivUmlagerungs');
                  if (archivUmlagerungs.isNotEmpty) {
                    return _UmlagerungItem(
                      currentUmlagerung: archivUmlagerungs[index],
                      currentShopvon:
                          _getShopData(archivUmlagerungs[index], allShops),
                      currentShopzu:
                          _getShopData(archivUmlagerungs[index], allShops),
                      onTap: () {
                        UmlagerungArtikelRepository
                            umlagerungArtikelRepository =
                            UmlagerungArtikelRepository(
                                UmlagerungArtikelServices());

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<UmlagerungArtikelCubit>(
                                  create: (context) => UmlagerungArtikelCubit(
                                      umlagerungArtikelRepository),
                                ),
                              ],
                              child: UmlagerungArtikelScreen(
                                currUmlagerung: archivUmlagerungs[index],
                                // currentShop: _getShopData(
                                //     archivWareneingangs[index], allShops),
                              )),
                        ));
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  }
                },
              );
            },
          ),
        ),
        //TODO: what to add here?
      ];
    }
  }

  //? This function to get shop data of single teil inventur:
  Shop _getShopData(Umlagerung _currUmlagerung, List<Shop> _allShops) {
    return _allShops.firstWhere((element) =>
        element.id == _currUmlagerung.vonShopId.toString() &&
        element.kasseId == _currUmlagerung.kasseId.toString());
  }
}

//Single item of table:
class _UmlagerungItem extends StatelessWidget {
  final Umlagerung currentUmlagerung;
  final Shop currentShopvon;
  final Shop currentShopzu;
  final Function? onTap;
  const _UmlagerungItem({
    Key? key,
    required this.currentUmlagerung,
    required this.currentShopvon,
    required this.currentShopzu,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentUmlagerung.id,
          currentShopvon.title ?? "Null",
          currentShopzu.title ?? "Null",
          currentUmlagerung.created.toString(), // modified To created
          "44"
        ],
      ),
    );
  }
}
