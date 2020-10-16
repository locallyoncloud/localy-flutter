import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/views/widgets/category.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Category(icon: Icon(FontAwesome.coffee,color: AppColors.WHITE),iconCaption: "Kahve"),
          Category(icon: Icon(FontAwesome.coffee,color: AppColors.WHITE),iconCaption: "Kahve"),
        ],
      ),
    );
  }
}

