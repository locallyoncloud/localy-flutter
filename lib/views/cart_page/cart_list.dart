import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/views/cart_page/cart_item.dart';
import 'package:locally_flutter_app/views/cart_page/submit_cart_page.dart';
import 'package:provider/provider.dart';

class CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Sepetinizde ${context.watch<CartPageVM>().productsInCartList.length} adet ürün bulunmaktadır.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.GREY),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: context.watch<CartPageVM>().productsInCartList.length,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return CartItem(context.watch<CartPageVM>().productsInCartList[index]);
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            width: double.infinity,
            color: AppColors.WHITE,
            margin: EdgeInsets.only(bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Toplam Tutar",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.DISABLED_GREY),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${context.watch<CartPageVM>().totalCartPrice.toStringAsFixed(2)}₺",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColors.GREY),
                    )
                  ],
                ),
                Container(
                  width: 100,
                  height: 30,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: AppColors.SECONDARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Onay",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.WHITE),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: AppColors.WHITE,
                        )
                      ],
                    ),
                    onPressed: () {
                      Get.to(SubmitCartPage());
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
