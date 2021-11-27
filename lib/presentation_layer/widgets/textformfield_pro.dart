import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class TextFormFieldPro extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  const TextFormFieldPro(
      {Key? key,
      required this.textEditingController,
      required this.title,
      required this.hintText,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: AutoSizeText(
            title,
            maxLines: 1,
            style: TextStyle(
                color: HexColor("000000"),
                fontSize: 12,
                fontWeight: FontWeight.w300),
          ),
        ),
        Container(
          width: 329,
          height: 43,
          decoration: BoxDecoration(
              color: HexColor("F2F3F2"),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: TextFormField(
            keyboardType: textInputType,
            cursorColor: HexColor("424D51"),
            controller: textEditingController,
            autovalidateMode: AutovalidateMode.always,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
            decoration: InputDecoration(
              labelText: hintText,
              labelStyle: TextStyle(fontSize: 14, color: HexColor("424D51")),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor("F2F3F2"),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HexColor("424D51")),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
