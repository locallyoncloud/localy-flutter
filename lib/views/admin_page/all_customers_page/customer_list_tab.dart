import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/all_customers_page/customer_list_item.dart';
import 'package:provider/provider.dart';

class CustomerListTab extends StatelessWidget {
  int tabIndex;

  CustomerListTab(this.tabIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<LoyaltyProgress>>(
        future: context.watch<AdminPanelVM>().getAllCustomersForCard(context.watch<RegistrationPageVM>().currentUser.company_id,tabIndex),
        builder: (context,snapshot) {
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }else{
            if(snapshot.data.length>0){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomerListItem(snapshot.data[index],tabIndex);
                },
              );
            }else{
              return Center(
                child: Text(
                  "Müşteri Bulunamadı",
                  style: AppFonts.getMainFont(
                    fontSize: 14,
                    color: AppColors.GREY,
                    fontWeight: FontWeight.w900
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
