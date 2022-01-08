import 'package:batsystem/Animation/FadeAnimation.dart';
import 'package:batsystem/controll/fingerprintauth.dart';
import 'package:batsystem/homepage.dart';
import 'package:batsystem/pages/emergency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

String model = "";
String serialno = "";
String brand = "";
User user = FirebaseAuth.instance.currentUser;
final dbRef = FirebaseDatabase.instance.reference();
bool value = false;
bool lockstate = false;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Devices(),
    ));

class Devices extends StatefulWidget {
  bool authcheck = false;

  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<Devices> {
  String authorized = "Not authorized";

  bool _canCheckBiometric;
  List<BiometricType> _availableBiometric;
  LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    //read_statebackup('enginestate');
    read_state("enginestate");
    dbRef.child('currentuser').set({
      'id': user.uid,
      'name': user.displayName,
    });
  }

  Future<String> read_state(String name) {
    dbRef.child(user.uid + "/Devices/").once().then((DataSnapshot data) {
      Map list = data.value;
      print(list);
      //return list[name];

      setState(() {
        model = list["model"].toString();
        brand = list["brand"].toString();
        serialno = list["serialno"].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[900],
          title: Text(
            "Devices",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.cyan[700],
        body: Column(children: <Widget>[
          SizedBox(
            height: 100,
          ),
          FadeAnimation(
            0.2,
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(child: Icon(Icons.device_unknown, size: 100)),
            ),
          ),
          SizedBox(height: 50),
          Center(
              child: Column(
            children: <Widget>[
              FadeAnimation(
                  0.7,
                  Text(serialno,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 20),
              FadeAnimation(
                  0.9,
                  Row(children: <Widget>[
                    SizedBox(width: 100),
                    Container(
                        child: Icon(Icons.branding_watermark,
                            color: Colors.white, size: 35)),
                    SizedBox(width: 5),
                    Center(
                        child: Text(brand,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ))),
                  ])),
              SizedBox(height: 20),
              FadeAnimation(
                  1.1,
                  Row(children: [
                    SizedBox(width: 110),
                    Icon(Icons.motorcycle_rounded,
                        color: Colors.white, size: 40),
                    SizedBox(width: 5),
                    Text(model,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        )),
                  ])),
              SizedBox(height: 20)
            ],
          ))
        ]));
  }
}
