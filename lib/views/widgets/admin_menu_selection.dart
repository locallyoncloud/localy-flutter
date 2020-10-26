import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:provider/provider.dart';

class AdminMenuSelection extends StatelessWidget {
  Color backgroundColor;
  String text;
  IconData iconData;
  bool isReverse;
  Function onClick;

  AdminMenuSelection(
      {this.backgroundColor, this.text, this.iconData, this.isReverse, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 331.0,
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: !isReverse
              ? BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0),
                ),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(6, 6),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: !isReverse
              ? [
                  Text(text,
                      style: AppFonts.getMainFont(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ADMIN_GREY)),
                  Icon(iconData, color: AppColors.ADMIN_GREY, size: 50)
                ]
              : [
                  Icon(iconData, color: AppColors.ADMIN_GREY, size: 50),
                  Text(text,
                      style: AppFonts.getMainFont(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ADMIN_GREY)),
                ],
        ),
      ),
    );
  }
}
