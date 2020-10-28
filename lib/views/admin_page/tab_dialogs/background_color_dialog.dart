import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class BackgroundColorDialog extends StatelessWidget {
  Color initialColor, newColor;

  BackgroundColorDialog({this.initialColor});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 300,
        height: 420,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.WHITE),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleColorPicker(
              initialColor: initialColor,
              onChanged: (color) => newColor = color,
              size: const Size(240, 240),
              strokeWidth: 4,
              thumbSize: 36,
            ),
            RaisedButton(
                onPressed: ()=>changeBackground(),
                color: AppColors.PRIMARY_COLOR,
                child: Text(
                  "Değiştir",
                  style: AppFonts.getMainFont(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.WHITE
                  ),
                ),
            )
          ],
        )
        ),
      );
  }

  changeBackground() {
    Get.back(result: newColor ?? initialColor);
  }
}
