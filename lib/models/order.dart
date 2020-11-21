import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_product.dart';

class Order {
  String uid;
  String userMail;
  double totalPrice;
  String paymentType;
  String extraNote;
  String orderType;
  String companyId;
  String companyName;
  String address;
  String deliveryTime;
  String deliveryType;
  Timestamp orderTime;
  int orderStatus;
  List<CartProduct> cartProduct;

  Order({
    this.uid,
    this.userMail,
    this.totalPrice,
    this.paymentType,
    this.extraNote,
    this.orderType,
    this.companyId,
    this.companyName,
    this.address,
    this.orderTime,
    this.orderStatus,
    this.cartProduct,
    this.deliveryTime,
    this.deliveryType,
  });

  Order.fromJson(dynamic json) {
    uid = json["uid"];
    userMail = json["userMail"];
    totalPrice = json["totalPrice"];
    paymentType = json["paymentType"];
    extraNote = json["extraNote"];
    orderType = json["orderType"];
    companyId = json["companyId"];
    address = json["address"];
    companyName = json["companyName"];
    orderTime = json["orderTime"];
    deliveryTime = json["deliveryTime"];
    orderStatus = json["orderStatus"];
    deliveryType = json["deliveryType"];
    if (json["cartProduct"] != null) {
      cartProduct = [];
      json["cartProduct"].forEach((v) {
        cartProduct.add(CartProduct.fromJsonMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["uid"] = uid;
    map["userMail"] = userMail;
    map["totalPrice"] = totalPrice;
    map["paymentType"] = paymentType;
    map["extraNote"] = extraNote;
    map["orderType"] = orderType;
    map["companyId"] = companyId;
    map["address"] = address;
    map["companyName"] = companyName;
    map["orderTime"] = orderTime;
    map["deliveryTime"] = deliveryTime;
    map["deliveryType"] = deliveryType;
    map["orderStatus"] = orderStatus;
    if (cartProduct != null) {
      map["cartProduct"] = cartProduct.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
