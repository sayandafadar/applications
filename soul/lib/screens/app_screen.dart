import 'package:animate_do/animate_do.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul/screens/home.dart';
import 'package:soul/screens/relax_screen.dart';
import 'package:soul/screens/settings_screen.dart';
import 'package:soul/screens/sleep_screen.dart';
import 'package:soul/screens/upload_screen.dart';
import 'package:soul/utils/alert_dialog.dart';
import 'package:soul/utils/constants.dart';
import 'meditation_screen.dart';
import 'package:after_layout/after_layout.dart';

int currentIndex = 0;

class AppScreen extends StatefulWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>
    with AfterLayoutMixin<AppScreen> {
  checkConnectivity() async {
    if (await DataConnectionChecker().hasConnection == true) {
    } else {
      return showNoInternetConnectionDialog();
    }
  }

  final _auth = FirebaseAuth.instance.currentUser.email;

  List bottomNavBarColor = [
    kMeditationScreenColor,
    kMeditationScreenColor,
    kSleepScreenColor,
    kRelaxScreenColor,
    kMeditationScreenColor,
  ];

  @override
  Widget build(BuildContext context) {
    List tabs = [
      HomeScreen(),
      MeditationScreen(),
      SleepScreen(),
      RelaxScreen(),
      _auth == 'clocktrendz@gmail.com' ? UploadScreen() : SettingsScreen(),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final constrainedTextScaleFactor =
            mediaQueryData.textScaleFactor.clamp(1.0, 1.1);
        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaleFactor: constrainedTextScaleFactor,
          ),
          child: Scaffold(
            body: DoubleBackToCloseApp(
              child: tabs[currentIndex],
              snackBar: SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 24.0,
                margin: EdgeInsets.fromLTRB(35, 0, 35, 10),
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color(0xFFf6959e),
                content: FadeIn(
                  child: Text(
                    'Press again to exit the app',
                    style: kAlertDialogTextStyle,
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: bottomNavBarColor[currentIndex],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: AnimatedBottomNavigationBar(
                  activeIndex: currentIndex,
                  icons: [
                    Icons.home,
                    Icons.spa,
                    Icons.nightlight_round,
                    Icons.book,
                    Icons.settings,
                  ],
                  backgroundColor: Colors.transparent,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white54,
                  iconSize: 30.0,
                  gapWidth: 0.0,
                  elevation: 25,
                  height: 68.0,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    checkConnectivity();
  }

  void showNoInternetConnectionDialog() {
    showDialog(
      context: context,
      builder: (context) => new ShowAlertDialog(
        text: "Please connect to the internet",
        icon: Icons.warning,
      ),
    );
  }
}
