import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/models/address.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/multiline_textfield.dart';
import 'package:locally_flutter_app/views/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class AddAddressDialog extends StatelessWidget {
  String openAddress = "";
  String title = "";

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: 90.wb,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.BG_WHITE,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Adres Ekle",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.PRIMARY_COLOR,
                    fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                cursorColor: AppColors.PRIMARY_COLOR,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.PRIMARY_COLOR,
                    fontWeight: FontWeight.w700
                ),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.PRIMARY_COLOR)
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.PRIMARY_COLOR)
                    ),
                    labelText: "Adres Başlığı",
                    labelStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.PRIMARY_COLOR.withOpacity(0.8),
                        fontWeight: FontWeight.w700
                    )
                ),
                onChanged: (value) => title = value,
              ),
              SizedBox(
                height: 20,
              ),
              MultilineTextField("Açık Adres",
                      (value) {
                    openAddress = value;
                  },
                  AppColors.PRIMARY_COLOR.withOpacity(0.8)
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    textColor: AppColors.PRIMARY_COLOR,
                    color: AppColors.WHITE,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "İptal",
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Builder(builder: (BuildContext context) {
                    return FlatButton(
                      disabledColor: AppColors.PRIMARY_COLOR.withOpacity(0.4),
                      color: AppColors.PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      onPressed: title.length > 0 && openAddress.length > 0
                          ? () => addAddressToUser(context)
                          : null,
                      child: Text(
                        "Ekle",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.WHITE,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    );
                  },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  addAddressToUser(BuildContext context) async {
    if (context
        .read<RegistrationPageVM>()
        .currentUser
        .address
        .indexWhere((element) =>
    element.name.toLowerCase() == title.toLowerCase()) == -1) {
      Address newAddress = Address(name: title, openAddress: openAddress);
      await context.read<RegistrationPageVM>().updateUserAddress(
          newAddress, context
          .read<RegistrationPageVM>()
          .currentUser
          .email, true);
      Get.back();
    } else {
      Get.showSnackbar(GetBar(
        message: "Bu başlıkta bir adresiniz zaten bulunmaktadır. Lütfen başka bir başlık giriniz.",
        backgroundColor: AppColors.RED,
        duration: 4.seconds,
      ));
    }
  }
}
