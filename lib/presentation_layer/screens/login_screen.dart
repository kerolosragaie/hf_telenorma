import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                title: "Benutzername",
                hintText: "Benutzername",
                textEditingController: userNameController,
                textInputType: TextInputType.text,
                validator: (val) {
                  if (val.toString().isEmpty){
                    return "Dies ist ein Pflichtfeld";
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: TextFormFieldPro(
                title: "Passwort",
                hintText: "Passwort",
                textEditingController: passwordController,
                textInputType: TextInputType.visiblePassword,
                validator: (val) {},
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 26,
                right: 86,
              ),
              child: CheckBoxTilePro(
                title: "Eingeloggt bleiben",
                onChanged: (val) {},
                value: false,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 23, right: 23),
              child: TextButtonPro(
                title: "ANMELDEN",
                onPressed: () {},
              ),
            ),
            const SizedBox(
              height: 130,
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

      /*SvgPicture.asset(
        "assets/logo_HF_gr_l",
        width: 235,
        height: 65.44,
        //color: HexColor("FF9800"),
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
        "Willkommen zurück",
        textAlign: TextAlign.center,
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
              color: HexColor("424D51"),
              fontSize: 26,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
