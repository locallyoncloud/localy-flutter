import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.BG_WHITE,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 310,
              height: 140,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.PRIMARY_COLOR
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(MaterialCommunityIcons.format_paint,color: AppColors.WHITE,size: 50,),
                  Container(
                    height: 140,
                    width: 210,
                    child: Center(
                      child: Text("Kendi Loyalty Kartını Tasarla",
                        textAlign: TextAlign.center,
                        style: AppFonts.getMainFont(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.WHITE
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 310,
              height: 140,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.PRIMARY_COLOR
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Ionicons.md_barcode,color: AppColors.WHITE,size: 50,),
                  Container(
                    height: 140,
                    width: 210,
                    child: Center(
                      child: Text("QR Kod Okut",
                        style: AppFonts.getMainFont(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppColors.WHITE
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
