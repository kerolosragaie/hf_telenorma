import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            const HfLogo(),
            const Slogan(text: "Willkommen zurück", fontSize: 26),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: TextFormFieldPro(
                title: "Benutzername",
                hintText: "Benutzername",
                textEditingController: userNameController,
                textInputType: TextInputType.text,
                validator: (val) {
                  if (val.toString().isEmpty) {
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
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return "Dies ist ein Pflichtfeld";
                  }
                },
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
