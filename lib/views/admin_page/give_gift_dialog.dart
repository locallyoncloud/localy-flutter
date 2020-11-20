import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/views/widgets/number_picker.dart';

class GiveGiftDialog extends StatelessWidget {

  int maxAvailableGift;

  GiveGiftDialog(this.maxAvailableGift);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      child: Container(
        width: 300,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NumberPicker(maxCount: maxAvailableGift,),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: ()=>giveGift(),
            color: AppColors.PRIMARY_COLOR,
            child: Text(
              "Hediye Ver",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.WHITE
              ),
            ),
          )
        ],
      ),
      ),
    );
  }

  giveGift() {
    Get.back(result: true);
  }
}
