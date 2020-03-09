import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  loadInitSettings() {
    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2),
                  bottom: BorderSide(width: 1),
                ),
              ),
              child: Text('Edit Profil'),
            ),
          ),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2),
                  bottom: BorderSide(width: 1),
                ),
              ),
              child: Text('Ubah Password'),
            ),
          ),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2),
                  bottom: BorderSide(width: 1),
                ),
              ),
              child: Text('Request Ubah Role'),
            ),
          ),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2),
                  bottom: BorderSide(width: 2),
                ),
              ),
              child: Text('Syarat dan Ketentuan'),
            ),
          ),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2),
                  bottom: BorderSide(width: 2),
                ),
              ),
              child: Text('Kebijakan Privasi'),
            ),
          ),
          InkWell(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2),
                  bottom: BorderSide(width: 2),
                ),
              ),
              child: Text('Bantuan'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget view;
    view = loadInitSettings();
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Profil Pengguna',
        hasBackButton: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                          'https://rhythmega.s-ul.eu/lBdht0Rt'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('MEGAtive'),
                      Text('Administrator'),
                    ],
                  ),
                )
              ],
            ),
          ),
          view
        ],
      ),
    );
  }
}
