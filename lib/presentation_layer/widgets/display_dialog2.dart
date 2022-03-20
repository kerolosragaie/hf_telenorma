import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'textbutton_pro.dart';
import 'textformfield_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';

showNeue({
  required BuildContext context,
  String? toastMessgeNein,
  required List<Shop> shopsList,
  required Function onSelectInventurStarten,
  required TextEditingController kommentarController,
  required Function onChangeValue,
  required Function onChangeValue2,
}) {
  // set up the buttons
  Widget okButton = TextButton(
    //NEIN = No
    child: const Text("NEIN"),
    onPressed: () {
      Navigator.of(context).pop();
      if (toastMessgeNein != null) {
        Fluttertoast.showToast(
          msg: toastMessgeNein,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    },
  );
  Widget continueButton = TextButton(
    //JA = Yes
    child: const Text("JA"),
    onPressed: () {
      Navigator.of(context).pop();
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (context) => _BuildSheetPro(
          shopsList: shopsList,
          onSelectInventurStarten: onSelectInventurStarten,
          kommentarController: kommentarController,
          onChangeValue: onChangeValue,
          onChangeValue2: onChangeValue2,
        ),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: const Text(
        "Wurden die Bestände im Kassensystem auf Null zurückgesetzt?"),
    actions: [
      okButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _BuildSheetPro extends StatefulWidget {
  final List<Shop> shopsList;
  final Function onSelectInventurStarten;
  final TextEditingController kommentarController;
  final Function onChangeValue;
  final Function onChangeValue2;
  const _BuildSheetPro({
    Key? key,
    required this.shopsList,
    required this.onSelectInventurStarten,
    required this.kommentarController,
    required this.onChangeValue,
    required this.onChangeValue2,
  }) : super(key: key);

  @override
  __BuildSheetProState createState() => __BuildSheetProState();
}

class __BuildSheetProState extends State<_BuildSheetPro> {
  Shop? selectedVal;
  Shop? selectedVal2;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        selectedVal = widget.shopsList[0];
        selectedVal2 = widget.shopsList[1];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Dialog title:
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Neue Inventur",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: HexColor("#424D51"),
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //Dropdown title:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "Geschäft auswählen (Von)",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: HexColor("#5E5E5F"),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          //Dropdown list:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: DropdownButton(
                value: selectedVal,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: widget.shopsList.map((singleShop) {
                  return DropdownMenuItem<Shop>(
                    value: singleShop,
                    enabled: singleShop.id == selectedVal2?.id ? false : true,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(singleShop.title.toString(),
                        style: TextStyle(
                            color: singleShop.id == selectedVal2?.id
                                ? Colors.grey
                                : Colors.black)),
                  );
                }).toList(),
                onChanged: (Shop? newVal) {
                  widget.onChangeValue(newVal);
                  setState(() {
                    selectedVal = newVal;
                  });
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "Geschäft auswählen (Zu)",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: HexColor("#5E5E5F"),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: DropdownButton(
                value: selectedVal2,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: widget.shopsList.map((singleShop) {
                  return DropdownMenuItem<Shop>(
                    value: singleShop,
                    enabled: singleShop.id == selectedVal?.id ? false : true,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      singleShop.title.toString(),
                      style: TextStyle(
                          color: singleShop.id == selectedVal?.id
                              ? Colors.grey
                              : Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (Shop? newVal) {
                  widget.onChangeValue2(newVal);
                  setState(() {
                    selectedVal2 = newVal;
                  });
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormFieldPro(
              title: "Kommentar",
              hintText: "comment",
              textInputType: TextInputType.text,
              textEditingController: widget.kommentarController,
              validator: (val) {},
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: TextButtonPro(
              title: 'INVENTUR STARTEN',
              onPressed: () {
                if (selectedVal2?.id == selectedVal?.id) {
                } else {
                  return widget.onSelectInventurStarten();
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
