import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/bestellung_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/bestellung_cubit.dart';
import 'package:hf/business_logic_layer/cubit/bestellung_state.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/api/bestellung_artikel_services.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/models/bestellung.dart';
import 'package:hf/data_layer/models/kassen.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'package:hf/data_layer/repository/bestellung_artikel_repository.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/widgets/bestellung_dialog.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

import 'bestellung_artikel_screen.dart';

class BestellungScreen extends StatefulWidget {
  const BestellungScreen({Key? key}) : super(key: key);

  @override
  _BestellungScreenState createState() => _BestellungScreenState();
}

class _BestellungScreenState extends State<BestellungScreen> {
  //varaibles to change between aktiv page and archiv page
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.aktiv;

  //For calling APIs:
  late List<Bestellung> allBestellung;
  late List<Bestellung> archivBestellungs;
  late List<Shop> allShops;
  late List<Kassen> kassenList;

  void moveToAktiv() {
    formKey.currentState!.reset();
    setState(() {
      _formType = FormType.aktiv;
    });
  }

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
      BlocProvider.of<BestellungCubit>(context).getAllBestellung();
      BlocProvider.of<BestellungCubit>(context).getArchiveAllBestellung();
      BlocProvider.of<BestellungCubit>(context).getAllKassen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
        title: "Bestellung",
      ),
      body: BlocBuilder<BestellungCubit, BestellungState>(
          builder: (context, bestellungState) {
        allBestellung =
            BlocProvider.of<BestellungCubit>(context).allBestellungList;
        archivBestellungs =
            BlocProvider.of<BestellungCubit>(context).archivBestellungList;
        kassenList = BlocProvider.of<BestellungCubit>(context).KassenList;
        if (allBestellung.isNotEmpty) {
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
                  children: forms()!,
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

  List<Widget>? forms() {
    if (_formType == FormType.aktiv) {
      return [
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: TextButtonPro(
            title: 'Neue Bestellung',
            onPressed: () {
              TextEditingController kommentarController =
                  TextEditingController();
              Shop currentDropDownValue = allShops[0];
              showNeueBestellung(
                context: context,
                KassenList: kassenList,
                toastMessgeNein:
                    "Sie müssen zuerst die Bestände im Kassensystem auf Null setzen",
                shopsList: allShops,
                onSelectInventurStarten: () {
                  Map<String, dynamic> data = {
                    'shop_id': currentDropDownValue.id,
                    'bemerkung': kommentarController.text,
                    'kasse_id': currentDropDownValue.kasseId
                  };
                  BlocProvider.of<BestellungCubit>(context)
                      .addBestellung(data)
                      .then((value) {
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
                                    type: 'bestellung',
                                  ),
                                ))).then((value) {
                      BlocProvider.of<BestellungCubit>(context)
                          .getAllBestellung();
                    });
                  });
                },
                kommentarController: kommentarController,
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
            "Shop",
            "Kassen",
            "Erstel Datum",
            "Benutzer",
          ],
        ),
        //Table body:
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          child: ListView.builder(
            itemCount: allBestellung.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  if (shopState is ShopLoadedState) {
                    allShops = (shopState).shopsList;

                    return _BestellungItem(
                      currentBestellung: allBestellung[index],
                      currentShop: _getShopData(allBestellung[index], allShops),
                      onTap: () {
                        BestellungArtikelRepository
                            bestellungArtikelRepository =
                            BestellungArtikelRepository(
                                BestellungArtikelServices());

                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<BestellungArtikelCubit>(
                                  create: (context) => BestellungArtikelCubit(
                                      bestellungArtikelRepository),
                                ),
                              ],
                              child: BestellungArtikelScreen(
                                currBestellung: allBestellung[index],
                                // currentShop: _getShopData(
                                //     allWareneingangs[index], allShops),
                              )),
                        ))
                            .then((value) {
                          BlocProvider.of<ShopCubit>(context).getAllShops();
                          BlocProvider.of<BestellungCubit>(context)
                              .getAllBestellung();
                          BlocProvider.of<BestellungCubit>(context)
                              .getArchiveAllBestellung();
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
            "Shop",
            "Kassen",
            "Erstel Datum",
            "Benutzer",
          ],
        ),
        //Table body:
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          child: ListView.builder(
            itemCount: archivBestellungs.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  print('archivBestellungs $archivBestellungs');
                  if (archivBestellungs.isNotEmpty) {
                    return _BestellungItem(
                      currentBestellung: archivBestellungs[index],
                      currentShop:
                          _getShopData(archivBestellungs[index], allShops),
                      onTap: () {
                        BestellungArtikelRepository
                            bestellungsArtikelRepository =
                            BestellungArtikelRepository(
                                BestellungArtikelServices());

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<BestellungArtikelCubit>(
                                  create: (context) => BestellungArtikelCubit(
                                      bestellungsArtikelRepository),
                                ),
                              ],
                              child: BestellungArtikelScreen(
                                currBestellung: archivBestellungs[index],
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
  Shop _getShopData(Bestellung _currBestellung, List<Shop> _allShops) {
    return _allShops.firstWhere((element) =>
        element.id == _currBestellung.shopId.toString() &&
        element.kasseId == _currBestellung.kasseId.toString());
  }
}

//Single item of table:
class _BestellungItem extends StatelessWidget {
  final Bestellung currentBestellung;
  final Shop currentShop;
  final Function? onTap;
  const _BestellungItem({
    Key? key,
    required this.currentBestellung,
    required this.currentShop,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentBestellung.id,
          currentShop.title ?? "Null",
          currentBestellung.kassenId.toString(), // Kassen
          currentBestellung.created.toString(), // modified To created
          "44"
        ],
      ),
    );
  }
}
