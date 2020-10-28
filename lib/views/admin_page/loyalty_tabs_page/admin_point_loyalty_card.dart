import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';

class AdminPointLoyaltyCard extends StatelessWidget {
  LoyaltyCard loyaltyCard;

  AdminPointLoyaltyCard(this.loyaltyCard);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.hexToColor(loyaltyCard.backgroundColor),
        ),
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  loyaltyCard.miniLogo,
                  width: 53,
                  height: 48,
                ),
                Text(
                  context
                      .watch<AdminPanelVM>()
                      .currentSelectedCompany
                      .category
                      .toUpperCase(),
                  style: AppFonts.getMainFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.hexToColor(loyaltyCard.textColor)),
                )
              ],
            ),
            Container(
              height: 122,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.network(
                    loyaltyCard.logo,
                    fit: BoxFit.fill,
                  )),
                  Positioned.fill(
                      child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    color: Colors.grey.withOpacity(loyaltyCard.imageOpacity),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          IconData(loyaltyCard.iconData.codePoint,
                              fontFamily: loyaltyCard.iconData.fontFamily,
                              fontPackage: "flutter_vector_icons"),
                          size: 80,
                          color: AppColors.hexToColor(loyaltyCard.iconColor),
                        ),
                        Text(
                          "50",
                          style: AppFonts.getMainFont(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )
          ],
        ));
  }
}
