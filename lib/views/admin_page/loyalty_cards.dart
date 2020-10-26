import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:provider/provider.dart';

class LoyaltyCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: AppColors.BG_WHITE,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Sahip olduğunuz kartlar:",
                style: AppFonts.getMainFont(
                    fontSize: 18,
                    color: AppColors.PRIMARY_COLOR,
                    fontWeight: FontWeight.w700
                ),
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: context.watch<AdminPanelVM>().getAdminSideLoyaltyCards(context.watch<RegistrationPageVM>().currentUser.company_id),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(!snapshot.hasData){
                        return CircularProgressIndicator();
                      }
                       return renderCards(context, snapshot);

                    },
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget renderCards(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    ScreenSize.recalculate(context);

    return Container(
      width: double.infinity,

      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.PRIMARY_COLOR,
            ),
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text(
                index.toString(),
                style: AppFonts.getMainFont(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.WHITE),
              ),
            ),
          );
        },
      ),
    );
  }
}
