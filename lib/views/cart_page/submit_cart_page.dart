import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/enums/order_type.dart';
import 'package:locally_flutter_app/models/address.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/notifications_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/cart_page/cart_progress_info.dart';
import 'package:locally_flutter_app/views/cart_page/choose_order_type.dart';
import 'package:locally_flutter_app/views/widgets/loading_bar.dart';
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
        child: LoadingBar(
      isLoadingVisible: context.watch<RegistrationPageVM>().isLoadingVisible,
      child: Scaffold(
        backgroundColor: AppColors.BG_WHITE,
        appBar: UtilityWidgets.CustomAppBar(
            Text(
                context.watch<CartPageVM>().currentOrderType == OrderType.table
                    ? "Masa-${context.watch<CartPageVM>().currentSelectedTable} Sipariş"
                    : "Sipariş Detayı" ,
              style: TextStyle(
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
                  renderCard(
                      "Sipariş Toplamı",
                      Text(
                        "${context.watch<CartPageVM>().totalCartPrice.toStringAsFixed(2)}₺",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: AppColors.GREY),
                      ),
                      Ionicons.md_pricetag),
                  SizedBox(
                    height: 20,
                  ),
                  renderCard(
                      "Loyalty Durumu",
                      FutureProvider(
                        create: (context) => context
                            .read<HomePageVM>()
                            .getClientSideLoyaltyCard(context
                                .read<CompanyDetailsPageVM>()
                                .currentCompany
                                .company_id),
                        child: CartProgressInfo(),
                      ),
                      Icons.loyalty),
                  SizedBox(
                    height: 20,
                  ),
                  renderCard(
                      "Ödeme Şekli",
                      RadioButtonGroup(["Nakit", "Kredi Kartı"],
                          (value) => choosePaymentMethod(value)),
                      Icons.payment),
                  SizedBox(
                    height: 20,
                  ),
                 context.watch<CartPageVM>().currentOrderType == OrderType.home ? renderCard(
                      "Sipariş Tipi", ChooseOrderType(), Icons.sticky_note_2)
                  : Container(),
                  context.watch<CartPageVM>().currentOrderType == OrderType.home ? SizedBox(
                    height: 20,
                  ) : Container(),
                  renderCard(
                      "Sipariş Notlarınız",
                      MultilineTextField("Sipariş Notu",
                          (value) => takeNote(value), AppColors.DISABLED_GREY),
                      SimpleLineIcons.note),
                  SizedBox(
                    height: 20,
                  ),
                  Builder(
                      builder: (context) => InkWell(
                            onTap: () => submitOrder(context),
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              color: AppColors.SUCCESS_GREEN,
                              child: Center(
                                child: Text(
                                  "SİPARİŞİ GÖNDER",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.WHITE,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ))
                ],
              ),
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
                    style: TextStyle(
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
    if (paymentType.length == 0) {
      Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(
          AppColors.ERROR, "Lütfen bir ödeme metodu seçiniz.", context));
    } else {
      var uuid = Uuid().v4();
      context.read<RegistrationPageVM>().setLoadingVisibility(true);
      Order newOrder = Order(
          uid: uuid,
          userMail: context.read<RegistrationPageVM>().currentUser.email,
          totalPrice: context.read<CartPageVM>().totalCartPrice,
          paymentType: paymentType,
          extraNote: orderNote,
          orderType: context.read<CartPageVM>().currentOrderType == OrderType.table ? "MASA" : context.read<CartPageVM>().orderDeliveryType,
          cartProduct: context.read<CartPageVM>().productsInCartList,
          companyId: context.read<CompanyDetailsPageVM>().currentCompany.company_id,
          address: context.read<CartPageVM>().currentOrderType == OrderType.table ? "Masa-${context.read<CartPageVM>().currentSelectedTable}" : context.read<CartPageVM>().currentOrderAddress.openAddress,
          orderStatus: 0,
          orderTime: Timestamp.now(),
          deliveryType: context.read<CartPageVM>().orderDeliveryType,
          companyName: context.read<CompanyDetailsPageVM>().currentCompany.name,
          deliveryTime: context.read<CartPageVM>().currentOrderDeliveryTime
      );
      await context.read<HomePageVM>().submitOrder(newOrder);
      ///await context.read<NotificationsVM>().postNotification(context.read<CompanyDetailsPageVM>().currentCompany.notificationIds,"Sipariş Alındı", "${context.read<RegistrationPageVM>().currentUser.email} sipariş verdi.");
      context.read<CartPageVM>().clearCart();
      context.read<CartPageVM>().setCurrentOrderType(OrderType.home);
      context.read<CartPageVM>().setCurrentOrderDeliveryTime("");
      context.read<CartPageVM>().setCurrentOrderAddress(Address(name: "",openAddress: ""));
      context.read<CartPageVM>().setOrderDeliveryType("");
      context.read<RegistrationPageVM>().setLoadingVisibility(false);
      Get.showSnackbar(GetBar(
        message: "Siparişiniz başarıyla gönderilmiştir",
        backgroundColor: AppColors.SUCCESS_GREEN,
        duration: 2.seconds,
      ));
      Timer(2.seconds, (){
        Get.back();
        Get.back();
        Get.back();
      });
    }
  }
}
