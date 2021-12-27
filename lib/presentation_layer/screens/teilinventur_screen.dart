import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/teil_inventur_cubit.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/models/teil_inventur.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';
import 'package:logger/logger.dart';

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
      BlocProvider.of<TeilInventurCubit>(context).getAllTeilInventur();
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
        if (teilInventurState is TeilInventurLoadedState) {
          allTeilInventurs = (teilInventurState).teilInventurs;
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
            itemCount: allTeilInventurs.length,
            itemBuilder: (context, index) {
              return _TeilInventurItem(
                currentTeilInventur: allTeilInventurs[index],
                onTap: () {
                  /* Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TeilInventurViewerScreen(
                            currentShop: allShops[index],
                          ))); */
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
  final TeilInventur currentTeilInventur;
  final Function? onTap;
  const _TeilInventurItem({
    Key? key,
    required this.currentTeilInventur,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : () {},
      child: TableBody(
        data: [
          currentTeilInventur.id,
          currentTeilInventur.shopId,
          currentTeilInventur.modified.toString(),
          "44"
        ],
      ),
    );
  }
}
