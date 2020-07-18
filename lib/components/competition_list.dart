import 'package:competition_arena/components/competition_item.dart';
import 'package:competition_arena/http/competition_service.dart';
import 'package:competition_arena/models/competition_data.dart';
import 'package:flutter/material.dart';

class CompetitionList extends StatefulWidget {
  final String keyword;
  final List<String> tags;

  CompetitionList({this.keyword, this.tags});
  @override
  State<StatefulWidget> createState() =>
      _CompetitionListState(keyword: keyword, tags: tags);
}

class _CompetitionListState extends State<CompetitionList> {
  CompetitionService compService = new CompetitionService();
  Future<List<CompetitionData>> comps;
  final String keyword;
  final List<String> tags;

  _CompetitionListState({this.keyword, this.tags});

  @override
  void initState() {
    getComps();
    super.initState();
  }

  Future<List<CompetitionData>> getComps() async {
    if (keyword != null || tags != null) {
      if (keyword == null && tags.length > 0) {
        comps = compService.doGetOneFromKeyword('', tags);
      } else if (keyword != null && (tags.length == 0 || tags == null)) {
        comps = compService.doGetOneFromKeyword(keyword, ['none']);
      } else {
        comps = compService.doGetOneFromKeyword(keyword, tags);
      }
    } else {
      comps = compService.doGetList();
    }
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
