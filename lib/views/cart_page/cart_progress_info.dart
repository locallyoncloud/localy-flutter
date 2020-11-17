import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/expanded_loyalty_card.dart';
import 'package:provider/provider.dart';

class CartProgressInfo extends StatelessWidget {
  LoyaltyCard loyaltyCard;

  @override
  Widget build(BuildContext context) {
    loyaltyCard = Provider.of<LoyaltyCard>(context);
    return loyaltyCard == null ? Container(
      child: Center(
        child: Text(
          "Bu firmanın loyalty sistemi bulunmamaktadır.",
          style: AppFonts.getMainFont(
            fontSize: 14,
            color: AppColors.ERROR,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    )
        :
    StreamProvider<LoyaltyProgress>.value(
      catchError: (_,__) => null,
      value: context.watch<HomePageVM>().getUserLoyalty(loyaltyCard.uid, context.watch<RegistrationPageVM>().currentUser.email),
      child: ShowCardText(loyaltyCard)
    );
  }
}

class ShowCardText extends StatelessWidget {
  LoyaltyCard loyaltyCard;
  LoyaltyProgress loyaltyProgress;

  ShowCardText(this.loyaltyCard);

  @override
  Widget build(BuildContext context) {
    loyaltyProgress = Provider.of<LoyaltyProgress>(context);
    return InkWell(
      onTap: (){
        showLoyaltyCard(context);
      },
      child: Text(
        "Loyalty kartınızı görmek için tıklayın",
        style: AppFonts.getMainFont(
            fontSize: 14,
            color: AppColors.GREY,
            textDecoration: TextDecoration.underline,
            fontWeight: FontWeight.w700
        ),
      ),
    );
  }

  showLoyaltyCard(BuildContext context) {
    context.read<CompanyDetailsPageVM>().setCurrentProgress(loyaltyProgress);
    showDialog(
        context: context,
        builder: (_)=> ExpandedLoyaltyCard(loyaltyCard: loyaltyCard,)
    );
  }
}

