import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/enums/product_size.dart';
import 'package:locally_flutter_app/models/cart_product.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/views/company_details_page/menu_tab/choose_product_size.dart';
import 'package:locally_flutter_app/views/widgets/number_picker.dart';
import 'package:provider/provider.dart';

class AddProductDialog extends StatefulWidget {
  Product product;

  AddProductDialog(this.product);

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  int itemCount = 1;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 300,
        height: 360,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                productInfoText(widget.product.name, "Ürün Adı"),
                productInfoText(itemCount.toString(), "Adet"),
                productInfoText("${widget.product.price[selectedIndex] * itemCount}", "Fiyat"),
              ],
            ),
            widget.product.size.length>0 ?
            ChooseProductSize([27, 32, 37],
              onChange: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },) : Container(),
            Text(
              "Sepetinize kaç adet ürün eklemek istiyorsunuz?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.PRIMARY_COLOR
              ),
            ),
            NumberPicker(
              onChange: (value) {
                setState(() {
                  itemCount = value;
                });
              },
            ),
            Container(
              width: double.infinity,
              height: 30,
              child: RaisedButton(
                color: AppColors.PRIMARY_COLOR,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                onPressed: () => addProductToCart(),
                child: Text(
                  "Ürün Ekle",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.WHITE,
                      fontWeight: FontWeight.w900
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  productInfoText(String text, String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              color: AppColors.PRIMARY_COLOR),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.PRIMARY_COLOR),
        )
      ],
    );
  }

  addProductToCart() {
    CartProduct newProduct = CartProduct(widget.product, itemCount, widget.product.price[selectedIndex], widget.product.size.length>0 ? widget.product.size[selectedIndex] :  "normal");
    context.read<CartPageVM>().addToCart(newProduct);
    Get.back();
  }
}
