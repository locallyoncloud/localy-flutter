import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/views/widgets/mini_loyalty_count.dart';

class MiniLoyaltyCard extends StatelessWidget {
  Function onInfoClick;
  int cardType;
  MiniLoyaltyCard({this.onInfoClick, this.cardType = 0});

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      width: 346,
      height: 136,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14000000),
            offset: Offset(-1.0409498114625029e-15, 17),
            blurRadius: 59,
          ),
        ],
        gradient: RadialGradient(
          center: Alignment(0.0, 0.0),
          radius: 0.715,
          colors: [const Color(0xffeadaa9), const Color(0xff9c8469)],
          stops: [0.0, 1.0],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            color: AppColors.GREY,
            width: 346,
            height: 2,
          ),
          Container(
            width: 346,
            height: 107,
            padding: EdgeInsets.symmetric(horizontal: 13),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/png/mini_loyalty_bg.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 64.0,
                    height: 64.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.0),
                      gradient: RadialGradient(
                        center: Alignment(0.0, 0.0),
                        radius: 0.5,
                        colors: [
                          const Color(0xffeadaa9),
                          const Color(0xff9c8469)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/png/mini_meetlab_logo.png"),
                        fit: BoxFit.contain
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(6, 6),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meet Lab Coffee",
                          style: AppFonts.getMainFont(
                              color: AppColors.WHITE,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ] + renderCardContents(),
                    ),
                  ),
                  InkWell(
                    onTap: onInfoClick,
                    child: Icon(
                      AntDesign.infocirlceo,
                      color: AppColors.WHITE,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.GREY,
            width: 346,
            height: 2,
          )
        ],
      ),
    );
  }
  List<Widget> renderCardContents(){
  switch (cardType){
    case 0:
      return [
        Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.WHITE)
            ),
            child: Wrap(
              spacing: 10,
              children: [
                MiniLoyaltyCount(),
                MiniLoyaltyCount(),
                MiniLoyaltyCount(),
                MiniLoyaltyCount(),
                MiniLoyaltyCount(),
                MiniLoyaltyCount(isActive: false,),
                MiniLoyaltyCount(isActive: false,),
                MiniLoyaltyCount(isActive: false,),
              ],
            )),
        SizedBox(
          height: 6,
        ),
        Text(
          "Hediye için 3 adet kaldı!",
          style: AppFonts.getMainFont(
              color: AppColors.WHITE,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        )
      ];
    case 1:
      return [
        RichText(text: TextSpan(
          text: "36₺",style: AppFonts.getMainFont(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.green
        ),
          children: [
            TextSpan(
              text: " birikmiş paranız var!",style: AppFonts.getMainFont(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.WHITE
            ),
            )
          ]
        ),)
/*
        Text(
          "36₺ birikmiş paranız var!",
          style: AppFonts.getMainFont(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.WHITE
          ),
        )
*/
      ];
  }
  }
}
