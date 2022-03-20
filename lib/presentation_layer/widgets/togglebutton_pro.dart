import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/constants/colors.dart';

class ToggleButtonPro extends StatefulWidget {
  final Function onTapAktiv;
  final Function onTapArchiv;

  const ToggleButtonPro(
      {Key? key, required this.onTapAktiv, required this.onTapArchiv})
      : super(key: key);
  @override
  State<ToggleButtonPro> createState() => _ToggleButtonProState();
}

class _ToggleButtonProState extends State<ToggleButtonPro> {
  final List<bool> isSelected = [true, false];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        isSelected: isSelected,
        selectedColor: AppColors.orange,
        hoverColor: AppColors.orange,
        color: HexColor('#919191'),
        splashColor: AppColors.orange,
        fillColor: Colors.white,
        borderRadius: BorderRadius.circular(6),
        direction: Axis.horizontal,
        constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width - 50) / 2,
            minHeight: 25),
        highlightColor: AppColors.orange,
        children: const [
          Text("AKTIV"),
          Text("ARCHIV"),
        ],
        onPressed: (currentIndex) {
          if (currentIndex == 0) {
            widget.onTapAktiv();
          } else {
            widget.onTapArchiv();
          }
          setState(() {
            for (int index = 0; index < isSelected.length; index++) {
              if (index == currentIndex) {
                isSelected[index] = true;
              } else {
                isSelected[index] = false;
              }
            }
          });
        },
      ),
    );
  }
}
