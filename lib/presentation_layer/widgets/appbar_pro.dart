import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarPro extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool addBackButton;
  final Function? onPressSettings;
  final List<Widget>? actions;
  const AppBarPro(
      {Key? key,
      this.title,
      this.addBackButton = false,
      this.onPressSettings,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: title != null
          ? Text(
              title!,
              maxLines: 1,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: HexColor("424D51"),
                  fontSize: 24,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          : const SizedBox.shrink(),
      leading: addBackButton
          ? IconButton(
              icon: const Image(
                image: AssetImage("assets/buttons/back_button.png"),
                width: 35,
                height: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : const SizedBox.shrink(),
      actions: actions ??
          [
            onPressSettings != null
                ? IconButton(
                    icon: const Image(
                      image: AssetImage("assets/buttons/settings_button.png"),
                      width: 35,
                      height: 35,
                    ),
                    onPressed: () => onPressSettings!(),
                  )
                : const SizedBox.shrink(),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
