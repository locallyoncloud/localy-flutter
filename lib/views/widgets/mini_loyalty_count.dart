import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';

class MiniLoyaltyCount extends StatelessWidget {
  bool isActive;

  MiniLoyaltyCount({this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
        gradient: isActive ? RadialGradient(
          center: Alignment(0.0, 0.0),
          radius: 0.5,
          colors: [const Color(0xffeadaa9), const Color(0xff9c8469)],
          stops: [0.0, 1.0],
        ) :  null,
        color: isActive ? null : AppColors.WHITE
      ),
    );
  }
}
