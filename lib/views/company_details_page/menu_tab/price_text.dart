import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:supercharged/supercharged.dart';

class PriceText extends StatelessWidget {
  bool selected = false;
  double price;

  PriceText(this.selected, this.price);

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: 300.milliseconds,
      child: Text("${price.toString()}₺"),
      style: selected ?
          TextStyle(
            fontSize: 14,
            color: AppColors.PRIMARY_COLOR,
            fontWeight: FontWeight.w700
          )
          :
      TextStyle(
          fontSize: 12,
          color: AppColors.DISABLED_GREY,
          fontWeight: FontWeight.w700
      ),
    );
  }
}
