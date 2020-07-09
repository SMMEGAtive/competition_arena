import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/view/profile_edit.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget view;
  loadInitSettings() {
    return Container(
      child: Column(
        children: <Widget>[
          SettingsItem(
            text: 'Edit Profil',
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileEdit(),
                ),
              );
            },
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
          SettingsItemSpace(),
          SettingsItem(
            text: 'Keluar',
            onPress: () {},
          ),
        ],
      ),
    );
  }

  loadProfileEdit() {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Nama Pengguna'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Jenis Kelamin'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Nomor Handphone'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Tanggal Lahir'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Deskripsi'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Alamat'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Afiliasi'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
