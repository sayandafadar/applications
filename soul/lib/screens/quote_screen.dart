import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quotes/quotes.dart';

class QuoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Color> containerColor = [
      Color(0xFF867ae9),
      Color(0xFF1eae98),
      Color(0xFFff8474),
      Color(0xFF00adb5),
    ];
    final double height = MediaQuery.of(context).size.height;
    List<Widget> imageSliders = [
      QuoteScreenWidget(
        containerColor: containerColor[0],
        quote: Quotes.getRandom().getContent(),
        author: Quotes.getRandom().getAuthor(),
      ),
      QuoteScreenWidget(
        containerColor: containerColor[1],
        quote: Quotes.getRandom().getContent(),
        author: Quotes.getRandom().getAuthor(),
      ),
      QuoteScreenWidget(
        containerColor: containerColor[2],
        quote: Quotes.getRandom().getContent(),
        author: Quotes.getRandom().getAuthor(),
      ),
      QuoteScreenWidget(
        containerColor: containerColor[3],
        quote: Quotes.getRandom().getContent(),
        author: Quotes.getRandom().getAuthor(),
      ),
    ];
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          height: height,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          aspectRatio: 2.0,
          enableInfiniteScroll: false,
          initialPage: 0,
          autoPlay: false,
        ),
        items: imageSliders,
      ),
    );
  }
}

class QuoteScreenWidget extends StatelessWidget {
  const QuoteScreenWidget({
    Key key,
    @required this.containerColor,
    @required this.quote,
    @required this.author,
  }) : super(key: key);

  final Color containerColor;
  final String quote;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
      ),
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              quote,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'Varela',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 1.4,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 160.0),
            child: Divider(
              color: Color(0xFF48507E),
              thickness: 3.5,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            author,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.0,
              fontFamily: 'Varela',
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
