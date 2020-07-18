import 'package:competition_arena/http/submission_service.dart';
import 'package:competition_arena/models/submission_data.dart';
import 'package:competition_arena/view/submission_display.dart';
import 'package:competition_arena/view/submission_submit.dart';
import 'package:flutter/material.dart';

class SubmissionList extends StatefulWidget {
  final int idCompetition;

  SubmissionList({this.idCompetition});
  @override
  State<StatefulWidget> createState() =>
      _SubmissionListState(idCompetition: idCompetition);
}

class _SubmissionListState extends State<SubmissionList> {
  final int idCompetition;
  SubmissionService submissionService = SubmissionService();
  Future<List<SubmissionData>> list;

  _SubmissionListState({this.idCompetition});

  Future<List<SubmissionData>> getSubmission() async {
    list = submissionService.doGetList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Submisi Lomba')),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Karya Submisi Lomba',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: getSubmission(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<SubmissionData>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        //itemCount harus dibikin dinamis nanti
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,

                        //Buat build list
                        itemBuilder: (context, index) {
                          return SubmissionListItem(
                            title: snapshot.data[index].title,
                            participant:
                                snapshot.data[index].participant.participantName,
                            idSubmission: snapshot.data[index].idSubmission,
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
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubmissionSubmit(),
            ),
          );
        },
      ),
    );
  }
}

class SubmissionListItem extends StatelessWidget {
  final String title;
  final String participant;
  final String imgUrl;
  final int idSubmission;

  SubmissionListItem({
    this.title,
    this.participant,
    this.imgUrl,
    this.idSubmission,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubmissionDisplay(
                  submissionID: idSubmission,
                ),
              ),
            );
          },
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imgUrl != null
                        ? imgUrl
                        : 'https://gbf.wiki/images/thumb/6/66/Rupies_square.jpg/25px-Rupies_square.jpg'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title != null ? title : '--KOSONG--',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(participant != null ? participant : '--KOSONG--'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
