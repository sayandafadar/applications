import 'dart:convert';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sizer/sizer.dart';
import 'package:soul/screens/app_screen.dart';
import 'package:http/http.dart' as http;
import 'package:soul/utils/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool showSpinner = false;

  // ignore: missing_return
  Future<User> _signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    setState(() {
      showSpinner = true;
    });
    User user = (await firebaseAuth.signInWithCredential(credential)).user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    User currentUser = firebaseAuth.currentUser;
    assert(user.uid == currentUser.uid);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FadeIn(child: AppScreen())));
  }

  // ignore: missing_return
  Future<User> _signInWithFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final graphResponse = await http.get(
          Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=first_name,picture&access_token=${accessToken.token}',
          ),
        );
        final profile = jsonDecode(graphResponse.body);
        AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        setState(() {
          showSpinner = true;
        });
        User user = (await firebaseAuth.signInWithCredential(credential)).user;
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);
        User currentUser = firebaseAuth.currentUser;
        assert(user.uid == currentUser.uid);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FadeIn(child: AppScreen())));
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 24.0,
            margin: EdgeInsets.fromLTRB(35, 0, 35, 10),
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFFf6959e),
            content: FadeIn(
              child: Text(
                'Something went wrong',
                style: kAlertDialogTextStyle,
              ),
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: Colors.grey,
        progressIndicator: SpinKitDoubleBounce(
          color: Colors.white,
          size: 70.0,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'images/login-page-image.png',
              ),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Center(
                  child: Text(
                    'Soul',
                    style: TextStyle(
                      fontFamily: 'Tangerine',
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 27.h,
                ),
                Text(
                  'Hi there &\nWelcome',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: .5,
                    fontSize: 40,
                    fontFamily: 'Varela',
                  ),
                ),
                SizedBox(
                  height: 5.5.h,
                ),
                Text(
                  'Everything you can imagine is real. \n – Pablo Picasso',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontSize: 13.5.sp,
                    fontFamily: 'Varela',
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 13.5.h,
                  ),
                ),
                Center(
                  child: SignInButtonBuilder(
                    text: 'Continue with Google',
                    image: Image.asset(
                      'images/google.png',
                      height: 2.3.h,
                    ),
                    padding: EdgeInsets.fromLTRB(12, 8, 3, 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 6.h,
                    onPressed: () {
                      _signInWithGoogle();
                    },
                    textColor: Colors.black54,
                    backgroundColor: Colors.white,
                    // width: 235.0,
                  ),
                ),
                SizedBox(
                  height: 1.3.h,
                ),
                Center(
                  child: SignInButtonBuilder(
                    text: 'Continue with Facebook',
                    icon: Icons.facebook_outlined,
                    padding: EdgeInsets.fromLTRB(12, 8, 3, 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 6.h,
                    onPressed: () {
                      _signInWithFacebook();
                    },
                    textColor: Colors.white,
                    backgroundColor: Color(0xFF1778F2),
                    // width: 235.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class SignInButtonBuilder extends StatelessWidget {
  final IconData icon;
  final Widget image;

  final bool mini;

  final String text;

  final double fontSize;

  /// backgroundColor is required but textColor is default to `Colors.white`
  /// splashColor is defalt to `Colors.white30`
  final Color textColor,
      iconColor,
      backgroundColor,
      splashColor,
      highlightColor;

  final Function onPressed;

  /// padding is default to `EdgeInsets.all(3.0)`
  final EdgeInsets padding, innerPadding;

  final ShapeBorder shape;

  final double elevation;

  final double height;

  final double width;

  SignInButtonBuilder({
    Key key,
    @required this.backgroundColor,
    @required this.onPressed,
    @required this.text,
    this.icon,
    this.image,
    this.fontSize = 14.0,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.splashColor = Colors.white30,
    this.highlightColor = Colors.white30,
    this.padding,
    this.innerPadding,
    this.mini = false,
    this.elevation = 2.0,
    this.shape,
    this.height,
    this.width,
  });

  /// The build funtion will be help user to build the signin button widget.
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: key,
      minWidth: mini ? width ?? 35.0 : null,
      height: height,
      elevation: elevation,
      padding: padding ?? EdgeInsets.all(0),
      color: backgroundColor,
      onPressed: onPressed as void Function(),
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: _getButtonChild(context),
      shape: shape ?? ButtonTheme.of(context).shape,
    );
  }

  /// Get the inner content of a button
  Container _getButtonChild(BuildContext context) {
    if (mini) {
      return Container(
        width: height ?? 35.0,
        height: width ?? 35.0,
        child: _getIconOrImage(),
      );
    }
    return Container(
      constraints: BoxConstraints(
        maxWidth: width ?? 220,
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: innerPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 13,
                  ),
              child: _getIconOrImage(),
            ),
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get the icon or image widget
  Widget _getIconOrImage() {
    if (image != null) {
      return image;
    }
    return Icon(
      icon,
      size: 20,
      color: this.iconColor,
    );
  }
}
