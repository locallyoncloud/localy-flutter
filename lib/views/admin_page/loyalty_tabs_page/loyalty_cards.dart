import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'file:///E:/Flutter_Projects/localy/localy_main/lib/views/admin_page/loyalty_tabs_page/loyalty_cards_first_tab.dart';
import 'file:///E:/Flutter_Projects/localy/localy_main/lib/views/admin_page/loyalty_tabs_page/loyalty_cards_second_tab.dart';
import 'file:///E:/Flutter_Projects/localy/localy_main/lib/views/admin_page/loyalty_tabs_page/loyalty_cards_third_tab.dart';
import 'package:provider/provider.dart';

class LoyaltyCards extends StatefulWidget {

  @override
  _LoyaltyCardsState createState() => _LoyaltyCardsState();
}

class _LoyaltyCardsState extends State<LoyaltyCards> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.1,
              backgroundColor: AppColors.PRIMARY_COLOR,
              title: Text(
                "Tüm Loyalty Kartlarım",
                style: AppFonts.getMainFont(color: AppColors.WHITE),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(AntDesign.gift)),
                  Tab(icon: Icon(Foundation.dollar_bill)),
                  Tab(icon: Icon(Ionicons.md_star)),
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
                        LoyaltyCardsFirstTab(loyaltyCardList: loyaltyCardList.where((loyaltyCard) => loyaltyCard.type==0).toList(),),
                        LoyaltyCardsSecondTab(loyaltyCardList: loyaltyCardList.where((loyaltyCard) => loyaltyCard.type==1).toList(),),
                        LoyaltyCardsThirdTab(loyaltyCardList: loyaltyCardList.where((loyaltyCard) => loyaltyCard.type==2).toList(),),
                      ]
                  );
                }
              },
            ),
          )
        ),
      ),
    );
  }
}
