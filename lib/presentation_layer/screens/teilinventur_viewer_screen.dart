import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/models/inventurs.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class TeilInventurViewerScreen extends StatefulWidget {
  final Inventurs currentInventur;
  const TeilInventurViewerScreen({Key? key, required this.currentInventur})
      : super(key: key);

  @override
  _TeilInventurViewerScreenState createState() =>
      _TeilInventurViewerScreenState();
}

class _TeilInventurViewerScreenState extends State<TeilInventurViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPro(
        addBackButton: true,
        title: widget.currentInventur.id.toString(),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 43,
                  width: 150,
                  child: TextButtonPro(
                    title: "SPEICHERN",
                    onPressed: () {},
                  ),
                ),
                Column(
                  children: const [
                    Text("Menge: 0"),
                    Text("VK: 0 E"),
                  ],
                ),
                SizedBox(
                  height: 43,
                  width: 150,
                  child: TextButtonPro(
                    title: "HF IMPORT",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          const _TableHeader(),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                //Something wrong with model:
                return _TeilInventurViewerItem(
                  currentInventur: Inventurs(
                    id: "${index + 2}",
                    shopId: "42515",
                    modifiedAt: "16.9.2021",
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(scannerScreen);
              },
              child: Container(
                color: HexColor("F89720"),
                child: const Center(
                  child: Image(
                    height: 65,
                    width: 65,
                    image: AssetImage("assets/icons/scan_button.png"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                "Artikel",
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
                "EAN",
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
                "VK",
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
                "Menge Kasse",
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
                "Menge",
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
class _TeilInventurViewerItem extends StatelessWidget {
  final Inventurs currentInventur;
  final Function? onTap;
  const _TeilInventurViewerItem(
      {Key? key, required this.currentInventur, this.onTap})
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
                  "345003309",
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
