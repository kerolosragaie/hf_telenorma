import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hf/presentation_layer/widgets/dispaly_dialog.dart';
import 'package:hf/presentation_layer/widgets/toggle_button.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class InventurScreen extends StatefulWidget {
  const InventurScreen({Key? key}) : super(key: key);

  @override
  _InventurScreenState createState() => _InventurScreenState();
}

class _InventurScreenState extends State<InventurScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            "Inventur",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: HexColor("424D51"),
                fontSize: 24,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    width: 166,
                      child: ToggleButtonPro(),
                  ),
                ),


              ],
            ),
            SizedBox(height: 15,),
            TextButtonPro(title: 'NEUE INVENTUR',onPressed: (){
              setState(() {
                showAlertDialog(context);
              });

            },
            ),


          ],

        ),
      ),
    );
  }
}
