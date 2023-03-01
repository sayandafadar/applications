import 'package:flutter/material.dart';
import 'package:soul/utils/constants.dart';

class RectangleCard extends StatelessWidget {
  final Function press;
  final String image;
  final String title;
  final String category;
  final String duration;
  const RectangleCard({
    Key key,
    @required this.press,
    @required this.image,
    @required this.title,
    @required this.category,
    @required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.8, 10, 4.5, 17),
          child: Container(
            width: 305,
            height: 102,
            decoration: BoxDecoration(
              gradient: kSecondaryColorGradient,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 20),
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
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                      child: Container(
                        height: 95,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                              image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 110, top: 18.9),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Varela',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(110, 56.5, 0, 0),
                      height: 20.0,
                      width: 90.0,
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Varela',
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF5CA1A6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 215,
                        top: 56.9,
                      ),
                      child: Text(
                        duration,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
