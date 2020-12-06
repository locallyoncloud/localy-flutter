import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/loyalty_tabs_page/loyalty_cards_tabs.dart';
import 'package:provider/provider.dart';

class LoyaltyCards extends StatefulWidget {

  @override
  _LoyaltyCardsState createState() => _LoyaltyCardsState();
}

class _LoyaltyCardsState extends State<LoyaltyCards> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: UtilityWidgets.CustomAppBar(
            Text(
              "Tüm Loyalty Kartlarım",
              style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
            TabBar(
              tabs: [
                Tab(icon: Icon(AntDesign.gift,color: AppColors.PRIMARY_COLOR,)),
                Tab(icon: Icon(Foundation.dollar_bill,color: AppColors.PRIMARY_COLOR,)),
                Tab(icon: Icon(Ionicons.md_star,color: AppColors.PRIMARY_COLOR,)),
              ],
            ),
          ),
        body: Container(
          color: AppColors.BG_WHITE,
          child: StreamBuilder(
            stream: context.watch<AdminPanelVM>().getAdminSideLoyaltyCards(context.watch<RegistrationPageVM>().currentUser.company_id),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }else{
                List<LoyaltyCard> loyaltyCardList = [];
                snapshot.data.docs.forEach((doc) {
                  loyaltyCardList.add(LoyaltyCard.fromJsonMap(doc.data()));
                });
                return TabBarView(
                    children: [
                      LoyaltyCardsTabs(loyaltyCardList: loyaltyCardList.where((loyaltyCard) => loyaltyCard.type==0).toList(),index: 0,),
                      LoyaltyCardsTabs(loyaltyCardList: loyaltyCardList.where((loyaltyCard) => loyaltyCard.type==1).toList(),index: 1),
                      LoyaltyCardsTabs(loyaltyCardList: loyaltyCardList.where((loyaltyCard) => loyaltyCard.type==2).toList(),index: 2),
                    ]
                );
              }
            },
          ),
        )
      ),
    );
  }
}
