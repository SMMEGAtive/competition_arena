import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HorizontalBarChart extends StatelessWidget {
  //Chart Meta
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarChart(this.seriesList, {this.animate});

  factory HorizontalBarChart.withSampleData() {
    return new HorizontalBarChart(_createSampleData(), animate: false);
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }

  static List<charts.Series<OrdinalParticipation, String>> _createSampleData() {
    final data = [
      new OrdinalParticipation('Error', 0),
      new OrdinalParticipation('Error', 0),
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
            '${participation.label}: \$${participation.count.toString()}',
      )
    ];
  }

  
}

class OrdinalParticipation {
  final String label;
  final int count;

  OrdinalParticipation(this.label, this.count);
}

class RatioParticipation {
  final String label;
  final double ratio;

  RatioParticipation(this.label, this.ratio);
}
