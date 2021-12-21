import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'textbutton_pro.dart';
import 'textformfield_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';

showNeueInventur({
  required BuildContext context,
  String? toastMessgeNein,
  required List<String> shopsList,
  required Function onSelectInventurStarten,
  required TextEditingController kommentarController,
  required Function onChangeValue,
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
        builder: (context) => buildSheet(
          context,
          shopsList: shopsList,
          onSelectInventurStarten: onSelectInventurStarten,
          kommentarController: kommentarController,
          onChangeValue: onChangeValue,
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

Widget buildSheet(
  BuildContext context, {
  required List<String> shopsList,
  required Function onSelectInventurStarten,
  required TextEditingController kommentarController,
  required Function onChangeValue,
}) =>
    SingleChildScrollView(
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
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Geschäft auswählen",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: HexColor("#5E5E5F"),
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //Dropdown list:
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: DropdownButton(
                value: shopsList[0],
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: shopsList.map((singleShop) {
                  return DropdownMenuItem<String>(
                    value: singleShop,
                    enabled: true,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(singleShop),
                  );
                }).toList(),
                onChanged: (String? newVal) => onChangeValue(newVal)),
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
              textEditingController: kommentarController,
              validator: (val) {},
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: TextButtonPro(
              title: 'INVENTUR STARTEN',
              onPressed: () => onSelectInventurStarten(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
