import 'package:competition_arena/http/score_service.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/submission_display.dart';
import 'package:flutter/material.dart';

class JudgeScore extends StatelessWidget {
  final int idSubmission;
  TextEditingController impression = TextEditingController();
  TextEditingController score = TextEditingController();
  ScoreService scoreService = ScoreService();

  JudgeScore({this.idSubmission});

  castScore() async {
    await scoreService.doPostOne(
        idSubmission, int.parse(score.text), impression.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.darkBlue_400,
      body: Container(
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Column(
            children: <Widget>[
              Text(
                'Judul Karya',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Lomba A',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Partisipan',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Divider(),
              TextField(
                minLines: 1,
                maxLines: 3,
                controller: impression,
                decoration: InputDecoration(labelText: 'Komentar'),
              ),
              TextField(
                controller: score,
                decoration: InputDecoration(labelText: 'Score'),
              ),
              RaisedButton(
                child: Text('Beri Nilai'),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text('Konfirmasi'),
                          content: SingleChildScrollView(
                            child: Text(
                                'Apakah anda yakin dengan penilaian anda?'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ya'),
                              onPressed: () {
                                castScore();
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SubmissionDisplay(
                                      submissionID: idSubmission,
                                    ),
                                  ),
                                );
                              },
                            ),
                            FlatButton(
                              child: Text('Tidak'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ]);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
