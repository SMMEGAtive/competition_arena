import 'package:competition_arena/components/competition_item.dart';
import 'package:competition_arena/http/competition_service.dart';
import 'package:competition_arena/models/competition_data.dart';
import 'package:flutter/material.dart';

class CompetitionList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CompetitionListState();
}

class _CompetitionListState extends State<CompetitionList> {
  CompetitionService compService = new CompetitionService();
  Future<List<CompetitionData>> comps;
  @override
  void initState() {
    //comps = compService.doGetList();
    super.initState();
  }

  Future<List<CompetitionData>> getComps() async {
    comps = compService.doGetList();
    return comps;
  }

  @override
  Widget build(BuildContext context) {
    var futura = FutureBuilder(
      future: getComps(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CompetitionData>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            //itemCount harus dibikin dinamis nanti
            itemCount: snapshot.data.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,

            //Buat build list
            itemBuilder: (context, index) {
              return CompetitionItem(
                data: snapshot.data[index],
                imageURL: 'https://rhythmega.s-ul.eu/v9SyAUOe',
              );
            },
          );
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
      },
    );

    return futura;
  }
}
