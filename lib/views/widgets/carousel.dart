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
    "https://previews.123rf.com/images/blankstock/blankstock2006/blankstock200603093/150287612-sale-50-off-badge-clouds-banner-template-discount-banner-shape-coupon-bubble-icon-online-shopping-ba.jpg",
    "https://previews.123rf.com/images/vectorgift/vectorgift1608/vectorgift160800109/61622829-sale-discount-background-for-the-online-store-shop-promotional-leaflet-promotion-poster-banner-vecto.jpg",
    "https://previews.123rf.com/images/blankstock/blankstock2006/blankstock200601813/149591759-special-offer-badge-discount-banner-template-discount-banner-shape-sale-coupon-bubble-icon-creative-.jpg",
    "https://previews.123rf.com/images/originalwork/originalwork1608/originalwork160800373/61774180-super-sale-banner-design-you-can-use-for-super-sale-promotion-advertising-shopping-flyers-discount-b.jpg",
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
                aspectRatio: 2.0,
                child: Container(
                  child: Image.network(card,
                  fit: BoxFit.fill,
                  ),
                ),
              );
            }
        );
      }).toList(),
    );
  }
}

