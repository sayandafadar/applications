import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

List<Color> kRelaxScreenColor = [
  Color(0xFF000000),
  Color(0xFF251639),
];

List<Color> kSleepScreenColor = [
  Color(0xFF000000),
  Color(0xFF130f40),
];

List<Color> kMeditationScreenColor = [
  Color(0xFF00151E),
  Color(0xFF012939),
  Color(0xFF003545),
];

TextStyle kAlertDialogTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  // fontFamily: 'Varela',
);

LinearGradient kSecondaryColorGradient = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: [
    Color(0xFF5CA1A6),
    Color(0xFF85D8A4),
  ],
);

List<Color> kSecondaryColor = [
  Color(0xFF5CA1A6),
  Color(0xFF85D8A4),
];
