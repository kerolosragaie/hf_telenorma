import 'package:flutter/material.dart';
import 'package:hf/constants/strings.dart';
import 'package:hf/data_layer/local_data/license_data.dart';
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
      checkIfLicenseFound();
    });
  }

  void checkIfLicenseFound() async {
    if (await LicenseData.isLicenseFound()) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HfLogo(),
            const Slogan(
              text: "Bitte geben Sie Ihre Lizenzschlüssel ein",
              fontSize: 24,
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: TextFormFieldPro(
                title: "Der Code",
                hintText: "TN-THE-BEST",
                textEditingController: licenseKeyController,
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return "Empty!";
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
