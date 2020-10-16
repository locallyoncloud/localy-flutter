import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class Category extends StatelessWidget {
  final Icon icon;
  final double width, height;
  final String iconCaption;
  final VoidCallback onclick;
  Category({@required this.icon, this.iconCaption="",this.width = 52, this.height = 53, this.onclick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () {}, //onclick
        child: Column(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                gradient: RadialGradient(
                  center: Alignment(0.0, 0.0),
                  radius: 0.432,
                  colors: [const Color(0xffa1c9dc), const Color(0xff455a64)],
                  stops: [0.0, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: icon,
              ),
            ),
            SizedBox(height: 4),
            Text(iconCaption, style: AppFonts.getMainFont(color: AppColors.GREY))
          ],
        ),
      ),
    );
  }
}