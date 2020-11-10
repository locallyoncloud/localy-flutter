import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/views/cart_page/cart_list.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class CartMain extends StatelessWidget {

  TabController tabController;

  CartMain(this.tabController);

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return TabBarView(
      controller: tabController,
        children: [
        Container(
        color: AppColors.BG_WHITE,
        child: context.watch<CartPageVM>().productsInCartList.length > 0 ?
            CartList()
            :
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70.wb,
                child: AspectRatio(
                  aspectRatio: 0.9,
                  child: Lottie.asset('assets/animations/empty_cart_anim.json', fit: BoxFit.contain) ,
                ),
              ),
              Transform.translate(
                offset: Offset(2.wb,-8.hb),
                child: Text(
                  "Sepette şu an ürün bulunmamaktadır.",
                  style: AppFonts.getMainFont(
                      fontSize: 14,
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w700
                  ),
                ),
              )

            ],
          ),
        )
    ),
      Center(
        child: Text("asdasd"),
      )
    ]);
  }
}
