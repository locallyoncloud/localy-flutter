import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:locally_flutter_app/enums/order_type.dart';
import 'package:locally_flutter_app/models/address.dart';
import 'package:locally_flutter_app/models/cart_product.dart';

class CartPageVM extends ChangeNotifier {
  List<CartProduct> productsInCartList = [];
  double totalCartPrice = 0;
  String currentSelectedTable = "";
  OrderType currentOrderType = OrderType.home;
  String currentOrderDeliveryTime = "";
  Address currentOrderAddress = Address(name: "", openAddress: "");
  String orderDeliveryType = "";

  setCurrentSelectedTable(String tableNumber) {
    currentSelectedTable = tableNumber;
    notifyListeners();
  }

  setCurrentOrderDeliveryTime(String time) {
    currentOrderDeliveryTime = time;
    notifyListeners();
  }

  setCurrentOrderAddress(Address address) {
    currentOrderAddress = address;
    notifyListeners();
  }

  setOrderDeliveryType(String deliveryType) {
    orderDeliveryType = deliveryType;
    notifyListeners();
  }

  addToCart(CartProduct cartProduct) {
    var productIndexInCart = productsInCartList.indexWhere((element) {
      return element.product.name == cartProduct.product.name &&
          DeepCollectionEquality().equals(
              element.selectedProductOptions,cartProduct.selectedProductOptions);
    });
    if (productIndexInCart != -1) {
      productsInCartList[productIndexInCart].count += cartProduct.count;
    } else {
      productsInCartList.add(cartProduct);
    }
    calculateTotalPrice();
    notifyListeners();
  }

  addProductCount(CartProduct cartProduct) {
    var productIndexInCart = productsInCartList.indexWhere((element) =>
        element.product.name == cartProduct.product.name &&
        DeepCollectionEquality.unordered().equals(
            element.selectedProductOptions,
            cartProduct.selectedProductOptions));
    productsInCartList[productIndexInCart].count += 1;
    notifyListeners();
  }

  removeFromCart(CartProduct cartProduct) {
    var productIndexInCart = productsInCartList.indexWhere((element) =>
        element.product.name == cartProduct.product.name &&
        DeepCollectionEquality.unordered().equals(
            element.selectedProductOptions,
            cartProduct.selectedProductOptions));
    productsInCartList.removeAt(productIndexInCart);
    calculateTotalPrice();
    notifyListeners();
  }

  setProductCount(CartProduct cartProduct, int count) {
    var productIndexInCart = productsInCartList.indexWhere((element) =>
        element.product.name == cartProduct.product.name &&
        DeepCollectionEquality.unordered().equals(
            element.selectedProductOptions,
            cartProduct.selectedProductOptions));
    productsInCartList[productIndexInCart].count = count;
    calculateTotalPrice();
    notifyListeners();
  }

  calculateTotalPrice() {
    totalCartPrice = 0;
    productsInCartList.forEach((cartProduct) {
      totalCartPrice += cartProduct.price * cartProduct.count;
    });
  }

  clearCart() {
    productsInCartList.clear();
    totalCartPrice = 0;
    notifyListeners();
  }

  setCurrentOrderType(OrderType newOrderType) {
    currentOrderType = newOrderType;
    notifyListeners();
  }
}
