import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/views/widgets/category.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(1, (index) =>
            /*Category(icon: Icon(FontAwesome.coffee,color: AppColors.WHITE),iconCaption: "Kahve"
            ),*/
            Padding(
              padding:  EdgeInsets.only(left: index!=0 ? 10 : 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Icon(
                        FontAwesome.coffee,
                        color: Color(0xff4E4B4B),
                      size: 30,
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Coffee",
                    style: AppFonts.getMainFont(
                      fontSize: 14,
                      color: Color(0xff4E4B4B),
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),
            )
        )
      ),
    );
  }
}

