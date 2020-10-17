import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';

class CompanyDetails extends StatelessWidget {
  final companyDetailName;
  final companyDetailLogo;

  CompanyDetails({this.companyDetailName, this.companyDetailLogo});

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: AppColors.PRIMARY_COLOR,
        title: Text(
          'Meet Lab Coffee',
          style: AppFonts.getMainFont(color: AppColors.WHITE),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: AppColors.WHITE),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.shopping_cart, color: AppColors.WHITE),
              onPressed: () {})
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Hero(
                  tag: "0asd",
                  child: Image.asset(companyDetailLogo, fit: BoxFit.contain))
            ),
            SizedBox(
              height: 3.hb,
            ),
            Text(
              "Meet Lab Coffee",
              textAlign: TextAlign.center,
              style: AppFonts.getMainFont(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.GREY
              ),
            ),
            Text(
                  "Nitelikli kahve dükkanı",
              textAlign: TextAlign.center,
              style: AppFonts.getMainFont(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: AppColors.GREY
              ),
            ),
            SizedBox(
              height: 3.hb,
            ),
            Container(
              child: Column(
                children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 123,
                          height: 123,
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(color: AppColors.GREY), bottom: BorderSide(color: AppColors.GREY))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                MaterialIcons.loyalty,
                                size: 40,
                              ),
                              Text(
                                "Loyalty",
                                style: AppFonts.getMainFont(
                                  color: AppColors.GREY,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 123,
                          height: 123,
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.GREY))
                          ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                    MaterialCommunityIcons.book_open,
                                    size: 40,
                                ),
                                Text(
                                  "Ürünler",
                                  style: AppFonts.getMainFont(
                                      color: AppColors.GREY,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900
                                  ),
                                )
                              ],
                            )
                        )

                      ],

                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 123,
                        height: 123,
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(color: AppColors.GREY),)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                MaterialIcons.add_shopping_cart,
                                size: 40,
                            ),
                            Text(
                              "Gel Al",
                              style: AppFonts.getMainFont(
                                  color: AppColors.GREY,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: 123,
                          height: 123,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                  MaterialIcons.shopping_cart,
                                size: 40,
                              ),
                              Text(
                                "Biz getirelim",
                                style: AppFonts.getMainFont(
                                    color: AppColors.GREY,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900
                                ),
                              )
                            ],
                          )
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
