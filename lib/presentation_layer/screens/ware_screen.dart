import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/business_logic_layer/cubit/ware_states.dart';
import 'package:hf/data_layer/models/ware.dart';
import 'package:hf/presentation_layer/widgets/ware_table_body.dart';
import 'package:hf/presentation_layer/widgets/ware_table_header.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class WareScreen extends StatefulWidget {
  const WareScreen({Key? key}) : super(key: key);

  @override
  _WareScreenState createState() => _WareScreenState();
}

class _WareScreenState extends State<WareScreen> {
  final formKey = GlobalKey<FormState>();

  //For calling APIs:
  late List<Ware> allWares;

  void moveToAktiv() {
    formKey.currentState!.reset();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<WareCubit>(context).getAllWare();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
        title: "Waren",
      ),
      body: BlocBuilder<WareCubit, WareStates>(builder: (context, wareState) {
        if (wareState is AllWareLoadedState) {
          allWares = wareState.allWares;
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: forms(),
              ),
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
    return [
      //Table header:
      const WareTableHeader(
        titles: [
          "Artikel",
          "EK",
          "VK",
          "MENGE",
        ],
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height / 1.2,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return _TeilInventurItem(
              ware: allWares[index],
            );
          },
          itemCount: allWares.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 2.0,
            );
          },
        ),
      )
    ];
  }
}

//Single item of table:
class _TeilInventurItem extends StatelessWidget {
  final Ware ware;
  const _TeilInventurItem({
    Key? key,
    required this.ware,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: WareTableBody(
        data: [
          ware.artikel,
          ware.ek,
          ware.vk, // modified To created
          ware.menge, // modified To created
          ware.ean, // modified To created
          ware.product, // modified To created
        ],
      ),
    );
  }
}
