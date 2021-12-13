import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/inventurs_cubit.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/models/inventurs.dart';
import 'package:hf/data_layer/models/shops.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class TeilInventurScreen extends StatefulWidget {
  const TeilInventurScreen({Key? key}) : super(key: key);

  @override
  _TeilInventurScreenState createState() => _TeilInventurScreenState();
}

//enum for form, to make change between forms
enum FormType {
  aktiv,
  archiv,
}

class _TeilInventurScreenState extends State<TeilInventurScreen> {
  //varaibles to change between aktiv page and archiv page
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.aktiv;

  //For calling APIs:
  late List<Shops> allShops;
  late List<Inventurs> allInventurs;

  late ShopsCubit shops;

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
      BlocProvider.of<ShopsCubit>(context).getAllShops();
      BlocProvider.of<InventursCubit>(context).getAllInventurs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
        title: "Teil-Inventur",
      ),
      body: BlocBuilder<ShopsCubit, ShopsState>(builder: (context, shopsState) {
        if (shopsState is ShopsLoadedState) {
          allShops = (shopsState).shops;
          return BlocBuilder<InventursCubit, InventursState>(
            builder: (context, inventursState) {
              if (inventursState is InventursLoaded) {
                allInventurs = (inventursState).inventurs;
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
            },
          );
        } else {
          return const Center(
            child: Text("Loading..."),
          );
        }
      }),
      /* body: MultiBlocListener(
        listeners: [
          BlocListener<ShopsCubit, ShopsState>(
            listener: (context, state) {
              if (state is ShopsLoadedState) {
                allShops = (state).shops;
                print(allShops);
              }
            },
          ),
          BlocListener<InventursCubit, InventursState>(
            listener: (context, state) {
              if (state is InventursLoaded) {
                allInventurs = (state).inventurs;
              }
            },
          ),
        ],
        child: Form(
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
        ),
      ), */
    );
  }

  List<Widget> forms() {
    if (_formType == FormType.aktiv) {
      return [
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: TextButtonPro(
            title: "Neue Teil-Inventur",
            onPressed: () {},
          ),
        ),
        //design table here:
        const _TableHeader(),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.builder(
            itemCount: allShops.length,
            itemBuilder: (context, index) {
              //TODO: Something wrong with model(wrong from API):
              return _TeilInventurItem(
                currentShop: allShops[index],
                currentInventur: allInventurs[index],
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(teilInventurViewerScreen, arguments: {
                    "currentInventur": Inventurs(
                      id: "${index + 2}",
                      shopId: "42515",
                      modifiedAt: "16.9.2021",
                    ),
                  });
                },
              );
            },
          ),
        ),
      ];
    } else {
      return [
        //design table here:
        const _TableHeader(),
      ];
    }
  }
}

//Titles in column of the table:
class _TableHeader extends StatelessWidget {
  const _TableHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: HexColor("E2E2E2")),
          bottom: BorderSide(width: 1.0, color: HexColor("E2E2E2")),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 30,
            width: 60,
            child: Center(
              child: Text(
                "ID",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      color: HexColor("424D51"),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
            width: 60,
            child: Center(
              child: Text(
                "Shop",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      color: HexColor("424D51"),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
            width: 60,
            child: Center(
              child: Text(
                "Erstel. Datum",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      color: HexColor("424D51"),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
            width: 60,
            child: Center(
              child: Text(
                "Benutzer",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      color: HexColor("424D51"),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Single item of table:
class _TeilInventurItem extends StatelessWidget {
  final Shops currentShop;
  final Inventurs currentInventur;
  final Function? onTap;
  const _TeilInventurItem({
    Key? key,
    required this.currentShop,
    required this.currentInventur,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: Container(
        height: 42,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: HexColor("E2E2E2")),
            bottom: BorderSide(width: 1.0, color: HexColor("E2E2E2")),
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 30,
              width: 60,
              child: Center(
                child: Text(
                  currentShop.id.toString(),
                  maxLines: 1,
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        color: HexColor("424D51"),
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              width: 60,
              child: Center(
                child: Text(
                  currentShop.title,
                  maxLines: 1,
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        color: HexColor("424D51"),
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              width: 60,
              child: Center(
                child: Text(
                  currentInventur.modifiedAt.toString(),
                  maxLines: 1,
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        color: HexColor("424D51"),
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              width: 60,
              child: Center(
                child: Text(
                  "44",
                  maxLines: 1,
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        color: HexColor("424D51"),
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}