import 'package:competition_arena/components/comment_section.dart';
import 'package:flutter/material.dart';

class SubmissionDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.15,
                      child: Container(
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(
                                'https://rhythmega.s-ul.eu/y4E3hmm6'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        'Judul Submisi',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      bottom: 80,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        'Partisipan',
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 60,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        'Tanggal Submit',
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 40,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        'Tanggal Update',
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 20,
                      left: 15,
                    ),
                  ],
                ),
              ),
              Divider(),
              Text('Skor'),
              Divider(),
              Text('Deskripsi'),
              Divider(),
              CommentSection()
            ],
          ),
        ),
      ),
    );
  }
}
