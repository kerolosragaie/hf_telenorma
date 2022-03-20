import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/business_logic_layer/cubit/teil_inventur_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/teil_inventur_cubit.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/api/teil_inventur_artikel_services.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'package:hf/data_layer/models/teil_inventur.dart';
import 'package:hf/data_layer/repository/teil_inventur_artikel_repository.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/presentation_layer/screens/scanner_screen.dart';
import 'package:hf/presentation_layer/screens/teilinventur_artikel_screen.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class TeilInventurScreen extends StatefulWidget {
  const TeilInventurScreen({Key? key}) : super(key: key);

  @override
  _TeilInventurScreenState createState() => _TeilInventurScreenState();
}

class _TeilInventurScreenState extends State<TeilInventurScreen> {
  //varaibles to change between aktiv page and archiv page
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.aktiv;

  //For calling APIs:
  late List<TeilInventur> allTeilInventurs;
  late List<TeilInventur> archivTeilInventurs;
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
      BlocProvider.of<TeilInventurCubit>(context).getAllTeilInventur();
      BlocProvider.of<TeilInventurCubit>(context).getArchiveAllTeilInventur();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
        title: "Teil-Inventur",
      ),
      body: BlocBuilder<TeilInventurCubit, TeilInventurState>(
          builder: (context, teilInventurState) {
            allTeilInventurs = BlocProvider.of<TeilInventurCubit>(context).allTeilInventursList;;
            archivTeilInventurs = BlocProvider.of<TeilInventurCubit>(context).archivTeilInventursList;
            if (allTeilInventurs.isNotEmpty) {
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
                   BlocProvider.of<TeilInventurCubit>(context).addTeilInventur(data).then((value){

                    WareRepository wareRepository = WareRepository(WareServices());
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>
                         BlocProvider(create: (context)=>WareCubit(wareRepository)
                       ,child:  ScannerScreen(currItem: value,type: 'teil-inventur',),))).then((value) {
                       BlocProvider.of<TeilInventurCubit>(context).getAllTeilInventur();
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
            itemCount: allTeilInventurs.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  if (shopState is ShopLoadedState) {
                    allShops = (shopState).shopsList;

                    return _TeilInventurItem(
                      currentTeilInventur: allTeilInventurs[index],
                      currentShop: _getShopData(allTeilInventurs[index], allShops),
                      onTap: () {
                        TeilInventurArtikelRepository
                            teilInventurArtikelRepository =
                            TeilInventurArtikelRepository(
                                TeilInventurArtikelServices());

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<TeilInventurArtikelCubit>(
                                  create: (context) => TeilInventurArtikelCubit(
                                      teilInventurArtikelRepository),
                                ),
                              ],
                              child: TeilInventurArtikelScreen(
                                currTeilInventur: allTeilInventurs[index],
                                // currentShop: _getShopData(
                                //     allTeilInventurs[index], allShops),
                              )),
                        )).then((value) {
                          BlocProvider.of<ShopCubit>(context).getAllShops();
                          BlocProvider.of<TeilInventurCubit>(context).getAllTeilInventur();
                          BlocProvider.of<TeilInventurCubit>(context).getArchiveAllTeilInventur();
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
            itemCount: archivTeilInventurs.length,
            itemBuilder: (context, index) {
              return BlocBuilder<ShopCubit, ShopState>(
                builder: (context, shopState) {
                  print('archivTeilInvedanturs $archivTeilInventurs');
                  if (archivTeilInventurs.isNotEmpty) {
                    return _TeilInventurItem(
                      currentTeilInventur: archivTeilInventurs[index],
                      currentShop: _getShopData(archivTeilInventurs[index], allShops),
                      onTap: () {
                        TeilInventurArtikelRepository
                        teilInventurArtikelRepository =
                        TeilInventurArtikelRepository(
                            TeilInventurArtikelServices());

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider<TeilInventurArtikelCubit>(
                                  create: (context) => TeilInventurArtikelCubit(
                                      teilInventurArtikelRepository),
                                ),
                              ],
                              child: TeilInventurArtikelScreen(
                                currTeilInventur: archivTeilInventurs[index],
                                // currentShop: _getShopData(
                                //     archivTeilInventurs[index], allShops),
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
  Shop _getShopData(TeilInventur _currTeilInventur, List<Shop> _allShops) {

    return _allShops.firstWhere((element) => element.id == _currTeilInventur.shopId.toString()
        && element.kasseId == _currTeilInventur.kasseId.toString());

  }
}

//Single item of table:
class _TeilInventurItem extends StatelessWidget {
  final TeilInventur currentTeilInventur;
  final Shop currentShop;
  final Function? onTap;
  const _TeilInventurItem({
    Key? key,
    required this.currentTeilInventur,
    required this.currentShop,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentTeilInventur.id,
          currentShop.title ?? "Null",
          currentTeilInventur.created.toString(), // modified To created
          "44"
        ],
      ),
    );
  }
}
