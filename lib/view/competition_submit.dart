import 'package:competition_arena/http/competition_service.dart';
import 'package:competition_arena/models/competition_data.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/competition.dart';
import 'package:competition_arena/view/competition_meta.dart';
import 'package:competition_arena/view/primary_page.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CompetitionSubmit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CompetitionSubmitState();
}

class _CompetitionSubmitState extends State<CompetitionSubmit> {
  TextEditingController title;
  TextEditingController description;
  TextEditingController registrationStart;
  TextEditingController registrationEnd;
  TextEditingController verificationEnd;
  TextEditingController executionStart;
  TextEditingController executionEnd;
  TextEditingController announcementDate;
  TextEditingController tags;
  final format = DateFormat("yyyy-MM-dd");
  CompetitionService compService = CompetitionService();

  createCompetition() async {

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Lomba'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              child: Icon(Icons.save),
              onTap: () {
                List<String> inputTags = tags.text.split(', ');
                compService
                    .doPostOne(
                        1,
                        title.text,
                        description.text,
                        registrationStart.text,
                        registrationEnd.text,
                        verificationEnd.text,
                        executionStart.text,
                        executionEnd.text,
                        announcementDate.text,
                        inputTags)
                    .then((message) {
                  if (message != null) {
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
                        content:
                            Text('Update Error. Make sure no field is empty'),
                      ),
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
      body: Container(
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
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorPalette.darkBlue_300,
                        ),
                        child: SvgPicture.asset(
                          'assets/pencil.svg',
                          width: 20,
                          color: ColorPalette.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompetitionMeta(),
                          ),
                        );
                      },
                    ),
                    bottom: 10,
                    right: 20,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: title,
                        decoration: InputDecoration(labelText: 'Nama Lomba'),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: description,
                        decoration:
                            InputDecoration(labelText: 'Deskripsi Lomba'),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.loose,
                            child: DateTimeField(
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                              controller: registrationStart,
                              decoration: InputDecoration(
                                  labelText: 'Mulai pendaftaran'),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: DateTimeField(
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                              controller: registrationEnd,
                              decoration: InputDecoration(
                                  labelText: 'Selesai pendaftaran'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: DateTimeField(
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        controller: verificationEnd,
                        decoration:
                            InputDecoration(labelText: 'Selesai Verifikasi'),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: DateTimeField(
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                              controller: executionStart,
                              decoration: InputDecoration(
                                  labelText: 'Mulai perlombaan'),
                            ),
                          ),
                          Expanded(
                            child: DateTimeField(
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                              controller: executionEnd,
                              decoration: InputDecoration(
                                  labelText: 'Selesai Perlombaan'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: DateTimeField(
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        controller: announcementDate,
                        decoration: InputDecoration(
                            labelText: 'Tanggal Pengumuman Pemenang'),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: tags,
                        decoration: InputDecoration(labelText: 'Tag'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}