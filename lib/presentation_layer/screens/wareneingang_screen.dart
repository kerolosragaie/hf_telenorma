import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/business_logic_layer/cubit/wareneingang_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/wareneingang_cubit.dart';
import 'package:hf/business_logic_layer/cubit/wareneingang_state.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/api/wareneingang_artikel_services.dart';
import 'package:hf/data_layer/models/Wareneingang.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/data_layer/repository/wareneingang_artikel_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/screens/wareneingang_artikel_screen.dart';
import 'package:hf/presentation_layer/widgets/appbar_pro.dart';
import 'package:hf/presentation_layer/widgets/dispaly_dialog.dart';
import 'package:hf/presentation_layer/widgets/table_body.dart';
import 'package:hf/presentation_layer/widgets/table_header.dart';
import 'package:hf/presentation_layer/widgets/textbutton_pro.dart';
import 'package:hf/presentation_layer/widgets/togglebutton_pro.dart';

class WareneingangScreen extends StatefulWidget {
  const WareneingangScreen({Key? key}) : super(key: key);

  @override
  _WareneingangScreenState createState() => _WareneingangScreenState();
}

class _WareneingangScreenState extends State<WareneingangScreen> {
  //varaibles to change between aktiv page and archiv page
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.aktiv;

  //For calling APIs:
  late List<Wareneingang> allWareneingangs;
  late List<Wareneingang> archivWareneingangs;
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
      BlocProvider.of<WareneingangCubit>(context).getAllWareneingang();
      BlocProvider.of<WareneingangCubit>(context).getArchiveAllWareneingang();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
        title: "Wareneingang",
      ),
      body: BlocBuilder<WareneingangCubit, WareneingangState>(
          builder: (context, wareneingangState) {
            allWareneingangs = BlocProvider.of<WareneingangCubit>(context).allWareneingangsList;
            archivWareneingangs = BlocProvider.of<WareneingangCubit>(context).archivWareneingangsList;
            if (allWareneingangs.isNotEmpty) {
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
          }
          ),
    );
  }

  List<Widget> forms() {
    if (_formType == FormType.aktiv) {
      return [
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: TextButtonPro(
            title: "Neue Teil-Inventur",
            onPressed: () {

              TextEditingController kommentarController =
              TextEditingController();
              Shop currentDropDownValue = allShops[0];
              showNeueInventur(
                context: context,
                toastMessgeNein: "Sie müssen zuerst die Bestände im Kassensystem auf Null setzen",
                shopsList: allShops,
                onSelectInventurStarten: () {
                  Map<String,dynamic> data = {
                    'shop_id':currentDropDownValue.id,
                    'bemerkung' : kommentarController.text,
                    'kasse_id' : currentDropDownValue.kasseId
                  };
                  BlocProvider.of<WareneingangCubit>(context).addWareneingang(data).then((value){

                    WareRepository wareRepository = WareRepository(WareServices());
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        BlocProvider(create: (context)=>WareCubit(wareRepository)
                          ,child:  ScannerScreen(currItem: value,type: 'wareneingang',),)
                    )).then((value) {
                      BlocProvider.of<WareneingangCubit>(context).getAllWareneingang();
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
            itemCount: allWareneingangs.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  if (shopState is ShopLoadedState) {
                    allShops = (shopState).shopsList;

                    return _WareneingangItem(
                      currentWareneingang: allWareneingangs[index],
                      currentShop: _getShopData(allWareneingangs[index], allShops),
                      onTap: () {
                        WareneingangArtikelRepository
                        wareneingangArtikelRepository =
                        WareneingangArtikelRepository(
                            WareneingangArtikelServices());

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<WareneingangArtikelCubit>(
                                  create: (context) => WareneingangArtikelCubit(
                                      wareneingangArtikelRepository),
                                ),
                              ],
                              child: WareneingangArtikelScreen(
                                currWareneingang: allWareneingangs[index],
                                // currentShop: _getShopData(
                                //     allWareneingangs[index], allShops),
                              )),
                        )).then((value) {
                          BlocProvider.of<ShopCubit>(context).getAllShops();
                          BlocProvider.of<WareneingangCubit>(context).getAllWareneingang();
                          BlocProvider.of<WareneingangCubit>(context).getArchiveAllWareneingang();
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
            itemCount: archivWareneingangs.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  print('archivTeilInvedanturs $archivWareneingangs');
                  if (archivWareneingangs.isNotEmpty) {
                    return _WareneingangItem(
                      currentWareneingang: archivWareneingangs[index],
                      currentShop: _getShopData(archivWareneingangs[index], allShops),
                      onTap: () {
                        WareneingangArtikelRepository
                        wareneingangArtikelRepository =
                        WareneingangArtikelRepository(
                            WareneingangArtikelServices());

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<WareneingangArtikelCubit>(
                                  create: (context) => WareneingangArtikelCubit(
                                      wareneingangArtikelRepository),
                                ),
                              ],
                              child: WareneingangArtikelScreen(
                                currWareneingang: archivWareneingangs[index],
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
  Shop _getShopData(Wareneingang _currWareneingang, List<Shop> _allShops) {

    return _allShops.firstWhere((element) => element.id == _currWareneingang.shopId.toString()
        && element.kasseId == _currWareneingang.kasseId.toString());

  }
}

//Single item of table:
class _WareneingangItem extends StatelessWidget {
  final Wareneingang currentWareneingang;
  final Shop currentShop;
  final Function? onTap;
  const _WareneingangItem({
    Key? key,
    required this.currentWareneingang,
    required this.currentShop,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentWareneingang.id,
          currentShop.title ?? "Null",
          currentWareneingang.created.toString(), // modified To created
          "44"
        ],
      ),
    );
  }
}
