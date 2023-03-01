import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soul/screens/app_screen.dart';
import 'package:soul/screens/login_page.dart';
import 'package:soul/utils/constants.dart';

String imageURL;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () => goToAppScreen());
  }

  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  goToAppScreen() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => AppScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => FadeIn(
              duration: Duration(milliseconds: 700),
              child: LoginPage(),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 24.0,
          margin: EdgeInsets.fromLTRB(35, 0, 35, 10),
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFFf6959e),
          content: FadeIn(
            child: Text(
              'Something went wrong',
              style: kAlertDialogTextStyle,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.bottomLeft,
            image: AssetImage('images/welcome-screen-image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: FadeIn(
          duration: Duration(seconds: 2),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                'Soul',
                style: TextStyle(
                  fontFamily: 'Tangerine',
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
