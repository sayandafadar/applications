import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 25,
        color: Colors.white,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}
