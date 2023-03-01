import 'package:flutter/material.dart';
import 'package:soul/utils/constants.dart';

class SeassionCard extends StatelessWidget {
  final Function press;
  final String cardImage;
  final String duration;
  final String title;
  final String category;
  final String fontFamily;
  const SeassionCard({
    Key key,
    this.press,
    this.cardImage,
    this.duration,
    this.title,
    this.category,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Material(
        elevation: 27,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              width: constraint.maxWidth / 2 - 14,
              height: constraint.maxWidth / 1.63,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: kMeditationScreenColor,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    cardImage,
                  ),
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.cover,
                ),
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
                  onTap: press,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                        height: 17.0,
                        width: 50.0,
                        child: Center(
                          child: Text(
                            duration,
                            style: TextStyle(
                              fontSize: 9.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0x55FFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 33.0,
                            fontFamily: fontFamily,
                          ),
                        ),
                      ),
                      // Center(
                      //   child: Container(
                      //     margin: EdgeInsets.fromLTRB(0.0, 170.0, 0, 0),
                      //     height: 19.0,
                      //     width: 70.0,
                      //     child: Center(
                      //       child: Flexible(
                      //         child: Text(
                      //           'Sleep',
                      //           style: TextStyle(
                      //             fontSize: 8.0.sp,
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: Color(0x55FFFFFF),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
