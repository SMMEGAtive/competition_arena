import 'package:competition_arena/values/color_palette.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final Image icon;
  final Color color;
  final Function onPress;

  ButtonCustom({
    Key key,
    this.text,
    this.icon,
    this.color,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (icon != null) {
      image = Container(
        width: 20,
        height: 20,
        margin: EdgeInsets.only(left: 15, top: 2),
        child: icon,
      );
    } else {
      image = Container();
    }

    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: Material(
                elevation: 4,
                color: color,
                child: InkWell(
                  onTap: onPress,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      image,
                      Container(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            color: Color.fromRGBO(109, 103, 103, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonPrimary extends StatelessWidget {
  final String text;
  final Function onPress;

  ButtonPrimary({Key key, this.text, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonCustom(
      text: text,
      color: ColorPalette.lightBlue_100,
      onPress: onPress,
    );
  }
}

class ButtonConfirm extends StatelessWidget {
  final String text;
  final Function onPress;

  ButtonConfirm({Key key, this.text, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonCustom(
      text: text,
      color: ColorPalette.green_400,
      onPress: onPress,
    );
  }
}

class ButtonWarning extends StatelessWidget {
  final String text;
  final Function onPress;

  ButtonWarning({Key key, this.text, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonCustom(
      text: text,
      color: Color.fromRGBO(240, 12, 12, 1),
      onPress: onPress,
    );
  }
}
