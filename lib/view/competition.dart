import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/chat.dart';
import 'package:flutter/material.dart';

class Competition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        hasBackButton: true,
        title: 'Lomba 1',
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(),
                ),
              );
            },
            child: Text(
              'Chat',
              style: TextStyle(color: ColorPalette.black, fontSize: 28),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.15,
                      child: Container(
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(
                                'https://rhythmega.s-ul.eu/y4E3hmm6'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        'Lomba 1',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      bottom: 60,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        'Penyelenggara',
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 40,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        'Tanggal',
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 20,
                      left: 15,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Text(
                      'Description DescriptionDescription Description Description Description Description Description Description Description Description Description Description Description Description'),
                ),
              ),
            ],
          ),
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                color: ColorPalette.black,
                width: 300,
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('Button Bar'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
