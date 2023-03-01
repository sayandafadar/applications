import 'package:flutter/material.dart';
import 'package:soul/utils/appbar_container.dart';
import 'package:soul/utils/body_container.dart';
import 'package:soul/utils/constants.dart';
import 'package:sizer/sizer.dart';

class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110.0,
        automaticallyImplyLeading: false,
        flexibleSpace: AppBarContainer(
          appBarColor: kSleepScreenColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sleep",
              style: TextStyle(
                fontSize: 16.5.sp,
                color: Colors.white,
                fontFamily: "Merienda",
                letterSpacing: 3,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Jingles",
              style: TextStyle(
                fontSize: 15.7.sp,
                color: Colors.white,
                fontFamily: "Charmonman",
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BodyContainer(
        bodyColor: kSleepScreenColor,
        category: 'Sleep',
      ),
    );
  }
}
