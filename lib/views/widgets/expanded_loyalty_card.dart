import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';

class ExpandedLoyaltyCard extends StatelessWidget {
  Function onButtonClick;

  ExpandedLoyaltyCard(this.onButtonClick);

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: 50.wb,
          height: 50.hb,
          color: AppColors.GREEN,
          child: Center(
            child: RaisedButton(
              onPressed: onButtonClick,
              child: Text(
                "Deneme"
              ),
            ),
          ),
        ),
      ),
    );
  }
}
