import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:lottie/lottie.dart';

class NoDataFoundPage extends StatelessWidget {
  String animationPath, title;

  NoDataFoundPage(this.animationPath, this.title);

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70.wb,
            child: AspectRatio(
              aspectRatio: 0.9,
              child: Lottie.asset(
                  animationPath,
                  fit: BoxFit.contain),
            ),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                color: AppColors.PRIMARY_COLOR,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
