import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:flutter/material.dart';

class Statistic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  var detailed = false;
  var simple = true;
  var mahasiswa = true;
  var school = false;
  var win = true;
  var participation = false;
  var ratio = false;

  interfaceLoading() {
    if (simple && !detailed) {
      return Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ButtonPrimary(
                text: 'Jumlah Juara',
                onPress: () {
                  setState(() {
                    win = true;
                    participation = false;
                    ratio = false;
                  });
                },
              ),
            ),
            Expanded(
              child: ButtonPrimary(
                text: 'Jumlah Partisipasi',
                onPress: () {
                  setState(() {
                    win = false;
                    participation = true;
                    ratio = false;
                  });
                },
              ),
            ),
            Expanded(
              child: ButtonPrimary(
                text: 'Rasio Juara',
                onPress: () {
                  setState(() {
                    win = false;
                    participation = false;
                    ratio = true;
                  });
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  chartLoading() {
    if (simple) {
      if (mahasiswa) {
        if (win) {
          return Text('Chart Simple Mahasiswa Juara');
        } else if (participation) {
          return Text('Chart Simple Mahasiswa Participation');
        } else if (ratio) {
          return Text('Chart Simple Mahasiswa Ratio');
        } else {
          return Text('????');
        }
      } else if (school) {
        if (win) {
          return Text('Chart Simple School Juara');
        } else if (participation) {
          return Text('Chart Simple School Participation');
        } else if (ratio) {
          return Text('Chart Simple School Ratio');
        } else {
          return Text('????');
        }
      }
    } else if (detailed) {
      if (mahasiswa) {
        return Text('Table Detailed Mahasiswa');
      } else if (school) {
        return Text('Table Detailed School');
      } else {
        return Text('????');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Stat',
        hasBackButton: false,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonPrimary(
                      text: 'Tampilan Simpel',
                      onPress: () {
                        setState(() {
                          simple = true;
                          detailed = false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ButtonPrimary(
                      text: 'Tampilan Detail',
                      onPress: () {
                        setState(() {
                          simple = false;
                          detailed = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonPrimary(
                      text: 'Mahasiswa',
                      onPress: () {
                        setState(() {
                          mahasiswa = true;
                          school = false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ButtonPrimary(
                      text: 'Perguruan Tinggi',
                      onPress: () {
                        setState(() {
                          mahasiswa = false;
                          school = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            interfaceLoading(),
            chartLoading()
          ],
        ),
      ),
    );
  }
}
