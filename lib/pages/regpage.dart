//import 'package:batsystem/services/auth.dart';
import 'package:batsystem/Animation/FadeAnimation.dart';
import 'package:batsystem/homepage.dart';
import 'package:batsystem/pages/settingspage.dart';
import 'package:batsystem/services/authentication_service.dart';
import 'package:batsystem/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

final dbRef = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegPage(),
    ));

class RegPage extends StatelessWidget {
  final TextEditingController serialnoController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
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
                          "Register Your Device",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        )),
                    SizedBox(
                      height: 2,
                    ),
                    FadeAnimation(
                        1.3,
                        Text(
                          user.displayName,
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
                          child: Column(children: <Widget>[
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
                                      height: 70,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        // ignore: missing_return
                                        controller: serialnoController,
                                        decoration: InputDecoration(
                                            labelText:
                                                'Serial No Of the Device',
                                            labelStyle:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        controller: brandController,
                                        decoration: InputDecoration(
                                            labelText: 'Brand of the bike',
                                            labelStyle:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        controller: modelController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                            labelText: 'Bike model name',
                                            labelStyle:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    FadeAnimation(
                                        1.5,
                                        Text(
                                          "",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    FadeAnimation(
                                        1.6,
                                        Container(
                                            height: 50,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 50),
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
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Text(
                                                    "Register",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    showdialog(context);
                                                    String serialno =
                                                        serialnoController.text
                                                            .trim();
                                                    String brand =
                                                        brandController.text
                                                            .trim();
                                                    String model =
                                                        modelController.text
                                                            .trim();
                                                    setdata(
                                                        serialno, brand, model);
                                                  }),
                                            ))),
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
                                      child: Text(
                                          "Already have an account? Login Here"),
                                      onTap: () async {
                                        var navigationResult =
                                            await Navigator.push(
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
                          ]))),
                ),
              )
            ])));
  }
}

Future<String> setdata(String serial, String brand, String model) {
  final dbRef = FirebaseDatabase.instance.reference();
  dbRef
      .child(user.uid + "/Devices/")
      .set({"serialno": serial, "brand": brand, "model": model});
  dbRef.child(user.uid + "/Alarm/").set({"status": false});
  dbRef.child(user.uid + "/findmydevice/").set({"status": false});
}

Future<String> usersignUp(
    {String email,
    String password,
    String fullName,
    String vehicleno,
    String phoneno}) async {
  try {
    User updateUser = FirebaseAuth.instance.currentUser;
    updateUser.updateProfile(displayName: fullName);
    FirebaseFirestore.instance
        .collection('users')
        // ignore: deprecated_member_use
        .document(auth.currentUser.uid)
        .set({
      'displayName': fullName,
      'uid': uid,
      'vehicleno': vehicleno,
      'email': email,
      'Password': password,
      'PhoneNumber': phoneno
    });
    return "Signed in";
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
}

void showdialog(BuildContext context) {
  var alertDialog = AlertDialog(
    backgroundColor: Colors.cyan[900],
    elevation: 6,
    title: Text("Registration Complete", style: TextStyle(color: Colors.white)),
    actions: [
      Row(children: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => FirstScreen()));
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
