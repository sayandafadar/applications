import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:soul/screens/quote_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:soul/utils/constants.dart';

class HowAreYouFeelingWidget extends StatelessWidget {
  const HowAreYouFeelingWidget(
      {Key key, @required this.emoji, @required this.feelingText})
      : super(key: key);

  final String emoji;
  final String feelingText;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: FadeIn(
          duration: const Duration(milliseconds: 1300),
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
                      builder: (context) => QuoteScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      emoji,
                      style: TextStyle(
                        fontSize: 22.sp,
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Text(
                      feelingText,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'Varela',
                        color: Colors.white,
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
    );
  }
}
