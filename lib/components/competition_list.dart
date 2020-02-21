import 'package:competition_arena/components/competition_item.dart';
import 'package:flutter/material.dart';

class CompetitionList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CompetitionListState();
}

class _CompetitionListState extends State<CompetitionList> {
  @override
  Widget build(BuildContext context) {
    var list = ListView.builder(
      //itemCount harus dibikin dinamis nanti
      itemCount: 6,
      scrollDirection: Axis.vertical,

      //Buat build list
      itemBuilder: (context, index) {
        return CompetitionItem(
          title: 'Lomba 1',
          date: 'Tanggalnya',
          imageURL: 'https://rhythmega.s-ul.eu/v9SyAUOe',
          description: 'Deskripsi lombanya',
          status: 'Pendaftaran',
        );
      },
    );

    var fullList = Container(
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        
        children: <Widget>[
          Flexible(
            child: Container(
              child: list,
            ),
          )
        ],
      ),
    );

    return list;
  }
}
