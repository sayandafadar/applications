import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soul/screens/login_page.dart';
import 'package:soul/utils/button_widget.dart';
import 'package:soul/utils/constants.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  TextEditingController songName = TextEditingController();
  TextEditingController artistName = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController songURL = TextEditingController();
  TextEditingController imageURL = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController rectangleCardCategory = TextEditingController();
  TextEditingController fontFamily = TextEditingController();

  File image, song;
  String imagepath, songpath;
  Reference ref;
  var imageDownUrl, songDownUrl;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // void selectimage() async {
  //   image = await FilePicker.getFile();

  //   setState(() {
  //     image = image;
  //     imagepath = basename(image.path).toString();
  //     uploadImageFile(image.readAsBytesSync(), imagepath);
  //   });
  // }

  // Future<String> uploadImageFile(List<int> image, String imagepath) async {
  //   ref = FirebaseStorage.instance.ref().child(imagepath);
  //   UploadTask uploadTask = ref.putData(image);

  //   imageDownUrl = await (await uploadTask).ref.getDownloadURL();
  // }

  // void selectsong() async {
  //   song = await FilePicker.getFile();

  //   setState(() {
  //     song = song;
  //     songpath = basename(song.path);
  //     uploadSongFile(song.readAsBytesSync(), songpath);
  //   });
  // }

  // Future<String> uploadSongFile(List<int> song, String songpath) async {
  //   ref = FirebaseStorage.instance.ref().child(songpath);
  //   UploadTask uploadTask = ref.putData(song);

  //   songDownUrl = await (await uploadTask).ref.getDownloadURL();
  // }

  finalupload(context) {
    if (category.text == 'Meditation') {
      var data = {
        "songName": songName.text,
        "artistName": artistName.text,
        "songUrl": songURL.text,
        "imageUrl": imageURL.text,
        "duration": durationController.text,
        "fontFamily": fontFamily.text,
      };

      firestore
          .collection("Meditation")
          .add(data)
          .whenComplete(() => showDialog(
                context: context,
                builder: (context) =>
                    _onTapButton(context, "Files Uploaded Successfully :)"),
              ));
    } else if (category.text == 'Sleep') {
      var data = {
        "songName": songName.text,
        "artistName": artistName.text,
        "songUrl": songURL.text,
        "imageUrl": imageURL.text,
        "duration": durationController.text,
        "fontFamily": fontFamily.text,
      };

      firestore.collection("Sleep").add(data).whenComplete(() => showDialog(
            context: context,
            builder: (context) =>
                _onTapButton(context, "Files Uploaded Successfully :)"),
          ));
    } else if (category.text == 'Relax') {
      var data = {
        "songName": songName.text,
        "artistName": artistName.text,
        "songUrl": songURL.text,
        "imageUrl": imageURL.text,
        "duration": durationController.text,
        "fontFamily": fontFamily.text,
      };

      firestore.collection("Relax").add(data).whenComplete(() => showDialog(
            context: context,
            builder: (context) =>
                _onTapButton(context, "Files Uploaded Successfully :)"),
          ));
    } else if (category.text == 'EditorsChoice') {
      var data = {
        "songName": songName.text,
        "artistName": artistName.text,
        "songUrl": songURL.text,
        "imageUrl": imageURL.text,
        "duration": durationController.text,
        "fontFamily": fontFamily.text,
      };

      firestore
          .collection("EditorsChoice")
          .add(data)
          .whenComplete(() => showDialog(
                context: context,
                builder: (context) =>
                    _onTapButton(context, "Files Uploaded Successfully :)"),
              ));
    } else if (category.text == 'NewReleases') {
      var data = {
        "songName": songName.text,
        "artistName": artistName.text,
        "songUrl": songURL.text,
        "imageUrl": imageURL.text,
        "duration": durationController.text,
        "fontFamily": fontFamily.text,
      };

      firestore
          .collection("NewReleases")
          .add(data)
          .whenComplete(() => showDialog(
                context: context,
                builder: (context) =>
                    _onTapButton(context, "Files Uploaded Successfully :)"),
              ));
    } else if (category.text == 'RectangleMusic') {
      var data = {
        "songName": songName.text,
        "artistName": artistName.text,
        "songUrl": songURL.text,
        "imageUrl": imageURL.text,
        "duration": durationController.text,
        "fontFamily": fontFamily.text,
        "category": rectangleCardCategory.text,
      };

      firestore
          .collection("RectangleMusic")
          .add(data)
          .whenComplete(() => showDialog(
                context: context,
                builder: (context) =>
                    _onTapButton(context, "Files Uploaded Successfully :)"),
              ));
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            _onTapButton(context, "Please Enter All Details :("),
      );
    }
  }

  _onTapButton(BuildContext context, data) {
    return AlertDialog(title: Text(data));
  }

  void signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  showAlertDialog() {
    Widget cancelButton = RawMaterialButton(
      padding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Text(
        "Cancel",
        style: kAlertDialogTextStyle,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RawMaterialButton(
      padding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Text(
        "Continue",
        style: kAlertDialogTextStyle,
      ),
      onPressed: () {
        signOutGoogle();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Are You Sure?",
        style: kAlertDialogTextStyle,
      ),
      content: Text(
        "Do you really want to sign out?",
        style: kAlertDialogTextStyle,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
      elevation: 34.0,
      backgroundColor: Color(0xFFf6959e),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SafeArea(
      child: ListView(
        children: <Widget>[
          // RawMaterialButton(
          //   onPressed: () => selectimage(),
          //   child: Text("Select Image"),
          // ),
          // RawMaterialButton(
          //   onPressed: () => selectsong(),
          //   child: Text("Select Song"),
          // ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: songURL,
              decoration: InputDecoration(
                hintText: "Enter Song URL",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: imageURL,
              decoration: InputDecoration(
                hintText: "Enter Image URL",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: fontFamily,
              decoration: InputDecoration(
                hintText: "Enter fontFamily",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: songName,
              decoration: InputDecoration(
                hintText: "Enter Song Name",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: artistName,
              decoration: InputDecoration(
                hintText: "Enter artist name",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: durationController,
              decoration: InputDecoration(
                hintText: "Enter duration name",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: category,
              decoration: InputDecoration(
                hintText: "Enter category name",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: rectangleCardCategory,
              decoration: InputDecoration(
                hintText: "Enter rectangle card category name",
              ),
            ),
          ),
          RawMaterialButton(
            onPressed: () => finalupload(context),
            child: Text("Upload"),
          ),
          SizedBox(
            height: 30,
          ),
          ButtonWidget(
            onPressed: showAlertDialog,
            title: 'Sign Out',
          ),
        ],
      ),
    ));
  }
}
