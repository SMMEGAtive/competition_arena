import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/view/login.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  String token;
  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  int _pageStatus = 0;
  loadInitPage() {
    return Column(
      children: <Widget>[
        Text(
            'Masukkan Email yang anda gunakan untuk mendaftar. Kode konfirmasi akan dikirim ke email ini. Masukkan kode konfirmasi di halaman selanjutnya.'),
        TextField(
          decoration: InputDecoration(labelText: 'Email'),
        ),
        ButtonPrimary(
          text: 'Kirim',
          onPress: () {
            setState(() {
              _pageStatus = 1;
            });
          },
        )
      ],
    );
  }

  loadVerifPage() {
    return Column(
      children: <Widget>[
        Text(
            'Masukkan Kode verifikasi yang telah dikirim masuk ke dalam email ****tive.m****@*****.**m .'),
        TextField(
          decoration: InputDecoration(labelText: 'Kode verifikasi'),
        ),
        ButtonPrimary(
          text: 'Kirim',
          onPress: () {
            setState(() {
              _pageStatus = 2;
            });
          },
        )
      ],
    );
  }

  loadRenewalPage() {
    return Column(
      children: <Widget>[
        Text('Masukkan Password baru yang akan anda gunakan.'),
        TextField(
          decoration: InputDecoration(labelText: 'Password Baru'),
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Konfirmasi Password Baru'),
        ),
        ButtonPrimary(
          text: 'Ubah Password',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget view;
    if (_pageStatus == 0) {
      view = loadInitPage();
    } else if (_pageStatus == 1) {
      view = loadVerifPage();
    } else if (_pageStatus == 2) {
      view = loadRenewalPage();
    } else {
      view = loadInitPage();
    }
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Lupa Password',
        hasBackButton: true,
      ),
      body: Container(
        child: view,
        padding: EdgeInsets.all(15),
      ),
    );
  }
}
