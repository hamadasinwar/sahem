import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String mainPage = LogInScreen.routeName;
  bool completed = false;

  @override
  void initState() {
    Timer.periodic( const Duration(seconds: 1), (timer){
      if(completed){
        Navigator.of(context).pushReplacementNamed(mainPage);
        timer.cancel();
      }
    });
    Firebase.initializeApp().whenComplete(() {
      completed = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          mainPage = Auth.checkIsLoggedIn();
          return */Stack(
            children: [
              Image.asset(
                'assets/images/splash.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                child: Hero(
                  tag: 'login',
                  child: Image.asset(
                    'assets/images/logo3.png',
                    height: 250,
                  ),
                ),
              )
            ],
          )/*;
        }
      ),*/
    );
  }
}