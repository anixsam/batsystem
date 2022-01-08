import 'package:batsystem/Animation/FadeAnimation.dart';
import 'package:batsystem/controll/fingerprintauth.dart';
import 'package:batsystem/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:local_auth/local_auth.dart';

User user = FirebaseAuth.instance.currentUser;
final dbRef = FirebaseDatabase.instance.reference();
bool value = false;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Emergency(),
    ));

class Emergency extends StatefulWidget {
  bool authcheck = false;

  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<Emergency> {
  //void initState() {dbRef.child(user.uid+"/Variables").update({'emergencyeng':true,'emergencyign': true});}
  String authorized = "Not authorized";

  bool _canCheckBiometric;
  List<BiometricType> _availableBiometric;
  LocalAuthentication auth = LocalAuthentication();

  onUpdate() {
    setState(() {
      value = !value;
    });
  }

  bool value = false;
  bool engstat = false;
  String engstattext;
  bool ignstat;
  String ignstattext;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dbRef.child(user.uid + '/Variables').onValue,
        // ignore: missing_return
        builder: (context, snapshot) {
          String enginestat =
              snapshot.data.snapshot.value["enginestate"].toString();
          // String emergencyeng =
          //     snapshot.data.snapshot.value["emergencyeng"].toString();
          // String emergencyign =
          //     snapshot.data.snapshot.value["emergencyign"].toString();
          // if(emergencyeng == "false")
          // {
          //   dbRef.child(user.uid+"/Variables").update({"emergencyeng":true});
          // }
          // if(emergencyign == "false")
          // {
          //   dbRef.child(user.uid+"/Variables").update({"emergencyign":true});
          // }
          if (enginestat == "true") {
            engstat = true;
            engstattext = "ON";
          } else {
            engstat = false;
            engstattext = "OFF";
          }
          String ignitionstat =
              snapshot.data.snapshot.value["ignitionstate"].toString();
          if (ignitionstat == "true") {
            ignstat = true;
            ignstattext = "ON";
          } else {
            ignstat = false;
            ignstattext = "OFF";
          }
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            return Scaffold(
                backgroundColor: Colors.cyan[700],
                body: Container(
                    child: Center(
                        child: Column(children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  FadeAnimation(
                    0.7,
                    Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        FadeAnimation(
                            0.9,
                            Container(
                              child: Column(children: <Widget>[
                                SizedBox(height: 20),
                                Text(
                                  "Engine Status",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 25),
                                ),
                                SizedBox(height: 40),
                                LiteRollingSwitch(
                                  //initial value
                                  value: engstat ? true : false,
                                  textOn: 'ON',
                                  textOff: 'OFF',
                                  colorOn: Colors.greenAccent[700],
                                  colorOff: Colors.redAccent[700],
                                  iconOn: Icons.settings,
                                  iconOff: Icons.error,
                                  textSize: 16.0,
                                  onChanged: (bool state) {
                                    dbRef
                                        .child(user.uid + "/Variables")
                                        .update({
                                      'enginestate': state ? true : false,
                                      'emergency': state ? true : true
                                    });
                                    print('Current State of SWITCH IS: $state');
                                  },
                                )
                              ]),
                              height: 175,
                              width: 175,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: engstat
                                          ? Colors.green[700]
                                          : Colors.red,
                                      blurRadius: 5.0,
                                      spreadRadius: 8.0,
                                    ),
                                  ]),
                            )),
                        SizedBox(
                          height: 45,
                        ),
                        FadeAnimation(
                            1.1,
                            Container(
                              child: Column(children: <Widget>[
                                SizedBox(height: 20),
                                Text(
                                  "Ignition Status",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 25),
                                ),
                                SizedBox(height: 40),
                                LiteRollingSwitch(
                                    //initial value
                                    value: ignstat ? true : false,
                                    textOn: 'ON',
                                    textOff: 'OFF',
                                    colorOn: Colors.greenAccent[700],
                                    colorOff: Colors.redAccent[700],
                                    iconOn: Icons.done,
                                    iconOff: Icons.remove_circle_outline,
                                    textSize: 16.0,
                                    onChanged: (bool state) {
                                      dbRef
                                          .child(user.uid + "/Variables")
                                          .update({
                                        'ignitionstate': state ? true : false,
                                        'emergency': state ? true : true
                                      });
                                      print(
                                          'Current State of SWITCH IS: $state');
                                    }),
                              ]),
                              height: 175,
                              width: 175,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ignstat
                                          ? Colors.green[700]
                                          : Colors.red,
                                      blurRadius: 5.0,
                                      spreadRadius: 8.0,
                                    ),
                                  ]),
                            )),
                        SizedBox(
                          height: 90,
                        ),
                        FadeAnimation(
                          1.3,
                          Container(
                              decoration: BoxDecoration(
                                  color: value ? Colors.grey : Colors.cyan[500],
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyan[800],
                                      blurRadius: 5.0,
                                      spreadRadius: 6.0,
                                    ),
                                  ]),
                              height: 60,
                              width: 350,
                              child: FlatButton(
                                  onPressed: () async {
                                    onUpdate();
                                    dbRef
                                        .child(user.uid + "/Variables")
                                        .update({
                                      'lockstate': value ? true : false,
                                      'enginestate': value ? false : false,
                                      'ignitionstate': value ? false : false
                                    });
                                  },
                                  child: Text(
                                    value ? "Unlock The Bike" : "Lock The Bike",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ))),
                        ),
                        SizedBox(height: 30),
                        FadeAnimation(
                            1.5,
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.cyan[500],
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan[800],
                                        blurRadius: 5.0,
                                        spreadRadius: 6.0,
                                      ),
                                    ]),
                                height: 60,
                                width: 350,
                                child: FlatButton(
                                    onPressed: () async {
                                      dbRef
                                          .child(user.uid + "/Variables")
                                          .update({
                                        "emergency": false,
                                      });
                                      await Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  FirstScreen()));
                                    },
                                    child: Text(
                                      "Return To HomePage",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    )))),
                      ],
                    ),
                  ),
                ]))));
          }
        });
  }
}
