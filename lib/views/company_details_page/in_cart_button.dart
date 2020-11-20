import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/views/company_details_page/item_count.dart';
import 'package:locally_flutter_app/views/company_details_page/menu_tab/add_product_dialog.dart';
import 'package:locally_flutter_app/views/main_page.dart';
import 'package:locally_flutter_app/views/widgets/custom_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class InCartButton extends StatefulWidget {
  @override
  _InCartButtonState createState() => _InCartButtonState();
}

class _InCartButtonState extends State<InCartButton> {
  bool isForward = false;
  double size = 81;
  Timer periodicButtonAnimation;
  GlobalKey _toolTipKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      periodicButtonAnimation = Timer.periodic(500.milliseconds, (timer) {
        setState(() {
          isForward = !isForward;
        });
      });
    });
  }

  @override
  void dispose() {
    periodicButtonAnimation.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTooltip(
      key: _toolTipKey,
      preferBelow: false,
      verticalOffset: 42,
      padding: EdgeInsets.all(10),
      message: "Almak istediğiniz ürünü buraya sürükleyip bırakabilirsiniz.",
      waitDuration: 1.seconds,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xff0c3d17)),
      textStyle: TextStyle(
          fontSize: 14, color: AppColors.WHITE, fontWeight: FontWeight.w600,),
      child: InkWell(
        onTap: () {
          if(context.read<CartPageVM>().productsInCartList.length == 0){
            final dynamic tooltip = _toolTipKey.currentState;
            tooltip.ensureTooltipVisible();
          }else{
            context.read<MainPageVM>().setCurrentSelectedIndex(1);
            Get.to(MainPage());
          }
        },
        child: Material(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: DragTarget<Product>(
            onWillAccept: (product) {
              setState(() {
                size = 100;
              });
              return true;
            },
            onLeave: (product) {
              setState(() {
                size = 81;
              });
            },
            onAccept: (product) {
              setState(() {
                size = 81;
              });
              showDialog(context: context,
              builder: (_) => AddProductDialog(product)
              );
            },
            builder: (BuildContext context, List<dynamic> candidateData,
                List<dynamic> rejectedData) {
              return AnimatedContainer(
                duration: 300.milliseconds,
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: RadialGradient(
                    center: Alignment(0.0, 0.0),
                    radius: isForward ? 0.7 : 0.4,
                    colors: [
                      const Color(0xff0c3d17),
                      const Color(0xff055b14),
                      const Color(0xff5dae68)
                    ],
                    stops: [0.0, 0.506, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.add_shopping_cart,
                            color: AppColors.WHITE, size: 35)),
                    context.watch<CartPageVM>().productsInCartList.length>0
                        ? Positioned(right: 15, top: 15, child: ItemCount())
                        : Container(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
