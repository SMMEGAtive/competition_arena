import 'package:competition_arena/values/color_palette.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final List<Widget> actions;

  const AppBarCustom({
    Key key,
    this.title,
    this.hasBackButton,
    this.actions,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var backButton;
    if (this.hasBackButton) {
      backButton = InkWell(
        child: Icon(
          Icons.arrow_back_ios,
          color: ColorPalette.lightBlue_500,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      );
    }
    return AppBar(
      backgroundColor: ColorPalette.white,
      elevation: 0.5,
      centerTitle: true,
      actions: actions,
      leading: backButton,
      title: Container(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: ColorPalette.lightBlue_500,
              fontWeight: FontWeight.bold,
              fontFamily: 'Segoe UI',
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
