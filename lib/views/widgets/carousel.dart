import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  ValueKey key;

  Carousel(this.key);

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<Carousel> {
  int _currentIndex=0;
  List cardList=[
    "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/banner_pictures%2Fmeetlab_banner1.jpeg?alt=media&token=86af65a4-6207-4daa-a648-7fec440ace80",
    "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/banner_pictures%2Fmeetlab_banner2.jpeg?alt=media&token=bebfde6c-e696-44d5-9ff8-7e3d53a1d292",
    "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/banner_pictures%2Fmeetlab_banner3.jpeg?alt=media&token=e3574f8a-2736-4302-836c-f95a8caeb842",
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      key: widget.key,
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        viewportFraction: 0.7,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        enlargeCenterPage: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        //aspectRatio: 3/4,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      items: cardList.map((card){
        return Builder(
            builder:(BuildContext context){
              return AspectRatio(
                aspectRatio: 1.58,
                child: Container(
                  child: Image.network(card,
                  fit: BoxFit.contain,
                  ),
                ),
              );
            }
        );
      }).toList(),
    );
  }
}

