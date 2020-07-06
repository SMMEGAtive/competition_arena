import 'package:competition_arena/values/color_palette.dart';
import 'package:flutter/material.dart';

class PaymentValidation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class _PaymentValidationState extends State<PaymentValidation> {
  int selectedIndex = 0;
  final List<String> categories = [
    'Masuk',
    'Belum Diproses',
    'Diterima',
    'Ditolak'
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: ColorPalette.darkBlue_500,
      body: Column(
        children: <Widget>[
          Container(
            color: ColorPalette.darkBlue_500,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(categories[index]),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorPalette.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              child: Text('Display setiap item'),
            ),
          )
        ],
      ),
    );
  }
}
