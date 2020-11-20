import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NoCardFound extends StatelessWidget {
  int cardType;

  NoCardFound(this.cardType);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Kart Bulunamadı",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppColors.GREY),
        ),
        RaisedButton(
          onPressed: () {
            addnewLoyaltyCard(context);
          },
          color: AppColors.GREEN,
          child: Text("Kart Oluştur",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.WHITE)),
        )
      ],
    );
  }
  addnewLoyaltyCard(BuildContext context) async {
    var uuid = Uuid().v4();
    LoyaltyCard newLoyaltyCard = LoyaltyCard(
        uid: uuid,
        backgroundColor: "#000000",
        textColor: "#FFFFFF",
        iconColor: "#00904c",
        backgroundImage: "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/placeholder_image.jpg?alt=media&token=60820f73-af25-43a4-89a7-f9027dd3523c",
        company_id: context.read<RegistrationPageVM>().currentUser.company_id,
        iconData: IconDataInfo(fontFamily: "FontAwesome",codePoint: 61684),
        isActive: false,
        logo: "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/placeholder_image.jpg?alt=media&token=60820f73-af25-43a4-89a7-f9027dd3523c",
        miniLogo: "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/placeholder_image.jpg?alt=media&token=60820f73-af25-43a4-89a7-f9027dd3523c",
        sector: context.read<AdminPanelVM>().currentSelectedCompany.category,
        target: 8,
        type: cardType,
        iconSize: 24,
        imageOpacity: 0.8,
        percentage: 0
    );
    await context.read<AdminPanelVM>().addLoyaltyCard(newLoyaltyCard);
  }

}

