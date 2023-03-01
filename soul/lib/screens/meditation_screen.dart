import 'package:flutter/material.dart';
import 'package:soul/utils/appbar_container.dart';
import 'package:soul/utils/body_container.dart';
import 'package:soul/utils/constants.dart';
import 'package:sizer/sizer.dart';

class MeditationScreen extends StatefulWidget {
  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110.0,
        automaticallyImplyLeading: false,
        flexibleSpace: AppBarContainer(
          appBarColor: kMeditationScreenColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Meditation",
              style: TextStyle(
                fontSize: 15.0.sp,
                color: Colors.white,
                fontFamily: "Merienda",
                letterSpacing: 1.1,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Vives",
              style: TextStyle(
                fontSize: 15.9.sp,
                color: Colors.white,
                fontFamily: "Charmonman",
                letterSpacing: 3,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BodyContainer(
        bodyColor: kMeditationScreenColor,
        category: 'Meditation',
      ),
    );
  }
}
