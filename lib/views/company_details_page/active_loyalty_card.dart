import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/gradient_expanding_button.dart';
import 'package:provider/provider.dart';

class ActiveLoyaltyCard extends StatefulWidget {
  LoyaltyCard loyaltyCard;

  ActiveLoyaltyCard(this.loyaltyCard);

  @override
  _ActiveLoyaltyCardState createState() => _ActiveLoyaltyCardState();
}

class _ActiveLoyaltyCardState extends State<ActiveLoyaltyCard> {
  @override
  void initState() {
    super.initState();
      context
          .read<HomePageVM>()
          .getLoyaltyProgress(widget.loyaltyCard.uid,
              context.read<RegistrationPageVM>().currentUser.email)
          .listen((event) {
              context
                  .read<CompanyDetailsPageVM>()
                  .setCurrentProgress(event.exists ? LoyaltyProgress.fromJsonMap(event.data()) : null);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
             Align(
                alignment: Alignment.center,
                child: GradientExpandingButton(
                    loyaltyCard: widget.loyaltyCard,
                  loyaltyProgress: context.watch<CompanyDetailsPageVM>().currentProgress,
              )
             )
    );
  }
}
