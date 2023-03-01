import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'music_stream.dart';

class BodyContainer extends StatelessWidget {
  final List<Color> bodyColor;
  final String category;

  const BodyContainer({
    Key key,
    @required this.bodyColor,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: bodyColor,
        ),
      ),
      child: FadeInDown(
        child: MusicStream(
          category: category,
        ),
      ),
    );
  }
}
