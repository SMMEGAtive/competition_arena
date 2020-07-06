import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/components/charts.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Statistic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  // Chart State
  var detailed = false;
  var simple = true;
  var mahasiswa = true;
  var school = false;
  var win = true;
  var participation = false;
  var ratio = false;

  barChart(int code) {
    if (code == 11) {
      HorizontalBarChart(_createSampleData());
    } else {
      HorizontalBarChart(_createSampleData());
    }
  }

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
          return HorizontalBarChart(_createSampleData());
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

  static List<charts.Series<OrdinalParticipation, String>> _createSampleData() {
    final data = [
      new OrdinalParticipation('PNJ', 15),
      new OrdinalParticipation('UI', 15),
      new OrdinalParticipation('Gundar', 12),
      new OrdinalParticipation('UIN Ciputat', 10),
      new OrdinalParticipation('ITB', 15),
      new OrdinalParticipation('UGM', 15),
      new OrdinalParticipation('UPNVJ', 12),
      new OrdinalParticipation('UPNVYK', 10),
      new OrdinalParticipation('IPB', 15),
      new OrdinalParticipation('Binus', 15),
    ];

    return [
      new charts.Series(
        id: 'Participation',
        data: data,
        domainFn: (OrdinalParticipation participation, _) =>
            participation.label,
        measureFn: (OrdinalParticipation participation, _) =>
            participation.count,
        labelAccessorFn: (OrdinalParticipation participation, _) =>
            '${participation.label}: ${participation.count.toString()}',
      )
    ];
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
            Flexible(child: chartLoading(),)
          ],
        ),
      ),
    );
  }
}
