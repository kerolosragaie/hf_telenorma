import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'textbutton_pro.dart';
import 'textformfield_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextEditingController commentController = TextEditingController();

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget okButton = TextButton(
    child: const Text("NEIN"),
    onPressed: () {
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Sie müssen zuerst die Bestände im Kassensystem auf Null setzen",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    },
  );
  Widget continueButton = TextButton(
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
        builder: (context) => buildSheet(),
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

String _dropDownValue = "Geschäft auswählen";
final items = [
  "Geschäft auswählen",
  "Schloss",
  "Kudamm",
  "LP12",
  "G14",
  "Lager",
  "Bikini",
  "Test12"
];

Widget buildSheet() => SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: DropdownButton(
              value: _dropDownValue,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  enabled: true,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newVal) {
                _dropDownValue = newVal!;
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormFieldPro(
              title: "Kommentar",
              hintText: "comment",
              textInputType: TextInputType.text,
              textEditingController: commentController,
              validator: (val) {},
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: TextButtonPro(
              title: 'INVENTUR STARTEN',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
