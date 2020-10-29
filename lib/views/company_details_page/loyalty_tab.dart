import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/gradient_expanding_button.dart';
import 'package:provider/provider.dart';

class LoyaltyTab extends StatefulWidget {


  @override
  _LoyaltyTabState createState() => _LoyaltyTabState();
}

class _LoyaltyTabState extends State<LoyaltyTab> {

  var myFuture;
  @override
  void initState() {
    super.initState();
    myFuture = context.read<HomePageVM>().getClientSideLoyaltyCard(context.read<CompanyDetailsPageVM>().currentCompany.company_id);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 200,
              width: double.infinity,
              child: Hero(
                  tag: "0asd",
                  child:
                  Image.network(context.watch<CompanyDetailsPageVM>().currentCompany.logo, fit: BoxFit.cover))),
          SizedBox(
            height: 2.hb,
          ),
          Text(
            context.watch<CompanyDetailsPageVM>().currentCompany.name,
            textAlign: TextAlign.center,
            style: AppFonts.getMainFont(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.GREY),
          ),
          Text(
            context.watch<CompanyDetailsPageVM>().currentCompany.slogan,
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
            future:  myFuture,
            builder: (BuildContext context, AsyncSnapshot<LoyaltyCard> snapshot) => renderLoyalties(context, snapshot)
          ),
        ],
      ),
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
        stream:  context.watch<HomePageVM>().getLoyaltyProgress(snapshot.data.uid, context.watch<RegistrationPageVM>().currentUser.email),
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
            child: GradientExpandingButton(loyaltyCard: loyaltyCard,isExpanded: true ,loyaltyProgress: LoyaltyProgress.fromJsonMap(snapshot.data.data()),)
        );
      }else{
        return Align(
            alignment: Alignment.center,
            child: GradientExpandingButton( loyaltyCard: loyaltyCard,isExpanded: false ,loyaltyProgress: LoyaltyProgress(0,0,[]))
        );

      }
    }else{
      return CircularProgressIndicator();
    }
  }
}
