import 'package:competition_arena/models/competition_data.dart';
import 'package:competition_arena/values/gFunction.dart';
import 'package:competition_arena/view/competition.dart';
import 'package:flutter/material.dart';

class CompetitionItem extends StatelessWidget {
  final CompetitionData data;
  final String imageURL;

  CompetitionItem({
    Key key,
    this.data,
    this.imageURL,
  }) : super(key: key);

  String getCompetitionStatus() {
    DateTime now = DateTime.now();

    if (now.isBefore(data.registrationStart)) {
      return 'Belum dibuka';
    } else if (now.isAfter(data.registrationStart) &&
        now.isBefore(data.registrationEnd)) {
      return '''Fase Pendaftaran:
      ${processDateTimeAsDate(data.registrationStart)} - ${processDateTimeAsDate(data.registrationEnd)} ''';
    } else if (now.isBefore(data.verificationEnd)) {
      return '''Fase Verifikasi:
      Sebelum ${processDateTimeAsDate(data.verificationEnd)} ''';
    } else if (now.isAfter(data.executionStart) &&
        now.isBefore(data.executionEnd)) {
      return '''Fase Pelaksanaan:
      ${processDateTimeAsDate(data.executionStart)} - ${processDateTimeAsDate(data.executionEnd)} ''';
    } else if (now.isAfter(data.executionEnd) &&
        now.isBefore(data.announcementDate)) {
      return '''Menunggu pengumuman:
      ${processDateTimeAsDate(data.announcementDate)} ''';
    } else if (now.isAfter(data.announcementDate)) {
      return 'Lomba sudah selesai';
    } else {
      return 'Tidak diketahui';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget item = Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            width: 120,
            height: 120,
            child: Image.network(
              imageURL,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                getCompetitionStatus(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                data.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          )
        ],
      ),
    );

    var linkItem = InkWell(
      child: item,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Competition(data: data),
          ),
        );
      },
    );

    return linkItem;
  }
}
