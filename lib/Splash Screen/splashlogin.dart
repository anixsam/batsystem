import 'dart:async';
import 'package:batsystem/homepage.dart';
import 'package:batsystem/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(SplashFirstScreen());
}

class SplashFirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashLoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: LoginScreen(),
        backgroundColor: Colors.cyan[700],
        imageBackground: AssetImage('images/images/Splash.png'),
        loaderColor: Colors.transparent);
  }
}
