import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/models/competition_data.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/view/chat.dart';
import 'package:competition_arena/view/competition_meta.dart';
import 'package:competition_arena/view/new_participation.dart';
import 'package:competition_arena/view/submission_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Competition extends StatefulWidget {
  final CompetitionData data;

  Competition({this.data});
  @override
  State<StatefulWidget> createState() => _CompetitionState(data: data);
}

class _CompetitionState extends State<Competition> {
  final CompetitionData data;
  MeData me = new MeData();
  var editButton;

  _CompetitionState({this.data});

  initState() {
    getPreference();
    super.initState();
    setState(() {
      getPreference();
    });
  }

  String getCompetitionStatus() {
    DateTime now = DateTime.now();

    if (now.isBefore(data.registrationStart)) {
      return 'Belum dibuka';
    } else if (now.isAfter(data.registrationStart) &&
        now.isBefore(data.registrationEnd)) {
      return 'Fase Pendaftaran: ${data.registrationStart} - ${data.registrationEnd} ';
    } else if (now.isBefore(data.verificationEnd)) {
      return 'Fase Verifikasi: Sebelum ${data.verificationEnd} ';
    } else if (now.isAfter(data.executionStart) &&
        now.isBefore(data.executionEnd)) {
      return 'Fase Pelaksanaan: ${data.executionStart} - ${data.executionEnd}';
    } else if (now.isAfter(data.executionEnd) &&
        now.isBefore(data.announcementDate)) {
      return 'Menunggu pengumuman: ${data.announcementDate} ';
    } else if (now.isAfter(data.announcementDate)) {
      return 'Selesai';
    } else {
      return 'Tidak diketahui';
    }
  }

  getPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserService service = new UserService();
    me = await service.doGetLogged();
    print(me.role.toString());
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      if (me.role == 1 || me.role == 3) {
        print('it does went thru here');
        editButton = Positioned(
          child: InkWell(
            child: SvgPicture.asset(
              'assets/pencil.svg',
              width: 20,
              color: ColorPalette.black,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompetitionMeta(data: data),
                ),
              );
            },
          ),
          top: 10,
          right: 50,
        );
        print('it does went thru here');
      } else {
        print('why does it went here');
        editButton = Container();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        hasBackButton: true,
        title: 'Lomba 1',
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SvgPicture.asset('assets/bubble.svg', width: 30.0),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
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
                        data.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      bottom: 60,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        data.idHost.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 40,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        getCompetitionStatus(),
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 20,
                      left: 15,
                    ),
                    Positioned(
                      child: InkWell(
                        child: Icon(Icons.list),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubmissionList(
                                idCompetition: data.idCompetition,
                              ),
                            ),
                          );
                        },
                      ),
                      top: 10,
                      right: 15,
                    ),
                    (editButton != null ? editButton : Container()),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Text(data.description),
                ),
              )
            ],
          ),
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: ColorPalette.black, width: 1.0)),
                  color: ColorPalette.white,
                ),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                child: ButtonCustom(
                  color: ColorPalette.green_200,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewParticipation(
                          idCompetition: data.idCompetition,
                          me: me,
                        ),
                      ),
                    );
                  },
                  text: 'Daftar',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
