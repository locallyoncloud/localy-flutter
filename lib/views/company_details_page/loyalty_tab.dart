import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/expanded_loyalty_card.dart';
import 'package:locally_flutter_app/views/widgets/gradient_expanding_button.dart';
import 'package:provider/provider.dart';

class LoyaltyTab extends StatelessWidget {

  Company company;

  LoyaltyTab({this.company});

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 200,
              width: double.infinity,
              child: Hero(
                  tag: "0asd",
                  child:
                  Image.network(company.logo, fit: BoxFit.cover))),
          SizedBox(
            height: 2.hb,
          ),
          Text(
            company.name,
            textAlign: TextAlign.center,
            style: AppFonts.getMainFont(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.GREY),
          ),
          Text(
            company.slogan,
            textAlign: TextAlign.center,
            style: AppFonts.getMainFont(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: AppColors.GREY),
          ),
          SizedBox(
            height: 3.hb,
          ),
          FutureBuilder(
            future: context.watch<HomePageVM>().getClientSideLoyaltyCard(company.company_id),
            builder: (BuildContext context, AsyncSnapshot<LoyaltyCard> snapshot) => renderLoyalties(context, snapshot)
          ),
        ],
      ),
    );
  }

  openLoyalty(BuildContext context, Company company, LoyaltyProgress progress, LoyaltyCard loyaltyCard){
    showDialog(context: context,
        builder: (_) => ExpandedLoyaltyCard(
          company: company,
          loyaltyProgress: progress,
          loyaltyCard: loyaltyCard,
        )
    );
  }

  renderLoyalties(BuildContext context,AsyncSnapshot<LoyaltyCard> snapshot){
    if(snapshot.connectionState== ConnectionState.done && !snapshot.hasData){
      return Container(
          width: 346,
          height: 136,
          color: Colors.red,
        child: Center(
          child: Text(
            "Loyalty Kart Bulunamadı",
            style: AppFonts.getMainFont(
              fontSize: 14,
              color: AppColors.WHITE,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      );
    }else if(snapshot.connectionState== ConnectionState.done && snapshot.hasData){
      return StreamBuilder<DocumentSnapshot>(
        stream: context.watch<HomePageVM>().getLoyaltyProgress(snapshot.data.uid, context.watch<RegistrationPageVM>().currentUser.email),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshotTwo) => renderLoyaltyProgress(context, snapshotTwo,snapshot.data)
      );
    }else if(snapshot.connectionState== ConnectionState.waiting){
      return CircularProgressIndicator(backgroundColor: AppColors.PRIMARY_COLOR,);
    }
  }

  renderLoyaltyProgress(BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot, LoyaltyCard loyaltyCard){
    if(snapshot.connectionState == ConnectionState.active){
      if(snapshot.data.exists){
        return Align(
            alignment: Alignment.center,
            child: GradientExpandingButton( company: company, loyaltyCard: loyaltyCard,isExpanded: true ,loyaltyProgress: LoyaltyProgress.fromJsonMap(snapshot.data.data()),onInfoClick: (Company company, LoyaltyProgress progress, LoyaltyCard loyaltyCard )=>openLoyalty(context,company,progress,loyaltyCard))
        );
      }else{
        return Align(
            alignment: Alignment.center,
            child: GradientExpandingButton( company: company, loyaltyCard: loyaltyCard,isExpanded: false ,loyaltyProgress: LoyaltyProgress(0,0,[]),onInfoClick: (Company company, LoyaltyProgress progress, LoyaltyCard loyaltyCard )=>openLoyalty(context,company,progress,loyaltyCard))
        );

      }
    }else{
      return CircularProgressIndicator();
    }
  }
}
