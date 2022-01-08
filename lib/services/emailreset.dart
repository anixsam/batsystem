import 'package:batsystem/pages/home-page.dart';
import 'package:batsystem/pages/settingspage.dart';
//import 'package:batsystem/services/auth.dart';
import 'package:batsystem/services/authentication_service.dart';
import 'package:batsystem/loginscreen.dart';
//import 'package:batsystem/sign-up.dart';
import 'package:batsystem/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;
DocumentReference users =
    // ignore: deprecated_member_use
    FirebaseFirestore.instance.collection('users').document(user.uid);
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmailReset(),
    ));

class EmailReset extends StatelessWidget {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            // ignore: deprecated_member_use
            stream: users.snapshots(),
            builder: (context, snapshot) {
              String vehicleNo = snapshot.data['vehicleno'];
              String pass = snapshot.data['Password'];
              String phno = snapshot.data['PhoneNumber'];
              String name = snapshot.data['displayName'];
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.topCenter, colors: [
                  Color.fromRGBO(108, 198, 192, 10),
                  Color.fromRGBO(108, 198, 192, 8),
                  Color.fromRGBO(108, 198, 192, 0)
                ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                              1,
                              Text(
                                "Email Change",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          FadeAnimation(
                              1.3,
                              Text(
                                "Enter Your New Email",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 05,
                                ),
                                FadeAnimation(
                                    1.4,
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    108, 198, 192, .3),
                                                blurRadius: 20,
                                                offset: Offset(0, 10))
                                          ]),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextField(
                                              // ignore: missing_return
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                  labelText: 'Email',
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 80,
                                ),
                                FadeAnimation(
                                    1.6,
                                    Container(
                                      height: 50,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.cyan[700]),
                                      child: ButtonTheme(
                                        minWidth: 210,
                                        child: RaisedButton(
                                            color: Colors.cyan[700],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Change Your Email",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              passreset(context, vehicleNo,
                                                  pass, phno, name);
                                            }),
                                      ),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  child: Text("Back To Login Page"),
                                  onTap: () async {
                                    var navigationResult = await Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));

                                    if (navigationResult == 'from_back') {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    'Navigation from back'),
                                              ));
                                    } else if (navigationResult ==
                                        'from_button') {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    'Navigation from button'),
                                              ));
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  signInWithGoogle() {}

  void passreset(BuildContext context, String vehicleNo, String pass,
      String phno, String name) {
    var alertDialog = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 6,
      title:
          Text("Password Reset Email Sent To " + emailController.text.trim()),
      actions: [
        Row(children: <Widget>[
          FlatButton(
              onPressed: () {
                changeEmail(
                  email: emailController.text.trim(),
                  vehicleno: vehicleNo,
                  password: pass,
                  phoneno: phno,
                  fullName: name,
                );
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => FirstScreen()));
              },
              child: Text("Confirm")),
          FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => EmailReset()));
              },
              child: Text("Cancel")),
        ])
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Future<String> changeEmail(
      {String email,
      String password,
      String fullName,
      String vehicleno,
      String phoneno}) async {
    User updateUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        // ignore: deprecated_member_use
        .document(auth.currentUser.uid)
        .set({
      'uid': uid,
      'email': email,
      'displayName': fullName,
      'Password': password,
      'vehicleno': vehicleno,
      'PhoneNumber': phoneno
    });
    updateUser.updateEmail(email);
  }
}
