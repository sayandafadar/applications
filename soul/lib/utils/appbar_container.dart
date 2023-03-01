import 'package:flutter/material.dart';

class AppBarContainer extends StatelessWidget {
  final List<Color> appBarColor;

  const AppBarContainer({
    Key key,
    @required this.appBarColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: appBarColor),
      ),
    );
  }
}
