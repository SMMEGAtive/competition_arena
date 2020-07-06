import 'package:competition_arena/view/submission_display.dart';
import 'package:flutter/material.dart';

class SubmissionList extends StatelessWidget {
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
            Divider(thickness: 2,),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SubmissionListItem(
                      title: 'A',
                      participant: 'Partisipan A',
                      imgUrl: 'https://rhythmega.s-ul.eu/y4E3hmm6',
                    ),
                    SubmissionListItem(
                      participant: 'Partisipan B',
                      imgUrl: 'https://rhythmega.s-ul.eu/y4E3hmm6',
                    ),
                    SubmissionListItem(
                      title: 'C',
                      participant: 'Partisipan C',
                    ),
                    SubmissionListItem(
                      title: 'D',
                      imgUrl: 'https://rhythmega.s-ul.eu/y4E3hmm6',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubmissionListItem extends StatelessWidget {
  final String title;
  final String participant;
  final String imgUrl;

  SubmissionListItem({this.title, this.participant, this.imgUrl});

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
                builder: (context) => SubmissionDisplay(),
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
