import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/components/charts.dart';
import 'package:competition_arena/http/statistic_service.dart';
import 'package:competition_arena/models/statistic_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Statistic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  StatisticService statisticService = StatisticService();
  Future<List<StatisticData>> list;

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

  Future<List<StatisticData>> getData() {
    list = statisticService.getStat();

    return list;
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
          return _createSampleData();
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

  _createSampleData() {
    /* final data = [
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
    ]; */

    var futura = FutureBuilder(
        future: getData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<StatisticData>> snapshot) {
          if (snapshot.hasData) {
            List<OrdinalParticipation> viewData = [];

            snapshot.data.sort((a, b) => b.winRatio - a.winRatio);
            for (int i = 0; i < snapshot.data.length; i++) {
              viewData.add(OrdinalParticipation(
                  snapshot.data[i].username, snapshot.data[i].winRatio));
            }

            var sample = [
              new charts.Series(
                id: 'Participation',
                data: viewData,
                domainFn: (OrdinalParticipation participation, _) =>
                    participation.label,
                measureFn: (OrdinalParticipation participation, _) =>
                    participation.count,
                labelAccessorFn: (OrdinalParticipation participation, _) =>
                    '${participation.label}: ${participation.count.toString()}',
              )
            ];

            return HorizontalBarChart(sample);
          } else if (snapshot.hasError) {
            return Column(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            return Column(
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ],
            );
          }
        });

    return futura;
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
            Flexible(
              child: chartLoading(),
            )
          ],
        ),
      ),
    );
  }
}
