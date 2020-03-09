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
          SettingsItem(
            text: 'Edit Profil',
            onPress: () {},
          ),
          SettingsItem(
            text: 'Ubah Password',
            onPress: () {},
          ),
          SettingsItem(
            text: 'Request Ubah Role',
            onPress: () {},
          ),
          SettingsItemSpace(),
          SettingsItem(
            text: 'Syarat dan Ketentuan',
            onPress: () {},
          ),
          SettingsItem(
            text: 'Kebijakan Privasi',
            onPress: () {},
          ),
          SettingsItem(
            text: 'Bantuan',
            onPress: () {},
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

class SettingsItem extends StatelessWidget {
  final String text;
  final Function onPress;

  SettingsItem({
    Key key,
    this.text,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1),
            bottom: BorderSide(width: 1),
          ),
        ),
        child: Text(text),
      ),
      onTap: onPress,
    );
  }
}

class SettingsItemSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
    );
  }
}
