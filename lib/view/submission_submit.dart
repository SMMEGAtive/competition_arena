import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/http/submission_service.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/primary_page.dart';
import 'package:flutter/material.dart';

class SubmissionSubmit extends StatelessWidget {
  final int idCompetition;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController link = TextEditingController();
  SubmissionService submissionService = SubmissionService();

  SubmissionSubmit({this.idCompetition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Lomba: Lomba A'),
            Divider(),
            TextField(
              controller: title,
              decoration: InputDecoration(labelText: 'Judul Submisi'),
            ),
            TextField(
              controller: description,
              decoration: InputDecoration(labelText: 'Deskripsi Submisi'),
            ),
            TextField(
              controller: link,
              decoration: InputDecoration(labelText: 'Link Submisi'),
            ),
            ButtonCustom(
              text: 'simpan',
              color: ColorPalette.green_400,
              onPress: () {
                submissionService
                    .doPostOne(
                        idCompetition, link.text, title.text, description.text)
                    .then((status) {
                  if (status == 'Success') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrimaryPage(),
                      ),
                    );
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Success'),
                        content: Text('Create Success'),
                      ),
                    );
                  } else {
                    
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Create Success'),
                      ),
                    );
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
