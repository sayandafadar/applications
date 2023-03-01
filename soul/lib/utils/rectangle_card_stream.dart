import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:soul/screens/player_screen.dart';
import 'package:soul/utils/rectangle_card.dart';

List<DocumentSnapshot> list;
List<String> fonts = [];

class RectangleCardStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('RectangleMusic')
          .orderBy('songName')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitDoubleBounce(
              color: Colors.white,
              size: 70.0,
            ),
          );
        } else {
          list = snapshot.data.docs;
          List<Widget> rectangleCards = [];
          for (var card in list.reversed) {
            final cardImage = card.get('imageUrl');
            final title = card.get('songName');
            final duration = card.get('duration');
            final category = card.get('category');
            final rectangleCard = RectangleCard(
                image: cardImage,
                title: title,
                duration: duration,
                category: category,
                press: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PlayerScreen(
                          songName: card.get('songName'),
                          artistName: card.get('artistName'),
                          songUrl: card.get('songUrl'),
                          imageUrl: card.get('imageUrl'),
                        );
                      }),
                    ));
            rectangleCards.add(rectangleCard);
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: rectangleCards.length,
            itemBuilder: (context, int index) {
              return rectangleCards[index];
            },
          );
        }
      },
    );
  }
}
