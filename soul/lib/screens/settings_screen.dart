import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soul/screens/feedback_screen.dart';
import 'package:soul/screens/login_page.dart';
import 'package:soul/utils/alert_dialog.dart';
import 'package:soul/utils/button_widget.dart';
import 'package:soul/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final profileImage = NetworkImage(
      _auth.currentUser.photoURL,
    );
    precacheImage(profileImage, context);
    launchMailto() async {
      final mailtoLink = Mailto(
        to: ['to@example.com'],
        subject: 'Hey! Soul team I need help.',
      );
      await launch('$mailtoLink');
    }

    void signOutGoogle() async {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }

    showAlertDialog() {
      Widget cancelButton = RawMaterialButton(
        padding: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text(
          "Cancel",
          style: kAlertDialogTextStyle,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      Widget continueButton = RawMaterialButton(
        padding: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text(
          "Continue",
          style: kAlertDialogTextStyle,
        ),
        onPressed: () {
          signOutGoogle();
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text(
          "Are You Sure?",
          style: kAlertDialogTextStyle,
        ),
        content: Text(
          "Do you really want to sign out?",
          style: kAlertDialogTextStyle,
        ),
        actions: [
          cancelButton,
          continueButton,
        ],
        elevation: 34.0,
        backgroundColor: Color(0xFFf6959e),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    void showPlaystoreDialog() {
      showDialog(
        context: context,
        builder: (context) => new ShowAlertDialog(
          text: 'Sorry! this option is unavailable',
          icon: Icons.lightbulb,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: kMeditationScreenColor,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 8.0.h,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Varela',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 5.0.h,
                    ),
                  ),
                  FadeIn(
                    child: Container(
                      height: 15.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: kMeditationScreenColor,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: _auth.currentUser.photoURL == null
                              ? AssetImage('images/profile-image.png')
                              : profileImage,
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 1.0.h,
                    ),
                  ),
                  Center(
                    child: FadeInRight(
                      child: Text(
                        _auth.currentUser.displayName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'Varela',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                    child: FadeInLeft(
                      child: Material(
                        elevation: 27,
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: double.infinity,
                            height: constraint.maxWidth / 4.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: kSecondaryColorGradient,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 23,
                                  spreadRadius: -13,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FeedbackScreen(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    'Give us some feedback',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Varela',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SettingsCardWidget(
                          topIcon: Icons.star_border_outlined,
                          title: 'Rate us on Play Store',
                          onPressed: () {
                            showPlaystoreDialog();
                          },
                        ),
                        SettingsCardWidget(
                          topIcon: Icons.contact_support_rounded,
                          title: 'Contact Support',
                          onPressed: launchMailto,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 2.h,
                    ),
                  ),
                  ButtonWidget(
                    onPressed: showAlertDialog,
                    title: 'Sign Out',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SettingsCardWidget extends StatelessWidget {
  const SettingsCardWidget({
    Key key,
    @required this.topIcon,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  final IconData topIcon;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FadeInUp(
        child: Material(
          color: Colors.transparent,
          elevation: 27,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 43.3.w,
              height: 24.5.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 17),
                    blurRadius: 23,
                    spreadRadius: -13,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
                gradient: kSecondaryColorGradient,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
                        child: Icon(
                          topIcon,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 120, 25, 0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontFamily: 'Varela',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
