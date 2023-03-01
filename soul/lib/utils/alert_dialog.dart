import 'package:flutter/material.dart';
import 'package:soul/utils/constants.dart';

class ShowAlertDialog extends StatelessWidget {
  final IconData icon;
  final String text;

  const ShowAlertDialog({Key key, @required this.icon, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 18.5,
            ),
          ),
          SizedBox(width: 7),
          Text(
            text,
            style: kAlertDialogTextStyle,
          ),
        ],
      ),
      elevation: 34.0,
      backgroundColor: Color(0xFFf6959e),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
