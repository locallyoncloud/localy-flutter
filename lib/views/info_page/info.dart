import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BG_WHITE,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Material(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)
            ),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Meet Lab Coffee",
                  style: AppFonts.getMainFont(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.GREY,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Nitelikli kahve dükkanı",
                  style: AppFonts.getMainFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.GREY,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Adres: ",
                  style: AppFonts.getMainFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: AppColors.GREY,
                    textDecoration: TextDecoration.underline
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Suadiye Mah, Plaj Yolu Sk. No:18, 34740, 34740 Kadıköy/İstanbul",
                  textAlign: TextAlign.center,
                  style: AppFonts.getMainFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.GREY,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Çalışma saatleri:",
                  style: AppFonts.getMainFont(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.GREY,
                      textDecoration: TextDecoration.underline),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    renderDay("Pazartesi"),
                    renderDay("Salı"),
                    renderDay("Çarşamba"),
                    renderDay("Perşembe"),
                    renderDay("Cuma"),
                    renderDay("Cumartesi"),
                    renderDay("Pazar"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/png/free_wifi.png",width: 110 , height: 69),
                    Image.asset("assets/png/pet_friendly.png",width: 135 , height: 135)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  renderDay(String day) {
    return Text(
      "${day} : 7:30 - 24:00",
      style: AppFonts.getMainFont(
          fontSize: 14, color: AppColors.GREY, fontWeight: FontWeight.w700),
    );
  }
}
