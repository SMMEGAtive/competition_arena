import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:flutter/material.dart';

class ManageMember extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageMemberState();
}

class _ManageMemberState extends State<ManageMember> {
  final String memberType;

  _ManageMemberState({this.memberType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Members'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        backgroundColor: ColorPalette.darkBlue_300,
        elevation: 0,
      ),
      backgroundColor: ColorPalette.darkBlue_300,
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
                        'Team A',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                  ),
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
                      Text('User 1'),
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
                      Text('User 2'),
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
                IconButton(icon: Icon(Icons.close), onPressed: () {})
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
