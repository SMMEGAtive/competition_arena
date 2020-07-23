import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/view/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  TextEditingController verification = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordValidation = TextEditingController();

  int _pageStatus = 0;
  String token;
  String verificationStatus = '';
  UserService userService = UserService();

  getVerification() async {
    token = await userService.doRequestForgotPass(email.text);
  }

  verify() async {
    verificationStatus = await userService.doForgotPass(
        password.text, passwordValidation.text, email.text);
    setState(() {
      verificationStatus = verificationStatus;
    });
  }

  loadInitPage() {
    return Column(
      children: <Widget>[
        Text(
            'Masukkan Email yang anda gunakan untuk mendaftar. Kode konfirmasi akan dikirim ke email ini. Masukkan kode konfirmasi di halaman selanjutnya.'),
        TextField(
          controller: email,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        ButtonPrimary(
          text: 'Kirim',
          onPress: () {
            if (email.text.length != 0) {
              if (EmailValidator.validate(email.text)) {
                getVerification();
                setState(() {
                  _pageStatus = 1;
                });
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Tolong isi field dengan email yang benar'),
                  ),
                );
              }
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Error requesting'),
                  content: Text('Tolong isi field terlebih dahulu'),
                ),
              );
            }
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
          controller: verification,
          decoration: InputDecoration(labelText: 'Kode verifikasi'),
        ),
        ButtonPrimary(
          text: 'Kirim',
          onPress: () {
            if (verification.text.length != 0) {
              if (verification.text == token) {
                setState(() {
                  _pageStatus = 2;
                });
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error requesting'),
                    content: Text(
                        'Input verifikasi salah. Cek email anda untuk mengecek token verifikasi anda.'),
                  ),
                );
              }
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Error requesting'),
                  content: Text('Tolong isi field terlebih dahulu'),
                ),
              );
            }
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
          controller: password,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password Baru'),
        ),
        TextField(
          controller: passwordValidation,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Konfirmasi Password Baru'),
        ),
        ButtonPrimary(
          text: 'Ubah Password',
          onPress: () {
            if (password.text.length != 0 ||
                passwordValidation.text.length != 0) {
              verify();
              if (verificationStatus == 'Success') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Proses berhasil'),
                    content: Text('Password telah dirubah'),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Proses gagal'),
                    content: Text(verificationStatus),
                  ),
                );
              }
            }
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
