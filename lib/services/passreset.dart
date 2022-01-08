import 'package:batsystem/pages/home-page.dart';
//import 'package:batsystem/services/auth.dart';
import 'package:batsystem/services/authentication_service.dart';
import 'package:batsystem/loginscreen.dart';
//import 'package:batsystem/sign-up.dart';
import 'package:batsystem/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:batsystem/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PassReset(),
    ));

class PassReset extends StatelessWidget {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
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
                        "Reset Password",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 0,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Enter Your Email",
                        style: TextStyle(color: Colors.white, fontSize: 18),
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
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(108, 198, 192, .3),
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
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      // ignore: missing_return
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle:
                                              TextStyle(color: Colors.grey)),
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
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.cyan[700]),
                              child: ButtonTheme(
                                minWidth: 210,
                                child: RaisedButton(
                                    color: Colors.cyan[700],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Text(
                                      "Reset Password",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      resetPassword(
                                        email: emailController.text.trim(),
                                      );
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
                                    builder: (context) => LoginScreen()));

                            if (navigationResult == 'from_back') {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Navigation from back'),
                                      ));
                            } else if (navigationResult == 'from_button') {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Navigation from button'),
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
      ),
    );
  }

  signInWithGoogle() {}

  void passreset(BuildContext context) {
    var alertDialog = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 6,
      title:
          Text("Password Reset Email Sent To " + emailController.text.trim()),
      actions: [
        Row(children: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text("Ok"))
        ])
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

Future<String> resetPassword({String email}) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  print("Passwordreset mail sent");
}
