//import 'package:batsystem/authentication_service.dart';
import 'package:batsystem/homepage.dart';
import 'package:batsystem/services/authentication_service.dart';
import 'package:batsystem/services/passreset.dart';
import 'package:batsystem/sign-up.dart';
//import 'package:batsystem/sign-up.dart';
//import 'package:batsystem/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

import 'Splash Screen/splashhomepage.dart';
import 'Splash Screen/splashlogin.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ));

class LoginScreen extends StatelessWidget {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    // if (firebaseUser == null) {
    //   Navigator.push(
    //       context, new MaterialPageRoute(builder: (context) => FirstScreen()));
    // }

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
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 0,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Welcome Back",
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
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          labelText: 'Password',
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
                            1.5,
                            InkWell(
                                onTap: () async {
                                  var navigationResult = await Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => PassReset()));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.grey),
                                ))),
                        SizedBox(
                          height: 20,
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
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () async {
                                      try {
                                        await _auth.signInWithEmailAndPassword(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim());
                                        return Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    FirstScreen()));
                                      } on FirebaseAuthException catch (e) {
                                        return e.message;
                                      }
                                      // context
                                      //     .read<AuthenticationService>()
                                      //     .signIn(
                                      //         email:
                                      //             emailController.text.trim(),
                                      //         password: passwordController.text
                                      //             .trim());
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
                          child: Text("New ? Sign-Up"),
                          onTap: () async {
                            var navigationResult = await Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => SignupScreen()));

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
}
