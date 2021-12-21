import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/models/shops.dart';
import 'package:hf/presentation_layer/screens/teilinventur_viewer_screen.dart';
import 'package:hf/presentation_layer/widgets/dispaly_dialog.dart';
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
  late List<Shops> allShops;

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
      BlocProvider.of<ShopsCubit>(context).getAllShops();
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
              showNeueInventur(
                context: context,
                toastMessgeNein: "Hello",
                shopsList: [
                  "ID",
                  "Shop",
                  "Erstel Datum",
                  "Benutzer",
                ],
                onSelectInventurStarten: () {
                  print("worked");
                },
                kommentarController: kommentarController,
                onChangeValue: (val) {
                  print(val);
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
            itemCount: allShops.length,
            itemBuilder: (context, index) {
              return _TeilInventurItem(
                currentShop: allShops[index],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TeilInventurViewerScreen(
                            currentShop: allShops[index],
                          )));
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
        //TODO: what to add here?
      ];
    }
  }
}

//Single item of table:
//TODO: add date,time to Shops model and use Hive SQL DB
class _TeilInventurItem extends StatelessWidget {
  final Shops currentShop;
  final Function? onTap;
  const _TeilInventurItem({
    Key? key,
    required this.currentShop,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentShop.id.toString(),
          currentShop.title,
          DateTime.now().toString(),
          "44"
        ],
      ),
    );
  }
}
