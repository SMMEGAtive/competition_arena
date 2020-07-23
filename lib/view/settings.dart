import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/components/button_custom.dart';
import 'package:competition_arena/http/api_service.dart';
import 'package:competition_arena/http/role_service.dart';
import 'package:competition_arena/http/role_service.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/models/user_data.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:competition_arena/values/gFunction.dart';
import 'package:competition_arena/view/login.dart';
import 'package:competition_arena/view/primary_page.dart';
import 'package:competition_arena/view/profile.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserService userService = UserService();
  RoleService roleService = RoleService();
  ApiServices api = ApiServices();
  Future<UserData> user;
  TextEditingController username;
  int gender;
  TextEditingController phone;
  TextEditingController dob;
  TextEditingController email;
  TextEditingController description;
  TextEditingController address;
  TextEditingController affiliation;
  TextEditingController oldPass;
  TextEditingController newPass;
  TextEditingController newPassValidation;
  final format = DateFormat("yyyy-MM-dd");
  String verificationStatus;

  Future<UserData> loadUserData() async {
    MeData me = await userService.doGetLogged();
    user = userService.doGetOne(me.id);
    return user;
  }

  Future<void> verify() async {
    verificationStatus = await userService.doChangePass(
        oldPass.text, newPass.text, newPassValidation.text);
  }

  Widget view;
  int _currentState = 0;
  loadInitSettings() {
    return Container(
      child: Column(
        children: <Widget>[
          SettingsItem(
            text: 'Edit Profil',
            onPress: () {
              setState(() {
                _currentState = 1;
              });
            },
          ),
          SettingsItem(
            text: 'Ubah Password',
            onPress: () {
              setState(() {
                _currentState = 2;
              });
            },
          ),
          SettingsItem(
            text: 'Request Ubah Role',
            onPress: () {
              setState(() {
                _currentState = 3;
              });
            },
          ),
          SettingsItemSpace(),
          SettingsItem(
            text: 'Syarat dan Ketentuan',
            onPress: () {
              setState(() {
                _currentState = 4;
              });
            },
          ),
          SettingsItem(
            text: 'Kebijakan Privasi',
            onPress: () {
              setState(() {
                _currentState = 5;
              });
            },
          ),
          SettingsItem(
            text: 'Bantuan',
            onPress: () {
              setState(() {
                _currentState = 6;
              });
            },
          ),
          SettingsItemSpace(),
          SettingsItem(
            text: 'Keluar',
            onPress: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text('Konfirmasi'),
                      content: SingleChildScrollView(
                        child: Text('Apakah anda yakin ingin log out?'),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Ya'),
                          onPressed: () {
                            clearLog();
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                        ),
                        FlatButton(
                          child: Text('Tidak'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  loadProfileEdit() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: loadUserData(),
          builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
            if (snapshot.hasData) {
              username = TextEditingController(text: snapshot.data.username);
              gender = snapshot.data.gender;
              phone = TextEditingController(text: snapshot.data.phone);
              dob = TextEditingController(
                  text: snapshot.data.dateOfBirth.toString());
              email = TextEditingController(text: snapshot.data.email);
              description =
                  TextEditingController(text: snapshot.data.description);
              address = TextEditingController(text: snapshot.data.address);
              affiliation =
                  TextEditingController(text: snapshot.data.affiliation);
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(labelText: 'Nama Pengguna'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text('Jenis Kelamin'),
                        ),
                        Container(
                          child: Row(
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
                          ),
                        ),
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
                    controller: description,
                    decoration: InputDecoration(labelText: 'Deskripsi'),
                  ),
                  TextField(
                    controller: address,
                    decoration: InputDecoration(labelText: 'Alamat'),
                  ),
                  TextField(
                    controller: affiliation,
                    decoration: InputDecoration(labelText: 'Afiliasi'),
                  ),
                  ButtonCustom(
                    text: 'Simpan',
                    onPress: () {
                      userService
                          .doUpdateOne(
                              username.text,
                              description.text,
                              email.text,
                              phone.text,
                              address.text,
                              affiliation.text,
                              gender,
                              dob.text)
                          .then((verificationStatus) {
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
                              content: Text('Update berhasil'),
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
                      });
                    },
                    color: ColorPalette.green_300,
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  loadPasswordChange() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: oldPass,
            obscureText: true,
            decoration:
                InputDecoration(labelText: 'Password yang saat ini digunakan'),
          ),
          TextField(
            controller: newPass,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password Baru'),
          ),
          TextField(
            controller: newPassValidation,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Input Password Baru ulang'),
          ),
          ButtonCustom(
            color: ColorPalette.darkBlue_400,
            text: 'Simpan',
            onPress: () {
              if (oldPass.text.length != 0 ||
                  newPass.text.length != 0 ||
                  newPassValidation.text.length != 0) {
                userService
                    .doChangePass(
                        oldPass.text, newPass.text, newPassValidation.text)
                    .then((verificationStatus) {
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
                });
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Proses gagal'),
                    content: Text('Isi semua field terlebih dahulu'),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  loadRoleChange() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Dengan menekan tombol ini, anda akan melakukan permintaan elevasi peran dari pengguna biasa menjadi seorang penyelenggara lomba',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ButtonCustom(
            color: ColorPalette.darkBlue_500,
            text: 'Lakukan permintaan',
            onPress: () {
              roleService.doPostOne().then((data) {
                if (data != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrimaryPage(),
                    ),
                  );
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Berhasil'),
                      content: Text('Request berhasil'),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Error'),
                    ),
                  );
                }
              });
            },
          )
        ],
      ),
    );
  }

  loadKetentuan() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Ketentuan A'),
          Text('Ketentuan B'),
          Text('Ketentuan C'),
          Text('Ketentuan D'),
        ],
      ),
    );
  }

  loadKebijakan() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Kebijakan A'),
          Text('Kebijakan B'),
          Text('Kebijakan C'),
          Text('Kebijakan D'),
        ],
      ),
    );
  }

  loadBantuan() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Bantuan A'),
          Text('Bantuan B'),
          Text('Bantuan C'),
          Text('Bantuan D'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentState == 0) {
      view = loadInitSettings();
    } else if (_currentState == 1) {
      view = loadProfileEdit();
    } else if (_currentState == 2) {
      view = loadPasswordChange();
    } else if (_currentState == 3) {
      view = loadRoleChange();
    } else if (_currentState == 4) {
      view = loadKetentuan();
    } else if (_currentState == 5) {
      view = loadKebijakan();
    } else if (_currentState == 6) {
      view = loadBantuan();
    } else {
      view = loadInitSettings();
    }
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Profil Pengguna',
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FutureBuilder(
                    future: loadUserData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<UserData> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new NetworkImage(
                                (snapshot.data.avatarPath != null
                                    ? api.base_url +
                                        snapshot.data.avatarPath.substring(8)
                                    : 'https://rhythmega.s-ul.eu/lBdht0Rt'),
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Column(
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            )
                          ],
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(),
                              width: 60,
                              height: 60,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            )
                          ],
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    builder: (BuildContext context,
                        AsyncSnapshot<UserData> snapshot) {
                      if (snapshot.hasData) {
                        String role = '';
                        if (snapshot.data.role == 1) {
                          role = 'Admin';
                        } else if (snapshot.data.role == 2) {
                          role = 'Penyelenggara Lomba';
                        } else if (snapshot.data.role == 3) {
                          role = 'Pengguna';
                        } else {
                          role = 'visitor';
                        }
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                (snapshot.data.username != null
                                    ? snapshot.data.username
                                    : 'Test'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(role),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Column(
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            )
                          ],
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(),
                              width: 60,
                              height: 60,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            )
                          ],
                        );
                      }
                    },
                    future: loadUserData(),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            view
          ],
        ),
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
