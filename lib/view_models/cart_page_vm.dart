import 'package:flutter/cupertino.dart';
import 'package:locally_flutter_app/models/cart_product.dart';


class CartPageVM extends ChangeNotifier{
  List<CartProduct> productsInCartList = [];
  double totalCartPrice= 0;

  addToCard(CartProduct cartProduct){
    totalCartPrice= 0;
    var productIndexInCart = productsInCartList.indexWhere((element) => element.product.name ==cartProduct.product.name && element.productSize == cartProduct.productSize);
    if(productIndexInCart!=-1){
      productsInCartList[productIndexInCart].count += cartProduct.count;
    }else{
      productsInCartList.add(cartProduct);
    }
    productsInCartList.forEach((cartProduct) {
      totalCartPrice += cartProduct.price * cartProduct.count;
    });
    notifyListeners();
  }

  clearCart(){
    productsInCartList.clear();
    totalCartPrice = 0;
    notifyListeners();
  }
}