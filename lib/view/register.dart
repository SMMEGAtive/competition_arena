import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/view/login.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Register',
        hasBackButton: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
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
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Konfirmasi Password'),
            ),
            ButtonConfirm(
              text: 'Daftar',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
