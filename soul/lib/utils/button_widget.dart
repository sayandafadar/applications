import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:soul/utils/constants.dart';
import 'package:sizer/sizer.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    this.onPressed,
    this.title,
  }) : super(key: key);

  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 1300),
      child: Container(
        width: 30.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 15,
              spreadRadius: -13,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: kSecondaryColorGradient,
        ),
        child: RawMaterialButton(
          onPressed: onPressed,
          elevation: 20,
          constraints: BoxConstraints(minWidth: 88.0, minHeight: 6.h),
          hoverElevation: 24.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Varela',
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
