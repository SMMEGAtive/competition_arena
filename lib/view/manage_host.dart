import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:flutter/material.dart';

class ManageMember extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageMemberState();
}

class _ManageMemberState extends State<ManageMember> {
  final String memberType;
  double num = 1;

  _ManageMemberState({this.memberType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penyelenggara'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        backgroundColor: ColorPalette.lightBlue_200,
        elevation: 0,
      ),
      backgroundColor: ColorPalette.lightBlue_200,
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Neuro',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  /* Container(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Lomba yang diikuti: Lomba B',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Status Pembayaran: Belum terverifikasi',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ), */
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Anggota Team',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: NetworkImage(
                          'https://rhythmega.s-ul.eu/PRS6dS69',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Nei'),
                    ],
                  ),
                ),
                IconButton(icon: Icon(Icons.close), onPressed: () {})
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: NetworkImage(
                          'https://rhythmega.s-ul.eu/shflVNpU',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Funny'),
                    ],
                  ),
                ),
                IconButton(icon: Icon(Icons.close), onPressed: () {})
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Opacity(
                  opacity: num,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage: NetworkImage(
                            'https://rhythmega.s-ul.eu/u3anpNEA',
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('User 3'),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: num,
                  child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          num = 0.0;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Update'),
                              content: Text('Tim berhasil diupdate'),
                            ),
                          );
                        });
                      }),
                )
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
      ),
      //MEMBER LIST
      //SearchBox
      //Member List with User and an X if member
      //User and a + if not member to add into group
    );
  }
}

class Member extends StatelessWidget {
  final int idUser;
  final String username;

  Member({this.idUser, this.username});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(
                  'https://rhythmega.s-ul.eu/shflVNpU',
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(username),
            ],
          ),
        ),
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                        children: <Widget>[
                          SimpleDialogOption(
                            child: Text('YA'),
                            onPressed: () {},
                          ),
                          SimpleDialogOption(
                            child: Text('TIDAK'),
                            onPressed: () {},
                          )
                        ],
                      ));
            })
      ],
    );
  }
}
