import 'package:batsystem/Animation/FadeAnimation.dart';
import 'package:batsystem/controll/firesore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelpPage(),
    ));

// ignore: must_be_immutable
class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.cyan[700],
        child: Column(children: <Widget>[
          SizedBox(
            height: 60,
          ),
          FadeAnimation(
            0.2,
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Center(
                  child: Image(
                height: 150,
                width: 150,
                image: AssetImage('images/applogo.png'),
              )),
            ),
          ),
          SizedBox(height: 15),
          Center(
              child: Column(
            children: <Widget>[
              FadeAnimation(
                  0.5,
                  Text("B-A-T System",
                      style: TextStyle(
                          height: 2,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(
                  0.7,
                  Center(
                      child: Text("Project Made By Anix,Alby,Alan,Afnitha",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)))),
              FadeAnimation(
                  0.7,
                  Center(
                      child: Text(
                          "Students of Ilahia College of Engineering and Technology",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)))),
              SizedBox(
                height: 25,
              ),
              FadeAnimation(
                  0.9,
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "B-A-T System is the device which protects your motorcycle from thieves from stealing.It helps you to controll your vehicles ignition remotely at your finger tips.You could turn off your bike if the thief steals the bike from you",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          )))),
              FadeAnimation(
                  0.9,
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Main Features:\n -> Remote ignition controll \n -> Engine & ignition status indicator \n -> Find your bike \n -> Controll your bike from anywhere ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)))),
              SizedBox(
                height: 92,
              ),
              FadeAnimation(
                  1.1,
                  Center(
                      child: Row(
                    children: <Widget>[
                      SizedBox(width: 135),
                      Icon(
                        Icons.copyright,
                        color: Colors.white,
                      ),
                      SizedBox(width: 05),
                      Text(
                        "B-A-T System",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ))),
            ],
          ))
        ]));
  }
}
