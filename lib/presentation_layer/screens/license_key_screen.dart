import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/local_data/license_data.dart';
import 'package:hf/presentation_layer/widgets/error_message.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class LicenseKeyScreen extends StatefulWidget {
  const LicenseKeyScreen({Key? key}) : super(key: key);

  @override
  _LicenseKeyScreenState createState() => _LicenseKeyScreenState();
}

class _LicenseKeyScreenState extends State<LicenseKeyScreen> {
  TextEditingController licenseKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      //checkIfLicenseFound();
    });
  }
/*
  void checkIfLicenseFound() async {
    if (await LicenseData.isLicenseFound()) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(loginScreen);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _Logo(),
            const _Slogan(),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: TextFormFieldPro(
                title: "Schlüssel",
                hintText: "TN-THE-BEST",
                textEditingController: licenseKeyController,
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return "Das ist ein Pflichtfeld!";
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 23, right: 23),
              child: TextButtonPro(
                title: "senden",
                onPressed: () async {
                  await LicenseData.saveLicenseData(licenseKeyController.text)
                      .then((value) async {
                    if (await LicenseData.isLicenseFound()) {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(loginScreen);
                    } else {
                      showAlertDialog(context);
                    }
                  });
                },
              ),
            ),
            const SizedBox(
              height: 260,
            ),
            const TelenormaCopyrights(),
          ],
        ),
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
      child: const Image(
        image: AssetImage('assets/logo_HF.jpg'),
      ),
    );
  }
}

class _Slogan extends StatelessWidget {
  const _Slogan({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 54.56, left: 61, right: 61),
      child: AutoSizeText("Bitte geben Sie Ihre Lizenzschlüssel ein",
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
                color: HexColor("424D51"),
                fontSize: 24,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300),
          )),
    );
  }
}
