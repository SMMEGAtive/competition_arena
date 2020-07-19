import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/components/comment_section.dart';
import 'package:competition_arena/http/comment_service.dart';
import 'package:competition_arena/http/participant_service.dart';
import 'package:competition_arena/http/participation_service.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/models/comment_data.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/models/user_data.dart';
import 'package:competition_arena/view/primary_page.dart';
import 'package:competition_arena/view/submission_display.dart';
import 'package:flutter/material.dart';

class NewParticipation extends StatefulWidget {
  final int idCompetition;
  final MeData me;
  NewParticipation({this.idCompetition, this.me});

  @override
  State<StatefulWidget> createState() =>
      _NewParticipationState(idCompetition: idCompetition, me: me);
}

class _NewParticipationState extends State<NewParticipation> {
  final int idCompetition;
  final MeData me;
  UserService userService = UserService();
  ParticipantService participantService = ParticipantService();
  ParticipationService participationService = ParticipationService();

  TextEditingController list = TextEditingController();
  TextEditingController name = TextEditingController();
  Future<List<UserData>> users;

  int dropdown1;
  int dropdown2;
  int dropdown3;

  Future<List<UserData>> getUsers() {
    users = userService.doGetList();
    return users;
  }

  _NewParticipationState({this.idCompetition, this.me});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          /* FutureBuilder(future: getUsers(), builder: (BuildContext context, AsyncSnapshot<List<UserDara>> snapshot) {
            if(snapshot.hasData) {
              DropdownButton(value: dropdown1, items: snapshot.data.map<DropDownMenuItem<int>>((value) {return DropDownMenuItem<int>(value: value, child: Text(value))}), onChanged: null)
            }
          }), */
          TextField(
            decoration: InputDecoration(labelText: 'Nama tim'),
            maxLines: 1,
            controller: name,
          ),
          TextField(
            decoration: InputDecoration(
                labelText:
                    'Isi Dengan ID anggota lain di dalam tim dan pisah dengan koma. Jika sendiri, kosongkan saja'),
            maxLines: 4,
            controller: list,
          ),
          ButtonCustom(
            text: 'Send',
            onPress: () {
              if (name.text.length != 0) {
                if (list.text.length != 0) {
                  List<String> users = list.text.split(',');
                  List<int> userID = [];
                  userID.add(me.id);
                  for (int i = 0; i < users.length; i++) {
                    userID.add(int.parse(users[i]));
                  }
                  participantService.doPostOne(name.text, userID).then((data) {
                    participationService
                        .doPostOne(data, idCompetition)
                        .then((status) {
                      if (status != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrimaryPage(),
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Berhasil'),
                            content: Text('Anda sudah terdaftar'),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Terdapat error'),
                          ),
                        );
                      }
                    });
                  });
                } else {
                  participantService.doPostOne(name.text, [me.id]).then((data) {
                    participationService
                        .doPostOne(data, idCompetition)
                        .then((status) {
                      if (status != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrimaryPage(),
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Berhasil'),
                            content: Text('Anda sudah terdaftar'),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Terdapat error'),
                          ),
                        );
                      }
                    });
                  });
                }
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Tolong isi field'),
                  ),
                );
              }
            },
          )
        ],
      )),
    );
  }
}
