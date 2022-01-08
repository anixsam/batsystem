import 'package:batsystem/loginscreen.dart';
import 'package:batsystem/pages/regpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:batsystem/sign-up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  void showdialog(BuildContext context) {
    var alertDialog = AlertDialog(
      backgroundColor: Colors.cyan[900],
      elevation: 6,
      title:
          Text("Registration Complete", style: TextStyle(color: Colors.white)),
      actions: [
        Row(children: <Widget>[
          FlatButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
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

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp(
      {String email, String password, BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
