import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/cart_product.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/vertical_number_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartItem extends StatelessWidget {
  CartProduct cartProduct;

  CartItem(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      height: 124,
      margin: EdgeInsets.only(top: 10),
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => context.read<CartPageVM>().removeFromCart(cartProduct),
          ),
        ],
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(0),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/placeholder_image.jpg?alt=media&token=60820f73-af25-43a4-89a7-f9027dd3523c",
                  width: 60,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartProduct.product.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    ),
                    Text(
                      cartProduct.productSize.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    ),
                    Text(
                      "${cartProduct.price} x ${cartProduct.count} = ${cartProduct.price * cartProduct.count}₺",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    )
                  ],
                )),
                VerticalNumberPicker(
                  initialCounter: cartProduct.count,
                  onChange: (value){
                    context.read<CartPageVM>().setProductCount(cartProduct, value);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
