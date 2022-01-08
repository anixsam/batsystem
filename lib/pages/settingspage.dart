import 'package:batsystem/Animation/FadeAnimation.dart';
import 'package:batsystem/loginscreen.dart';
//import 'package:batsystem/controll/splash2.dart';
import 'package:batsystem/pages/devices.dart';
import 'package:batsystem/pages/regpage.dart';
import 'package:batsystem/services/authentication_service.dart';
import 'package:batsystem/services/emailreset.dart';
import 'package:batsystem/services/passresetsettings.dart';
import 'package:batsystem/services/phonenumberreset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/authentication_service.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    ));
DocumentReference users =
    // ignore: deprecated_member_use
    FirebaseFirestore.instance.collection('users').document(user.uid);

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser == null) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    return Scaffold(
        //appBar: AppBar(title: Text("Settings")),
        backgroundColor: Colors.cyan[700],
        body: StreamBuilder<DocumentSnapshot>(
            stream: users.snapshots(),
            builder: (context, snapshot) {
              return Scaffold(
                  // ignore: deprecated_member_use
                  body: Center(
                child: Container(
                    color: Colors.cyan[700],
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.0,
                            Container(
                              height: 70,
                              color: Colors.cyan[600],
                              child: Row(children: <Widget>[
                                SizedBox(width: 10),
                                FadeAnimation(
                                    0.5,
                                    Text("Settings",
                                        //snapshot.data['displayName']
                                        //.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))),
                                SizedBox(width: 270),
                                Image(
                                  alignment: Alignment.topRight,
                                  height: 35,
                                  width: 35,
                                  image: AssetImage('images/settings.png'),
                                ),
                              ]),
                            )),
                        SizedBox(height: 20),
                        FadeAnimation(
                            0.7,
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 500,
                                child: Text(
                                  "  Change Password",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              onTap: () async {
                                var navigationResult = await Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            PassResetSettings()));
                              },
                            )),
                        FadeAnimation(
                            0.9,
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 500,
                                child: Text(
                                  "  Change Email",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              onTap: () async {
                                var navigationResult = await Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => EmailReset()));
                              },
                            )),
                        FadeAnimation(
                            1.1,
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 500,
                                child: Text(
                                  "  PhoneReset",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              onTap: () async {
                                var navigationResult = await Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => PhoneReset()));
                              },
                            )),
                        FadeAnimation(
                            1.1,
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 500,
                                child: Text(
                                  "  Devices",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              onTap: () async {
                                var navigationResult = await Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => Devices()));
                              },
                            )),
                        FadeAnimation(
                            1.2,
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 500,
                                child: Text(
                                  "  Register Device",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              onTap: () async {
                                var navigationResult = await Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => RegPage()));
                              },
                            )),
                        SizedBox(height: 200),
                        FadeAnimation(
                          1.3,
                          InkWell(
                              child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 50,
                                  width: 500,
                                  child: Row(children: <Widget>[
                                    Text(
                                      "  Logout",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(width: 300),
                                    Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                  ])),
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                //context.read<AuthenticationService>().signOut();
                              }),
                        )
                      ],
                    )),
              ));
            }));
  }
}
