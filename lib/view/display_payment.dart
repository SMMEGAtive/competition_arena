import 'package:competition_arena/values/color_palette.dart';
import 'package:flutter/material.dart';

class DisplayPayment extends StatelessWidget {
  final String competition;
  final String sender;
  final bool status;
  final String imgUrl;

  final String notLoadedString = "???";
  final String notLoadedImage =
      "https://gbf.wiki/images/thumb/6/66/Rupies_square.jpg/25px-Rupies_square.jpg";

  DisplayPayment({
    this.competition,
    this.sender,
    this.imgUrl,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: ColorPalette.lightBlue_100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: ColorPalette.darkBlue_100,
                  height: 200,
                  child: Image(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage(imgUrl != null ? imgUrl : notLoadedImage),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    child: Text(
                      'Lomba: ${competition != null ? competition : notLoadedString}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Divider(thickness:3,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    child: Text(
                      'Pengirim: ${sender != null ? sender : notLoadedString}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    child: Text(
                      'Status: ${status != null ? 'Terbayar' : notLoadedString}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  AlertDialog(
                    content: Text('Transaksi berhasil divalidasi'),
                    title: Text('Validasi Berhasil'),
                  );
                },
                child: Text('Validasi'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
