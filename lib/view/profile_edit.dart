import 'package:charts_flutter/flutter.dart';
import 'package:competition_arena/components/app_bar_custom.dart';
import 'package:competition_arena/http/user_service.dart';
import 'package:competition_arena/models/me_data.dart';
import 'package:competition_arena/models/user_data.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  UserService userService = UserService();
  Future<UserData> user;
  TextEditingController username;
  int gender;
  TextEditingController phone;
  TextEditingController dob;
  TextEditingController email;
  TextEditingController description;
  TextEditingController address;
  TextEditingController affiliation;
  final format = DateFormat("yyyy-MM-dd");

  Future<UserData> loadUserData() async {
    MeData me = await userService.doGetLogged();
    user = userService.doGetOne(me.id);
    return user;
  }

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            child: FutureBuilder(
                future: loadUserData(),
                builder:
                    (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                  if (snapshot.hasData) {
                    username =
                        TextEditingController(text: snapshot.data.username);
                    gender = snapshot.data.gender;
                    phone = TextEditingController(text: snapshot.data.phone);
                    dob = TextEditingController(text: snapshot.data.dateOfBirth.toString());
                    email = TextEditingController(text: snapshot.data.email);
                    description =
                        TextEditingController(text: snapshot.data.description);
                    address =
                        TextEditingController(text: snapshot.data.address);
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
                            decoration:
                                InputDecoration(labelText: 'Nama Pengguna'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ListTile(
                                title: Text('Pria'),
                                leading: Radio(
                                  value: 1,
                                  groupValue: gender,
                                  onChanged: (int value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text('Wanita'),
                                leading: Radio(
                                  value: 1,
                                  groupValue: gender,
                                  onChanged: (int value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        TextField(
                          decoration:
                              InputDecoration(labelText: 'Jenis Kelamin'),
                        ),
                        TextField(
                          controller: phone,
                          decoration:
                              InputDecoration(labelText: 'Nomor Handphone'),
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
                          decoration:
                              InputDecoration(labelText: 'Tanggal Lahir'),
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
                }),
          )
        ],
      ),
    );
  }
}
