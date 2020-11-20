import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:provider/provider.dart';

class ItemCount extends StatelessWidget {
  double size;

  ItemCount({this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Center(
        child: Text(
          context.watch<CartPageVM>().productsInCartList.length.toString(),
          style: TextStyle(
            fontSize: size > 15 ? 14 : 10,
            fontWeight: FontWeight.w700,
            color: AppColors.WHITE
          ),
        ),
      ),
    );
  }
}
