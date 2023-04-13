import 'dart:async';

import 'package:app/pages/loginpage.dart';
import 'package:app/pages/screenpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  startTimer() {
    Timer(const Duration(seconds: 1), () async {
      //if seller is loggedin already
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Screenpage()));
      }
      //if seller is NOT loggedin already
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Loginpage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/b.jpg'),
              const SizedBox(height: 10,),
              const Padding(padding: EdgeInsets.all(10),
              child: Text('Welcome to the app',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Signatra',
                letterSpacing: 3,
                fontSize: 40,fontWeight: FontWeight.bold,
              
              ),),)
            ],
          ),
        ),
      ),
    );
  }
}