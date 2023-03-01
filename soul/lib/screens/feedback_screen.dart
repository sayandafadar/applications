import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul/utils/alert_dialog.dart';
import 'package:soul/utils/back_button_widget.dart';
import 'package:soul/utils/button_widget.dart';
import 'package:soul/utils/constants.dart';
import 'package:sizer/sizer.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    TextEditingController category = TextEditingController();

    showAlertDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => new ShowAlertDialog(
          text: "Please provide some feedback",
          icon: Icons.edit,
        ),
      );
    }

    _onTapButton(BuildContext context) {
      return AlertDialog(
        title: Text(
          'Thanks!',
          style: kAlertDialogTextStyle,
        ),
        content: Text(
          'This will help us to improve in the future.',
          style: kAlertDialogTextStyle,
        ),
        elevation: 34.0,
        backgroundColor: Color(0xFFf6959e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              category.clear();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AppScreen(),
              //   ),
              // );
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: kAlertDialogTextStyle,
            ),
          ),
        ],
      );
    }

    finalUpload() {
      if (category.text == "") {
        return showAlertDialog(context);
      } else {
        var feedbackData = {
          "feedback": category.text,
        };
        firestore.collection("Feedback").add(feedbackData).whenComplete(
              () => showDialog(
                context: context,
                builder: (context) => _onTapButton(context),
              ),
            );
      }
    }

    Widget _buildTextField() {
      final maxLines = 8;

      return Container(
        margin: EdgeInsets.all(30),
        height: maxLines * 24.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 23,
              spreadRadius: -13,
            ),
          ],
        ),
        child: TextField(
          maxLines: maxLines,
          controller: category,
          decoration: InputDecoration(
            hintText: "Please provide some feedback.",
            fillColor: Colors.grey[300],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(15.0),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: kMeditationScreenColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 2, 0, 2),
            child: BackButtonWidget(),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Flexible(
            child: Center(
              child: Image.asset(
                'images/feed.png',
                height: 30.h,
                width: 75.w,
              ),
            ),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Center(
            child: Text(
              'Help us to improve!',
              style: TextStyle(
                fontFamily: 'Varela',
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(
            height: .5.h,
          ),
          Center(
            child: _buildTextField(),
          ),
          Center(
            child: ButtonWidget(
              onPressed: finalUpload,
              title: 'Submit',
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    ));
  }
}
