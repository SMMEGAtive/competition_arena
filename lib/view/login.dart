import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/models/competition_data.dart';
import 'package:competition_arena/view/display_payment.dart';
import 'package:competition_arena/view/forgot_password.dart';
import 'package:competition_arena/view/manage_member.dart';
import 'package:competition_arena/view/primary_page.dart';
import 'package:competition_arena/view/register.dart';
import 'package:flutter/material.dart';
import 'package:competition_arena/http/competition_service.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  CompetitionService compService = CompetitionService();
  String text = "ddd";

  @override
  void initState() {
    compService.doGetOne(1).then((jsonData) {
      setState(() {
        text = jsonData.title;
      });
      print(jsonData.title);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarCustom(
        title: 'Login',
        hasBackButton: false,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Nama Pengguna / Email / Nomor Handphone',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ButtonPrimary(
                text: 'Login',
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrimaryPage(),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ButtonPrimary(
                text: 'Masuk tanpa Login',
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrimaryPage(),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: InkWell(
                child: Text('Lupa Password?'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPassword(),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: InkWell(
                child: Text('Belum punya Akun? Daftar'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: InkWell(
                child: Text('shortcut'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageMember(),
                    ),
                  );
                },
              ),
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
