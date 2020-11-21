import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locally_flutter_app/models/public_profile.dart';
import 'package:locally_flutter_app/models/address.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/user_profile_page/add_address_dialog.dart';
import 'package:provider/provider.dart';


class ProfileAddresses extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PublicProfile userProfile = context.watch<RegistrationPageVM>().currentUser;
    ScreenSize.recalculate(context);
    return Scaffold(
        backgroundColor: AppColors.BG_WHITE,
        appBar: UtilityWidgets.CustomAppBar(
            Text("Adreslerim",
                style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)
            ),
            null),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: userProfile.address.length>0 ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: userProfile.address.length > 0 ? [
            Expanded(
              child: ListView.builder(
                itemCount: userProfile.address.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index == userProfile.address.length ?
                      renderAddAddressButton(context)
                      : ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.PRIMARY_COLOR,
                      size: 35,
                    ),
                    title: Text(
                      userProfile.address[index].name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: AppColors.PRIMARY_COLOR
                      ),
                    ),
                    subtitle: Text(
                        userProfile.address[index].openAddress,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.GREY
                        )
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: AppColors.ERROR,
                        size: 30,
                      ), onPressed: () => removeAddress(context, userProfile.address[index]),
                    ),
                  );
                },
              ),
            ),
          ] :
          [
            Text(
                "Kayıtlı adresiniz bulunmamaktadır.",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.PRIMARY_COLOR
                )
            ),
            SizedBox(
              height: 10,
            ),
            renderAddAddressButton(context)
          ],
        )
      ),
    );
  }

  renderAddAddressButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 44,
        child: RaisedButton(
          elevation: 10,
          color: AppColors.WHITE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                color: AppColors.PRIMARY_COLOR,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Adres Ekle",
                style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
              )
            ],
          ),
          onPressed: () => openAddAddressDialog(context),
        ),
      ),
    );
  }

  openAddAddressDialog(BuildContext context) {
    showDialog(context: context,
    barrierDismissible: false,
    builder: (dialogContext)=> AddAddressDialog()
    );
  }

  removeAddress(BuildContext context,Address address) async {
    await context.read<RegistrationPageVM>().updateUserAddress(address, context.read<RegistrationPageVM>().currentUser.email, false);
  }
}
