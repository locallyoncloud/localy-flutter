import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/notifications_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/cart_page/cart_progress_info.dart';
import 'package:locally_flutter_app/views/widgets/multiline_textfield.dart';
import 'package:locally_flutter_app/views/widgets/radio_button_group.dart';
import 'package:locally_flutter_app/views/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SubmitCartPage extends StatelessWidget {
  String paymentType = "";
  String orderNote = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.BG_WHITE,
      appBar: UtilityWidgets.CustomAppBar(
          Text(
            "Masa-${context.watch<CartPageVM>().currentSelectedTable} Sipariş",
            style: AppFonts.getMainFont(
                color: AppColors.PRIMARY_COLOR,
                fontSize: 17,
                fontWeight: FontWeight.w700),
          ),
          null),
      body: InkWell(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                renderCard("Sipariş Toplamı",
                    Text(
                      "${context.watch<CartPageVM>().totalCartPrice.toStringAsFixed(2)}₺",
                      style: AppFonts.getMainFont(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.GREY),
                    ),
                    Ionicons.md_pricetag
                ),
                SizedBox(
                  height: 20,
                ),
                renderCard("Loyalty Durumu",
                    FutureProvider(
                      create: (context) =>context.read<HomePageVM>().getClientSideLoyaltyCard(context.read<CompanyDetailsPageVM>().currentCompany.company_id),
                      child: CartProgressInfo(),
                    ),
                    Icons.loyalty
                ),
                SizedBox(
                  height: 20,
                ),
                renderCard("Ödeme Şekli",
                    RadioButtonGroup(["Nakit", "Kredi Kartı"],
                            (value) => choosePaymentMethod(value)),
                  Icons.payment
                ),
                SizedBox(
                  height: 20,
                ),
                renderCard("Sipariş Notlarınız",
                    MultilineTextField(
                        "Sipariş Notu", (value) => takeNote(value)),
                    SimpleLineIcons.note
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => submitOrder(context),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    color: AppColors.SUCCESS_GREEN,
                    child: Center(
                      child: Text(
                        "SİPARİŞİ GÖNDER",
                        style: AppFonts.getMainFont(
                          fontSize: 16,
                          color: AppColors.WHITE,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  renderCard(String title, Widget child, IconData leftIcon) {
    return Material(
      elevation: 5,
      child: Container(
        color: AppColors.WHITE,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              leftIcon,
              color: AppColors.PRIMARY_COLOR,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppFonts.getMainFont(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.GREY),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  child
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  choosePaymentMethod(value) {
    paymentType = value;
  }

  takeNote(value) {
    orderNote = value;
  }

  submitOrder(BuildContext context) async {
    DateTime date = DateTime.now();
    String todayDate = date
        .toString()
        .replaceRange(date.toString().length - 7, date.toString().length, "");
    if(paymentType.length==0){
      Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(AppColors.ERROR, "Lütfen bir ödeme metodu seçiniz.",context));
    }else{
      var uuid = Uuid().v4();
      Timestamp sad = Timestamp.now();
      context.read<RegistrationPageVM>().setLoadingVisibility(true);
      Order newOrder = Order(
          uid: uuid,
          userMail: context.read<RegistrationPageVM>().currentUser.email,
          totalPrice: context.read<CartPageVM>().totalCartPrice,
          paymentType: paymentType,
          extraNote: orderNote,
          orderType: "MASA",
          cartProduct: context.read<CartPageVM>().productsInCartList,
          companyId: context.read<CompanyDetailsPageVM>().currentCompany.company_id,
          address: "Masa-${context.read<CartPageVM>().currentSelectedTable}",
          orderStatus: 0,
          orderTime: Timestamp.now(),
          companyName: context.read<CompanyDetailsPageVM>().currentCompany.name
      );
      await context.read<HomePageVM>().submitOrder(newOrder);
      //await context.read<NotificationsVM>().postNotification(context.read<CompanyDetailsPageVM>().currentCompany.notificationIds);
      context.read<CartPageVM>().clearCart();
      context.read<RegistrationPageVM>().setLoadingVisibility(false);
      Get.back();
    }
  }
}
