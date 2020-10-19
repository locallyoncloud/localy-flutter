import 'package:flutter/material.dart';

class HomePageVM extends ChangeNotifier{
  bool hideCarousel  = false;

  setCarouselVisibility(bool carouselStatus){
    hideCarousel = carouselStatus;
    notifyListeners();
  }

}