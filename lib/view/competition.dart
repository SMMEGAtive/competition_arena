import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/chat.dart';
import 'package:competition_arena/view/competition_meta.dart';
import 'package:competition_arena/view/submission_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SvgPicture.asset('assets/bubble.svg', width: 30.0),
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
                    Positioned(
                      child: InkWell(
                        child: Icon(Icons.list),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubmissionList(),
                            ),
                          );
                        },
                      ),
                      top: 10,
                      right: 15,
                    ),
                    Positioned(
                      child: InkWell(
                        child: SvgPicture.asset(
                          'assets/pencil.svg',
                          width: 20,
                          color: ColorPalette.black,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompetitionMeta(),
                            ),
                          );
                        },
                      ),
                      top: 10,
                      right: 50,
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
              )
            ],
          ),
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: ColorPalette.black, width: 1.0)),
                  color: ColorPalette.white,
                ),
                width: MediaQuery.of(context).size.width,
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
