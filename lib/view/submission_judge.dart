import 'package:flutter/material.dart';

class SubmissionJudge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              minLines: 1,
              maxLines: 3,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Kirim'),
            ),
            Text('Komentar Juri lain'),
            Text('Komentar Juri lain'),
          ],
        ),
      ),
    );
  }
}
