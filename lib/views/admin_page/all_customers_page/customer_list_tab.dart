import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/all_customers_page/customer_list_item.dart';
import 'package:provider/provider.dart';

class CustomerListTab extends StatefulWidget {
  int tabIndex;

  CustomerListTab(this.tabIndex);

  @override
  _CustomerListTabState createState() => _CustomerListTabState();
}

class _CustomerListTabState extends State<CustomerListTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: context.watch<AdminPanelVM>().getAllCustomersForCard(
            context.watch<RegistrationPageVM>().currentUser.company_id,
            widget.tabIndex),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.connectionState == ConnectionState.active ) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomerListItem(
                      LoyaltyProgress.fromJsonMap(
                          snapshot.data.docs[index].data()),
                      widget.tabIndex);
                },
              );
            } else {
              return Center(
                child: Text(
                  "Müşteri Bulunamadı",
                  style: AppFonts.getMainFont(
                      fontSize: 14,
                      color: AppColors.GREY,
                      fontWeight: FontWeight.w900),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
