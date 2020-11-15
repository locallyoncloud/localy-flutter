import 'package:flutter/cupertino.dart';
import 'package:locally_flutter_app/models/cart_product.dart';


class CartPageVM extends ChangeNotifier{
  List<CartProduct> productsInCartList = [];
  double totalCartPrice= 0;
  String currentSelectedTable;

  setCurrentSelectedTable(String tableNumber){
    currentSelectedTable = tableNumber;
    notifyListeners();
  }

  addToCart(CartProduct cartProduct){
    var productIndexInCart = productsInCartList.indexWhere((element) => element.product.name ==cartProduct.product.name && element.productSize == cartProduct.productSize);
    if(productIndexInCart!=-1){
      productsInCartList[productIndexInCart].count += cartProduct.count;
    }else{
      productsInCartList.add(cartProduct);
    }
    calculateTotalPrice();
    notifyListeners();
  }

  addProductCount(CartProduct cartProduct){
    var productIndexInCart = productsInCartList.indexWhere((element) => element.product.name ==cartProduct.product.name && element.productSize == cartProduct.productSize);
    productsInCartList[productIndexInCart].count += 1;
    notifyListeners();
  }

  removeFromCart(CartProduct cartProduct){
    var productIndexInCart = productsInCartList.indexWhere((element) => element.product.name ==cartProduct.product.name && element.productSize == cartProduct.productSize);
    productsInCartList.removeAt(productIndexInCart);
   calculateTotalPrice();
   notifyListeners();
  }

  setProductCount(CartProduct cartProduct, int count){
    var productIndexInCart = productsInCartList.indexWhere((element) => element.product.name ==cartProduct.product.name && element.productSize == cartProduct.productSize);
    productsInCartList[productIndexInCart].count = count;
    calculateTotalPrice();
    notifyListeners();
  }

  calculateTotalPrice(){
    totalCartPrice= 0;
    productsInCartList.forEach((cartProduct) {
      totalCartPrice += cartProduct.price * cartProduct.count;
    });
  }

  clearCart(){
    productsInCartList.clear();
    totalCartPrice = 0;
    notifyListeners();
  }
}