import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/constants/colors.dart';
import 'package:hf/presentation_layer/widgets/textbutton_pro.dart';

class ToggleButtonPro extends StatefulWidget {
  @override
  State<ToggleButtonPro> createState() => _ToggleButtonProState();
}

class _ToggleButtonProState extends State<ToggleButtonPro> {

  final List<bool> isSelected = [true, false];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),

      child: Center(
        child: ToggleButtons(
          isSelected: isSelected,
          selectedColor: AppColors.orange,
          hoverColor: AppColors.orange,
          color: HexColor('#F2F3F2'),
          splashColor: AppColors.orange,
          fillColor: Colors.white,
          borderRadius: BorderRadius.circular(6),
          direction: Axis.horizontal,
          constraints: BoxConstraints(minWidth: (MediaQuery.of(context).size.width - 50)/2,
              minHeight:  25
          ),

          highlightColor: AppColors.orange,
          children: const [
            Text("AKTIV"),
            Text("ARCHIV"),
          ],
          onPressed: (newIndex) {
            setState(() {
              for(int index = 0 ; index< isSelected.length; index++){
                if (index == newIndex) {
                  isSelected[index] = true;
                } else {
                  isSelected[index] = false;
                  //todo: Navigate to ARCHIV Screen
                }
              }
            });
          },
        ),
      ),
    );
  }
}

/*


 */
