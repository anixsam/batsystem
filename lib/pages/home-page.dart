import 'package:batsystem/Animation/FadeAnimation.dart';
import 'package:batsystem/pages/emergency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

String eng;
String ign;
bool lck;
bool findmydevice = false;
bool alm = false;
String name, email, phoneno, vehicleno;
bool value3 = false;
bool value2 = false;
String enginestat = "";
String ignitionstat = "";
User user = FirebaseAuth.instance.currentUser;
final dbRef = FirebaseDatabase.instance.reference();
bool value = false;
bool lockstate = false;
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  bool authcheck = false;

  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<HomePage> {
  String authorized = "Not authorized";

  // bool _canCheckBiometric;
  // List<BiometricType> _availableBiometric;
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

  Future<void> _authenticate2() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan Your Finger To Proceed",
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() async {
      authorized = authenticated
          ? {
              //"Autherized success",dbRef.child(user.uid + "/Variables").update({'emergencyeng': true, 'emergencyign': true}),
              await Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => Emergency())),
            }
          : "Failed to authenticate";
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan To Lock Your Vehicle",
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() async {
      authorized = authenticated
          ? {
              "Autherized success",
              onUpdate(),
              dbRef.child(user.uid + "/Variables").update({
                'lockstate': lockstate,
                'enginestate': false,
                'ignitionstate': false
              }),
            }
          : "Failed to authenticate";
    });
  }

  onUpdate() {
    setState(() {
      lockstate = !lockstate;
    });
  }

  // ignore: missing_return
  // ignore: non_constant_identifier_names
  Future<String> read_state(String name) {
    dbRef.child(user.uid + "/findmydevice/").once().then((DataSnapshot data) {
      Map list = data.value;
      print(list);
      //return list[name];

      setState(() {
        findmydevice = list["status"];
      });
    });
    dbRef.child(user.uid + "/Alarm/").once().then((DataSnapshot data) {
      Map list = data.value;
      print(list);
      //return list[name];

      setState(() {
        alm = list["status"];
      });
    });
    dbRef.child(user.uid + "/Variables/").once().then((DataSnapshot data) {
      Map list = data.value;
      print(list);
      //return list[name];

      setState(() {
        ignitionstat = list["ignitionstate"].toString();
        enginestat = list["enginestate"].toString();

        bool lockstate = list["lockstate"];
      });
    });
  }

  // String read_statebackup(String name) {
  //   dbRef.child(user.uid + "/Details/").once().then((DataSnapshot data) {
  //     Map list = data.value;
  //     print(list);
  //     //return list[name];

  //     name = list["name"].toString();
  //     email = list["email"].toString();
  //     phoneno = list["phoneno"].toString();
  //     vehicleno = list["vehicleno"].toString();
  //     print(name);
  //   });
  // }

  bool value = false;
  bool engstat = false;
  String engstattext;
  bool ignstat = false;
  String ignstattext;
  @override
  Widget build(BuildContext context) {
    initState();
    //enginestat = read_state("enginestate");
    print("enginestate:" + enginestat);
    print("ignitionstate:" + ignitionstat);
    print("lockstate:" + lockstate.toString());
    //ignitionstat = read_state("ignitionstate");
    // return Scaffold(
    //stream: dbRef.child(user.uid + '/Variables').onValue,
    // ignore: missing_return
    // builder: (context, snapshot) {
    if (enginestat == "true") {
      engstat = true;
      engstattext = "ON";
    } else {
      engstat = false;
      engstattext = "OFF";
    }
    if (ignitionstat == "true") {
      ignstat = true;
      ignstattext = "ON";
    } else {
      ignstat = false;
      ignstattext = "OFF";
    }
    /* if (snapshot.hasData &&
          !snapshot.hasError &&
          snapshot.data.snapshot.value != null) {*/
    return MediaQuery(
        data: MediaQueryData(),
        child: Scaffold(
            backgroundColor: Colors.cyan[700],
            body: Container(
                child: Center(
                    child: Column(children: <Widget>[
              SizedBox(
                height: 50,
              ),
              FadeAnimation(
                0.7,
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      child: Column(children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          "Engine Status",
                          style: TextStyle(color: Colors.grey, fontSize: 25),
                        ),
                        SizedBox(height: 40),
                        Text(engstattext,
                            style: TextStyle(
                                color: engstat ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 45))
                      ]),
                      height: 175,
                      width: 175,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: engstat ? Colors.green[700] : Colors.red,
                              blurRadius: 5.0,
                              spreadRadius: 8.0,
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      child: Column(children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          "Ignition Status",
                          style: TextStyle(color: Colors.grey, fontSize: 25),
                        ),
                        SizedBox(height: 40),
                        Text(ignstattext,
                            style: TextStyle(
                                color: ignstat ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 45))
                      ]),
                      height: 175,
                      width: 175,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: ignstat ? Colors.green[700] : Colors.red,
                              blurRadius: 5.0,
                              spreadRadius: 8.0,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              FadeAnimation(
                  .9,
                  Container(
                      width: 395,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Row(children: [
                          SizedBox(
                            width: 40,
                          ),
                          Column(children: <Widget>[
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          value ? Colors.grey : Colors.yellow,
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ]),
                              child: RaisedButton(
                                  elevation: 10,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(100.0)),
                                  color:
                                      lockstate ? Colors.grey : Colors.orange,
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(
                                          lockstate
                                              ? Icons.lock
                                              : Icons.lock_open,
                                          size: 90,
                                          color: Colors.cyan[900])),
                                  onPressed: () async {
                                    _authenticate();
                                  }),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "V-LOCK",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.cyan[800],
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                          SizedBox(
                            width: 60,
                          ),
                          Column(children: <Widget>[
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: findmydevice
                                          ? Colors.green
                                          : Colors.orange,
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ]),
                              child: RaisedButton(
                                  elevation: 10,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(100.0)),
                                  color: Colors.orange,
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(Icons.motorcycle_rounded,
                                          size: 90, color: Colors.green[900])),

                                  //Image(
                                  // image: AssetImage("images/bikelogo.png"))),
                                  onPressed: () async {
                                    value2 = !value2;

                                    dbRef
                                        .child(user.uid + "/findmydevice")
                                        .set({
                                      'status': value2 ? true : false,
                                    });
                                  }),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "FIND",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.cyan[800],
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        ]),
                        SizedBox(height: 80),
                        Row(children: [
                          SizedBox(
                            width: 40,
                          ),
                          Column(children: <Widget>[
                            Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.yellow,
                                        blurRadius: 5.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ]),
                                child: RaisedButton(
                                  elevation: 10,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(100.0)),
                                  color: Colors.orange,
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(Icons.warning_amber_outlined,
                                          color: Colors.red[900], size: 90)),
                                  onPressed: () {
                                    _authenticate2();
                                  },
                                )),
                            SizedBox(height: 10),
                            Text(
                              "EMERGENCY",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.cyan[800],
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                          SizedBox(
                            width: 60,
                          ),
                          Column(children: <Widget>[
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: alm ? Colors.green : Colors.orange,
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ]),
                              child: RaisedButton(
                                  elevation: 10,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(100.0)),
                                  color: Colors.orange,
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 0.5),
                                      child: Icon(Icons.notifications_active,
                                          color: Colors.red[900], size: 90)),
                                  onPressed: () async {
                                    value3 = !value3;
                                    dbRef.child(user.uid + "/Alarm").set({
                                      'status': value3 ? true : false,
                                    });
                                  }),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "ALARM",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.cyan[800],
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        ]),
                        SizedBox(height: 25)
                      ])))
            ])))));
  }
}
