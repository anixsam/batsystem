import 'package:batsystem/pages/gpspage.dart';
import 'package:batsystem/pages/helppage.dart';
import 'package:batsystem/pages/home-page.dart';
import 'package:batsystem/pages/settingspage.dart';
import 'package:batsystem/pages/userpage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MaterialApp(home: FirstScreen()));

class FirstScreen extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<FirstScreen> {
  int currentindex = 2;
  GlobalKey _bottomNavigationKey = GlobalKey();
  void onTapped(int index) {
    setState(() {
      currentindex = index;
    });
  }

  final List _children = [
    UserPage(),
    SettingsPage(),
    HomePage(),
    GpsScreen(),
    HelpPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[900],
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.cyan[900],
          key: _bottomNavigationKey,
          index: currentindex,
          height: 65.0,
          items: <Widget>[
            Icon(Icons.person, size: 20, color: Colors.white),
            Icon(Icons.settings, size: 20, color: Colors.white),
            Icon(Icons.dashboard, size: 20, color: Colors.white),
            Icon(Icons.location_on, size: 20, color: Colors.white),
            Icon(Icons.help, size: 20, color: Colors.white),
          ],
          buttonBackgroundColor: Colors.cyan[500],
          backgroundColor: Colors.cyan[700],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 700),
          onTap: onTapped,
        ),
        body: _children[currentindex]);
  }
}
