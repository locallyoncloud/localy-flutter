import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class LoyaltyEditButton extends StatelessWidget {
  Function onClick;
  String text;
  IconData iconData;

  LoyaltyEditButton({this.onClick, this.text, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: ()=> onClick(),
            child: Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 7),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  iconData,
                  color: AppColors.PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 70,
            child: Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: AppFonts.getMainFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.PRIMARY_COLOR
              ),
            ),
          ),
        ],
      ),
    );
  }
}
