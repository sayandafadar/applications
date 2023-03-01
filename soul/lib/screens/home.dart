import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul/screens/how_are_you_feeling_screen.dart';
import 'package:soul/utils/constants.dart';
import 'package:soul/utils/home_screen_music_stream.dart';
import 'package:soul/utils/rectangle_card_stream.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';

final _auth = FirebaseAuth.instance;

var presentTime = DateTime.now();
String wish() {
  print(presentTime.hour);
  if (presentTime.hour >= 1 && presentTime.hour <= 12) {
    return "Good morning,";
  } else if (presentTime.hour > 12 && presentTime.hour <= 16) {
    return "Good afternoon,";
  } else {
    return "Good evening,";
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final theImage = NetworkImage(
    "https://source.unsplash.com/daily?green",
  );

  @override
  void didChangeDependencies() {
    precacheImage(theImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (SizerUtil.deviceType == DeviceType.mobile) {
      return DifferentSizeWidget(
        feelingTextFontSize: 15.0.sp,
        feelingEmojiFontSize: 20.sp,
        imageURL: theImage,
      );
    } else if (SizerUtil.deviceType == DeviceType.tablet) {
      return DifferentSizeWidget(
        feelingEmojiFontSize: 37,
        feelingTextFontSize: 36,
        imageURL: theImage,
      );
    } else {
      return DifferentSizeWidget(
        feelingEmojiFontSize: 28,
        feelingTextFontSize: 26,
        imageURL: theImage,
      );
    }
  }
}

class DifferentSizeWidget extends StatelessWidget {
  const DifferentSizeWidget({
    Key key,
    @required this.feelingEmojiFontSize,
    @required this.feelingTextFontSize,
    this.imageURL,
  }) : super(key: key);

  final double feelingEmojiFontSize;
  final double feelingTextFontSize;
  final NetworkImage imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: [
                  Container(
                    height: 28.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: kMeditationScreenColor,
                      ),
                      image: DecorationImage(
                        image: imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 25, 120),
                            child: Center(
                              child: Text(
                                'Soul',
                                style: TextStyle(
                                  fontFamily: 'Tangerine',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                          FadeInDown(
                            duration: Duration(milliseconds: 900),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(4, 21.2.h, 0, 0),
                              child: Text(
                                wish(),
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10.8.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Varela',
                                ),
                              ),
                            ),
                          ),
                          FadeInDown(
                            duration: Duration(milliseconds: 900),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(4, 23.5.h, 0, 0),
                              child: Text(
                                // 'Manokamna Kumari',
                                _auth.currentUser.displayName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0.sp,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Varela',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: kMeditationScreenColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: FadeInDown(
                              duration: const Duration(milliseconds: 1300),
                              delay: Duration(milliseconds: 400),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: BoxDecoration(
                                  gradient: kSecondaryColorGradient,
                                  borderRadius: BorderRadius.circular(20),
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
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HowAreYouScreen(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          '😊',
                                          style: TextStyle(
                                            fontSize: feelingEmojiFontSize,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 17,
                                        ),
                                        Text(
                                          'How are you feeling?',
                                          style: TextStyle(
                                            fontSize: feelingTextFontSize,
                                            color: Colors.white,
                                            fontFamily: 'Varela',
                                            fontWeight: FontWeight.w700,
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
                        FadeInLeft(
                          delay: Duration(milliseconds: 500),
                          duration: Duration(milliseconds: 1300),
                          child: SubtitleContainer(
                            subtitle: 'Editors Choice',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7),
                          height: 235,
                          child: FadeInRight(
                            delay: Duration(milliseconds: 500),
                            duration: Duration(milliseconds: 1300),
                            child: HomeScreenStream(
                              category: 'EditorsChoice',
                            ),
                          ),
                        ),
                        FadeInLeft(
                          delay: Duration(milliseconds: 600),
                          duration: Duration(milliseconds: 1300),
                          child: SubtitleContainer(
                            subtitle: 'Top Shorts',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3.5),
                          height: 130.0,
                          child: FadeInRight(
                            delay: Duration(milliseconds: 600),
                            duration: Duration(milliseconds: 1300),
                            child: RectangleCardStream(),
                          ),
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 800),
                          duration: Duration(milliseconds: 1300),
                          child: SubtitleContainer(
                            subtitle: 'Best For Sleep',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          height: 235,
                          child: FadeInRight(
                            delay: Duration(milliseconds: 800),
                            duration: Duration(milliseconds: 1300),
                            child: HomeScreenStream(
                              category: 'Sleep',
                            ),
                          ),
                        ),
                        FadeInLeft(
                          delay: Duration(milliseconds: 900),
                          duration: Duration(milliseconds: 1500),
                          child: SubtitleContainer(
                            subtitle: 'Mediataion Vives',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          height: 235,
                          child: FadeInRight(
                            delay: Duration(milliseconds: 900),
                            duration: Duration(milliseconds: 1500),
                            child: HomeScreenStream(
                              category: 'Meditation',
                            ),
                          ),
                        ),
                        FadeInLeftBig(
                          delay: Duration(milliseconds: 1000),
                          duration: Duration(milliseconds: 1700),
                          child: SubtitleContainer(
                            subtitle: 'Chill Study Music',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          height: 235,
                          child: FadeInRight(
                            delay: Duration(milliseconds: 1000),
                            duration: Duration(milliseconds: 1700),
                            child: HomeScreenStream(
                              category: 'Relax',
                            ),
                          ),
                        ),
                        FadeInLeftBig(
                          delay: Duration(milliseconds: 1000),
                          duration: Duration(milliseconds: 1700),
                          child: SubtitleContainer(
                            subtitle: 'New Releases',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          height: 235,
                          child: FadeInRight(
                            delay: Duration(milliseconds: 1000),
                            duration: Duration(milliseconds: 1700),
                            child: HomeScreenStream(
                              category: 'NewReleases',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubtitleContainer extends StatelessWidget {
  final IconData icon;
  final String subtitle;
  final double fontSize;
  const SubtitleContainer({
    Key key,
    this.icon,
    this.subtitle,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizerUtil.deviceType == DeviceType.mobile
        ? Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 22,
              bottom: 0,
            ),
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.5, 5, 4, 2.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Varela',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(
              left: 22,
              top: 27,
              bottom: 10,
            ),
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.5, 7, 8, 6),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Varela',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
