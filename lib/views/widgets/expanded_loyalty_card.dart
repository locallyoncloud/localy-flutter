import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

class ExpandedLoyaltyCard extends StatelessWidget {

  Company company;
  LoyaltyProgress loyaltyProgress;
  LoyaltyCard loyaltyCard;


  ExpandedLoyaltyCard({ this.company, this.loyaltyProgress, this.loyaltyCard});

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Dialog(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
      child: Container(
        width: 300,
        height: 420,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.hexToColor(loyaltyCard.backgroundColor),
        ),
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(company.mini_logo,width: 53, height: 48,),
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
                        "${loyaltyProgress.progress}/${loyaltyCard.target}",
                        style: AppFonts.getMainFont(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.hexToColor(loyaltyCard.textColor)
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 122,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.network(company.logo,fit: BoxFit.fill,)
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
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.watch<RegistrationPageVM>().currentUser.name !=null ? "AD SOYAD" : "E-MAIL",
                          style: AppFonts.getMainFont(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        ),
                        Text(
                          context.watch<RegistrationPageVM>().currentUser.name ?? context.watch<RegistrationPageVM>().currentUser.email,
                          style: AppFonts.getMainFont(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "HEDİYE",
                          style: AppFonts.getMainFont(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        ),
                        Text(
                          loyaltyProgress.gifts.toString(),
                          style: AppFonts.getMainFont(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        )
                      ],
                    ),
                  )
                ],
            ),
            ),
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: QrImage(
                    data: context.watch<RegistrationPageVM>().currentUser.email,
                    version: QrVersions.auto,
                    size: 130,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
