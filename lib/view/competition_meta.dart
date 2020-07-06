import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/competition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompetitionMeta extends StatelessWidget {
  final String title;
  final String description;
  final DateTime registrationStart;
  final DateTime registrationEnd;
  final DateTime verificationEnd;
  final DateTime executionStart;
  final DateTime executionEnd;
  final DateTime announcementDate;

  CompetitionMeta({
    this.title,
    this.description,
    this.registrationStart,
    this.registrationEnd,
    this.verificationEnd,
    this.executionStart,
    this.executionEnd,
    this.announcementDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title != null ? 'Edit Lomba' : 'Tambah Lomba'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              child: Icon(Icons.save),
              onTap: () {
                //Save Function
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Competition(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
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
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorPalette.darkBlue_300,
                        ),
                        child: SvgPicture.asset(
                          'assets/pencil.svg',
                          width: 20,
                          color: ColorPalette.white,
                        ),
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
                    bottom: 10,
                    right: 20,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Nama Lomba'),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Deskripsi Lomba'),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.loose,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'Mulai pendaftaran'),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'Selesai pendaftaran'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Selesai verifikasi pendaftaran'),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'Mulai perlombaan'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'Selesai perlombaan'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Tanggal Pengumuman pemenang'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
