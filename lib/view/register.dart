import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/view/login.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController passConfirm = TextEditingController();
  TextEditingController dob = TextEditingController();

  UserService userService = UserService();

  final format = DateFormat("yyyy-MM-dd");
  int gender;

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
              controller: username,
              decoration: InputDecoration(labelText: 'Nama Pengguna'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: gender,
                            onChanged: (int value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          Text('Pria')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: gender,
                            onChanged: (int value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          Text('Wanita')
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            TextField(
              controller: phone,
              decoration: InputDecoration(labelText: 'Nomor Handphone'),
            ),
            DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              controller: dob,
              decoration: InputDecoration(labelText: 'Tanggal Lahir'),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: pass,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: passConfirm,
              decoration: InputDecoration(labelText: 'Konfirmasi Password'),
            ),
            ButtonConfirm(
              text: 'Daftar',
              onPress: () {
                userService
                    .doRegister(username.text, pass.text, passConfirm.text,
                        email.text, phone.text, gender, dob.text)
                    .then((status) {
                  if (status == 'Registration Success') {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Berhasil'),
                        content: Text(status),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  } else if (status == 'Registration Failed') {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Gagal'),
                        content: Text(status),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('????'),
                        content: Text(status),
                      ),
                    );
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
