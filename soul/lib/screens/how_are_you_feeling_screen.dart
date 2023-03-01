import 'package:flutter/material.dart';
import 'package:soul/utils/back_button_widget.dart';
import 'package:soul/utils/constants.dart';
import 'package:soul/utils/how_are_you_feeling_widget.dart';
import 'package:sizer/sizer.dart';

class HowAreYouScreen extends StatefulWidget {
  const HowAreYouScreen({Key key}) : super(key: key);

  @override
  _HowAreYouScreenState createState() => _HowAreYouScreenState();
}

class _HowAreYouScreenState extends State<HowAreYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: kMeditationScreenColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2, 0, 2),
              child: BackButtonWidget(),
            ),
            SizedBox(
              height: 3.5.h,
            ),
            Center(
              child: Text(
                'How Are You Feeling?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: 'Varela',
                ),
              ),
            ),
            SizedBox(
              height: 4.2.h,
            ),
            HowAreYouFeelingWidget(
              emoji: '😇',
              feelingText: "I'm feeling blessed",
            ),
            HowAreYouFeelingWidget(
              emoji: '☺',
              feelingText: "I'm feeling happy",
            ),
            HowAreYouFeelingWidget(
              emoji: '🥱',
              feelingText: "I'm feeling tired",
            ),
            HowAreYouFeelingWidget(
              emoji: '😔',
              feelingText: "I'm feeling sad",
            ),
          ],
        ),
      ),
    );
  }
}
