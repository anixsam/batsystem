import 'package:batsystem/Animation/FadeAnimation.dart';
import 'package:batsystem/controll/firesore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:batsystem/pages/home-page.dart';

final dbRef = FirebaseDatabase.instance.reference();
String vehicleno;
// ignore: deprecated_member_use
DocumentReference users =
    // ignore: deprecated_member_use
    FirebaseFirestore.instance.collection('users').document(user.uid);
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserPage(),
    ));

// ignore: must_be_immutable
class UserPage extends StatefulWidget {
  var myuser = FirestoreService(user);
  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<UserPage> {
  @override
  void initState() {
    //read_statebackup('enginestate');
    read_state("");
    dbRef.child(user.uid + "/Details/").update({
      'email': user.email,
    });

    dbRef.child('currentuser').set({
      'id': user.uid,
      'name': user.displayName,
    });
  }

  Future<String> read_state(String name) {
    dbRef.child(user.uid + "/Details/").once().then((DataSnapshot data) {
      Map list = data.value;
      print(list);
      //return list[name];

      setState(() {
        name = user.displayName;
        phoneno = list["phoneno"].toString();
        email = list["email"].toString();
        vehicleno = list["vehicleno"].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initState();
    print(name);
    print(email);

    return Scaffold(
        backgroundColor: Colors.cyan[700],
        //appBar: AppBar(title: Text("hello")),
        body: Column(children: <Widget>[
          SizedBox(
            height: 150,
          ),
          FadeAnimation(
            0.2,
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                  child: Image(
                height: 60,
                width: 60,
                image: AssetImage('images/logouser.png'),
              )),
            ),
          ),
          SizedBox(height: 50),
          Center(
              child: Column(
            children: <Widget>[
              FadeAnimation(
                  0.7,
                  Text(user.displayName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              FadeAnimation(
                  0.9,
                  Row(children: [
                    SizedBox(width: 70),
                    Image(
                      height: 40,
                      image: AssetImage('images/Logomailwhite.png'),
                    ),
                    SizedBox(width: 5),
                    Text(email,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ])),
              SizedBox(height: 20),
              FadeAnimation(
                  1.1,
                  Row(children: [
                    SizedBox(width: 134),
                    Image(
                      height: 20,
                      image: AssetImage('images/logophonewhite.png'),
                    ),
                    SizedBox(width: 5),
                    Text(phoneno,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ])),
              SizedBox(height: 20),
              FadeAnimation(
                  1.3,
                  Row(children: [
                    SizedBox(width: 125),
                    Image(
                      height: 40,
                      image: AssetImage('images/logobikewhite.png'),
                    ),
                    SizedBox(width: 5),
                    Text(vehicleno,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ])),
            ],
          ))
        ]));
  }
}
