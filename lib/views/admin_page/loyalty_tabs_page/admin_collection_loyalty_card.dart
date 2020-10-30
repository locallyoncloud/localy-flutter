import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:provider/provider.dart';

class AdminCollectionLoyaltyCard extends StatelessWidget {

  LoyaltyCard loyaltyCard;

  AdminCollectionLoyaltyCard(this.loyaltyCard);

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(loyaltyCard.miniLogo ,width: 53, height: 48,),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          context.watch<AdminPanelVM>().currentSelectedCompany.category.toUpperCase(),
                          style: AppFonts.getMainFont(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        ),
                        Text(
                          "1/8",
                          style: AppFonts.getMainFont(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 122,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.network(loyaltyCard.logo,fit: BoxFit.fill,)
                  ),
                  Positioned.fill(
                      child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          color: Colors.grey.withOpacity(loyaltyCard.imageOpacity),
                          child: Wrap(
                            spacing: 30,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            children: List.generate(loyaltyCard.target, (index) =>
                                Icon(
                                  IconData(loyaltyCard.iconData.codePoint,fontFamily: loyaltyCard.iconData.fontFamily,fontPackage: "flutter_vector_icons"),
                                  color: index+1<=1 ? AppColors.hexToColor(loyaltyCard.iconColor) : Colors.white,
                                  size: loyaltyCard.iconSize,
                                )),
                          ) )
                  )],
              ),
            )
          ],
        )
    );
  }
}
