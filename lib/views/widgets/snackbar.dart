import 'package:flutter/material.dart';

import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';

import 'package:supercharged/supercharged.dart';


class CustomSnackbar  {
  static Widget buildSnackbar(Color backgroundColor, String text, BuildContext context) {
    ScreenSize.recalculate(context);
    return SnackBar(
      duration: 5.seconds,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.fixed,
      elevation: 6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
      ),
      content: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColors.WHITE,
          fontWeight: FontWeight.w700,
          fontSize: 14
        ),
      )
    );
  }
}

/*class CustomSnackbar extends StatelessWidget {
  String snackbarText;
  Color backgroundColor;

  CustomSnackbar({this.snackbarText, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return SnackBar(
        duration: 5.seconds,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
        ),
        content: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "Deneme Snackbarı",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: AppColors.WHITE,
                fontWeight: FontWeight.w700,
                fontSize: 14
            ),
          ),
        )
    );

  }
}*/

