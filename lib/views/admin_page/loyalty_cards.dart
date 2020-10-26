import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:provider/provider.dart';

class LoyaltyCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Container(
              child: StreamBuilder(
                stream: context.watch<AdminPanelVM>().getAdminSideLoyaltyCards(context.read<RegistrationPageVM>().currentUser.company_id),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                },
              ),
            )
          ],
        ),
      )
    );
  }
}
