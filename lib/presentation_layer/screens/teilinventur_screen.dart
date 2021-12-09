import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/constants/colors.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/models/inventurs.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
        title: "Teil-Inventur",
      ),
      body: Form(
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
            itemCount: 3,
            itemBuilder: (context, index) {
              //TODO: Something wrong with model:
              return _TeilInventurItem(
                currentInventur: Inventurs(
                  id: "${index + 2}",
                  shopId: "42515",
                  modifiedAt: "16.9.2021",
                ),
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
  final Inventurs currentInventur;
  final Function? onTap;
  const _TeilInventurItem({Key? key, required this.currentInventur, this.onTap})
      : super(key: key);

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
                  currentInventur.id.toString(),
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
                  "unkown",
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
                  currentInventur.shopId.toString(),
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
