import 'package:flutter/material.dart';
import 'package:soul/utils/appbar_container.dart';
import 'package:soul/utils/body_container.dart';
import 'package:soul/utils/constants.dart';
import 'package:sizer/sizer.dart';

class RelaxScreen extends StatefulWidget {
  @override
  _RelaxScreenState createState() => _RelaxScreenState();
}

class _RelaxScreenState extends State<RelaxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110.0,
        automaticallyImplyLeading: false,
        flexibleSpace: AppBarContainer(
          appBarColor: kRelaxScreenColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Chill",
              style: TextStyle(
                fontSize: 15.5.sp,
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
              "Study",
              style: TextStyle(
                fontSize: 15.7.sp,
                color: Colors.white,
                fontFamily: "KaushanScript",
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BodyContainer(
        bodyColor: kRelaxScreenColor,
        category: 'Relax',
      ),
    );
  }
}
