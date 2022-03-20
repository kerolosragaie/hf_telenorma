import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/inventur_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/inventur_cubit.dart';
import 'package:hf/business_logic_layer/cubit/inventur_state.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/api/inventur_artikel_services.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/models/Inventur.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'package:hf/data_layer/repository/inventur_artikel_repository.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/screens/inventur_artikel_screen.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

import 'inventur_artikel_screen.dart';

class InventurScreen extends StatefulWidget {
  const InventurScreen({Key? key}) : super(key: key);
  @override
  _InventurScreenState createState() => _InventurScreenState();
}

class _InventurScreenState extends State<InventurScreen> {
  //varaibles to change between aktiv page and archiv page
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.aktiv;

  //For calling APIs:
  late List<Inventur> allInventurs;
  late List<Inventur> archivInventurs;
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
      BlocProvider.of<InventurCubit>(context).getAllInventur();
      BlocProvider.of<InventurCubit>(context).getArchiveAllInventur();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
        title: "Inventur",
      ),
      body: BlocBuilder<InventurCubit, InventurState>(
          builder: (context, InventurState) {
        allInventurs = BlocProvider.of<InventurCubit>(context).allInventursList;
        ;
        print('allInventurs $allInventurs');

        archivInventurs =
            BlocProvider.of<InventurCubit>(context).archivInventursList;
        if (allInventurs.isNotEmpty) {
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
            title: "Neue Inventur",
            onPressed: () {
              TextEditingController kommentarController =
                  TextEditingController();
              Shop currentDropDownValue = allShops[0];
              showNeueInventur(
                context: context,
                toastMessgeNein:
                    "Sie müssen zuerst die Bestände im Kassensystem auf Null setzen",
                shopsList: allShops,
                onSelectInventurStarten: () {
                  Map<String, dynamic> data = {
                    'shop_id': currentDropDownValue.id,
                    'bemerkung': kommentarController.text,
                    'kasse_id': currentDropDownValue.kasseId
                  };
                  BlocProvider.of<InventurCubit>(context)
                      .addInventur(data)
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
                                    type: 'Inventur',
                                  ),
                                ))).then((value) {
                      BlocProvider.of<InventurCubit>(context).getAllInventur();
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
            "Erstel Datum",
            "Benutzer",
          ],
        ),
        //Table body:
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          child: ListView.builder(
            itemCount: allInventurs.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  if (shopState is ShopLoadedState) {
                    allShops = (shopState).shopsList;

                    return _InventurItem(
                      currentInventur: allInventurs[index],
                      currentShop: _getShopData(allInventurs[index], allShops),
                      onTap: () {
                        InventurArtikelRepository inventurArtikelRepository =
                            InventurArtikelRepository(
                                InventurArtikelServices());

                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<InventurArtikelCubit>(
                                  create: (context) => InventurArtikelCubit(
                                      inventurArtikelRepository),
                                ),
                              ],
                              child: InventurArtikelScreen(
                                currInventur: allInventurs[index],
                              )),
                        ))
                            .then((value) {
                          BlocProvider.of<ShopCubit>(context).getAllShops();
                          BlocProvider.of<InventurCubit>(context)
                              .getAllInventur();
                          BlocProvider.of<InventurCubit>(context)
                              .getArchiveAllInventur();
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
            "Erstel Datum",
            "Benutzer",
          ],
        ),
        //Table body:
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          child: ListView.builder(
            itemCount: archivInventurs.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  print('archivInvedanturs $archivInventurs');
                  if (archivInventurs.isNotEmpty) {
                    return _InventurItem(
                      currentInventur: archivInventurs[index],
                      currentShop:
                          _getShopData(archivInventurs[index], allShops),
                      onTap: () {
                        InventurArtikelRepository inventurArtikelRepository =
                            InventurArtikelRepository(
                                InventurArtikelServices());

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<InventurArtikelCubit>(
                                  create: (context) => InventurArtikelCubit(
                                      inventurArtikelRepository),
                                ),
                              ],
                              child: InventurArtikelScreen(
                                currInventur: archivInventurs[index],
                                // currentShop: _getShopData(
                                //     archivInventurs[index], allShops),
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

  //? This function to get shop data of single  inventur:
  Shop _getShopData(Inventur _currInventur, List<Shop> _allShops) {
    return _allShops.firstWhere((shop) =>
        shop.id == _currInventur.shopId.toString() &&
        shop.kasseId == _currInventur.kasseId.toString());
  }
}

//Single item of table:
class _InventurItem extends StatelessWidget {
  final Inventur currentInventur;
  final Shop currentShop;
  final Function? onTap;
  const _InventurItem({
    Key? key,
    required this.currentInventur,
    required this.currentShop,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentInventur.id,
          currentShop.title ?? "Null",
          currentInventur.created.toString(), // modified To created
          "44"
        ],
      ),
    );
  }
}
