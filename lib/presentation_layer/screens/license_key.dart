import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hf/presentation_layer/widgets/textbutton_pro.dart';
import 'package:hf/presentation_layer/widgets/textformfield_pro.dart';


class LicenseKeyScreen extends StatefulWidget {
  const LicenseKeyScreen({Key? key}) : super(key: key);

  @override
  _LicenseKeyScreenState createState() => _LicenseKeyScreenState();
}

class _LicenseKeyScreenState extends State<LicenseKeyScreen> {
  TextEditingController licenseKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _Logo(),
          const _Slogan(),
          //TODO: add the font
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: TextFormFieldPro(
              title: "Der Code",
              hintText: "TN-THE-BEST",
              textEditingController: licenseKeyController,
              textInputType: TextInputType.number,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, left: 23, right: 23),
            child: TextButtonPro(
              title: "senden",
              onPressed: () {},
            ),
          ),

          SizedBox(height: 300,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text("Powered by", style: TextStyle(fontSize: 14),),
              Text("TELENORMA", style: TextStyle(fontSize: 14, color: HexColor("#F89921")),),
            ],
          )
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 53, left: 70, right: 70),
      //TODO: need to change logo color as in figma
      child: Image(image: AssetImage('assets/logo_HF.jpg'),),
      /*SvgPicture.asset(
        "assets/hf_logo.svg",
        width: 235,
        height: 65.44,
        color: HexColor("FF9800"),
      ),*/
    );
  }
}

class _Slogan extends StatelessWidget {
  const _Slogan({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 54.56, left: 61, right: 61),
      child: AutoSizeText(
        "Bitte geben Sie Ihre Lizenzschlüssel ein",
        textAlign: TextAlign.center,
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
              color: HexColor("424D51"),
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),
        )
      ),
    );
  }
}
