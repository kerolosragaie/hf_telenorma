import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconButton iconButton;
  final Color buttonColor;
  const CircleIconButton(
      {Key? key, required this.iconButton, this.buttonColor = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: buttonColor,
        child: InkWell(
          onTap: () => iconButton.onPressed,
          child: SizedBox(width: 46, height: 46, child: iconButton.icon),
        ),
      ),
    );
  }
}
