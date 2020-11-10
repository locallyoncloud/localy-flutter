import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ExpandedLoyaltyCard extends StatelessWidget {

  LoyaltyCard loyaltyCard;

  ExpandedLoyaltyCard({ this.loyaltyCard});

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(context.watch<CompanyDetailsPageVM>().currentCompany.mini_logo,width: 53, height: 48,),
                  Container(
                    child: Column(
                      children: [
                         Text(
                          context.watch<CompanyDetailsPageVM>().currentCompany.category.toUpperCase(),
                          style: AppFonts.getMainFont(
                              fontSize: loyaltyCard.type == 0 ? 10 : 14 ,
                              fontWeight: FontWeight.w700,
                              color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        ) ,
                        loyaltyCard.type == 0 ? Text(
                          "${context.watch<CompanyDetailsPageVM>().currentProgress.progress.round()}/${loyaltyCard.target}",
                          style: AppFonts.getMainFont(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        ) : Container()
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
                      child: Image.network(context.watch<CompanyDetailsPageVM>().currentCompany.logo,fit: BoxFit.fill,)
                  ),
                  Positioned.fill(
                      child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          color: Colors.grey.withOpacity(loyaltyCard.imageOpacity),
                          child: renderCardContents(context)
                      )
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
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.hexToColor(loyaltyCard.textColor)
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: loyaltyCard.type == 0 ? true : false,
                    child: Container(
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
                            context.watch<CompanyDetailsPageVM>().currentProgress.gifts.toString(),
                            style: AppFonts.getMainFont(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.hexToColor(loyaltyCard.textColor)
                            ),
                          )
                        ],
                      ),
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
                    data: "${context.watch<RegistrationPageVM>().currentUser.email}/${loyaltyCard.type}/${loyaltyCard.target}/${loyaltyCard.uid}/${loyaltyCard.percentage.toString()}/localy",
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

  Widget renderCardContents(BuildContext context){
    switch (loyaltyCard.type){
      case 0:
          return Wrap(
            spacing: 30,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: List.generate(loyaltyCard.target, (index) =>
                Icon(
                  IconData(loyaltyCard.iconData.codePoint,fontFamily: loyaltyCard.iconData.fontFamily,fontPackage: "flutter_vector_icons"),
                  color: index+1 <= context.watch<CompanyDetailsPageVM>().currentProgress.progress ? AppColors.hexToColor(loyaltyCard.iconColor) : Colors.white,
                  size: loyaltyCard.iconSize,
                )),
          );
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Birikmiş Paranız:",
              style: AppFonts.getMainFont(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                textDecoration: TextDecoration.underline,
                color: AppColors.hexToColor(loyaltyCard.iconColor),
              ),
            ),
            Text(
              "${context.watch<CompanyDetailsPageVM>().currentProgress.progress}₺",
              style: AppFonts.getMainFont(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: AppColors.hexToColor(loyaltyCard.iconColor),
              ),
            )
          ],
        );
      case 2:
        return Stack(
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
              context.watch<CompanyDetailsPageVM>().currentProgress.progress.toString(),
              style: AppFonts.getMainFont(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: AppColors.hexToColor(loyaltyCard.textColor)
              ),
            )
          ],
        );
    }
  }
}
