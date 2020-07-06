import 'package:flutter/material.dart';

class SubmissionSubmit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Lomba: Lomba A'),
            Divider(),
            TextField(
              decoration: InputDecoration(labelText: 'Judul Submisi'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Deskripsi Submisi'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Link Submisi'),
            ),
          ],
        ),
      ),
    );
  }
}
