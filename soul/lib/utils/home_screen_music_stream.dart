import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:soul/screens/player_screen.dart';
import 'package:soul/utils/seassion_card.dart';

List<DocumentSnapshot> list;
List<String> fonts = [];

class HomeScreenStream extends StatelessWidget {
  final String category;

  const HomeScreenStream({Key key, @required this.category}) : super(key: key);
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
          List<Container> homeScreenSeasssionCards = [];
          for (var card in list.reversed) {
            final cardImage = card.get('imageUrl');
            final title = card.get('songName');
            final duration = card.get('duration');
            final fontFamily = card.get('fontFamily');
            final sessionCard = SizerUtil.deviceType == DeviceType.mobile
                ? Container(
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SeassionCard(
                        cardImage: cardImage,
                        title: title,
                        duration: duration,
                        fontFamily: fontFamily,
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
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 297,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SeassionCard(
                        cardImage: cardImage,
                        title: title,
                        duration: duration,
                        fontFamily: fontFamily,
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
                        ),
                      ),
                    ));

            homeScreenSeasssionCards.add(sessionCard);
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeScreenSeasssionCards.length,
            itemBuilder: (context, int index) {
              return homeScreenSeasssionCards[index];
            },
          );
        }
      },
    );
  }
}
