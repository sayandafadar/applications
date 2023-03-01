import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:soul/screens/player_screen.dart';
import 'package:soul/utils/seassion_card.dart';

List<DocumentSnapshot> list;
List<String> fonts = [];

class MusicStream extends StatelessWidget {
  final String category;

  const MusicStream({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(category)
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
          List<SeassionCard> sessionCards = [];
          for (var card in list) {
            final cardImage = card.get('imageUrl');
            final title = card.get('songName');
            final duration = card.get('duration');
            final fontFamily = card.get('fontFamily');
            final sessionCard = SeassionCard(
                cardImage: cardImage,
                title: title,
                duration: duration,
                fontFamily: fontFamily,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PlayerScreen(
                      songName: card.get('songName'),
                      artistName: card.get('artistName'),
                      songUrl: card.get('songUrl'),
                      imageUrl: card.get('imageUrl'),
                    );
                  }));
                });

            sessionCards.add(sessionCard);
          }
          return ListView(
            children: [
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: sessionCards,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
