import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class MenuTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BG_WHITE,
      child: Column(
        children: [
          Container(
            height: 50,
            child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8),
                children: List.generate(20, (index) =>
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: AppColors.WHITE,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 6),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "İçecekler",
                          style: AppFonts.getMainFont(
                            color: AppColors.PRIMARY_COLOR,
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    )
                )
            ),
          )
        ],
      ),
    );
  }
}
