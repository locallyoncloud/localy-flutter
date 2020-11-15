import 'package:locally_flutter_app/enums/product_size.dart';
import 'package:locally_flutter_app/models/product.dart';

class CartProduct{
  Product product;
  int count;
  double price;
  String productSize;

  CartProduct(this.product, this.count, this.price, this.productSize);

  CartProduct.fromJsonMap(Map<String, dynamic> map):
        count = map["count"],
        price = map["price"],
        productSize = map["productSize"],
        product = map["product"] != null ? Product.fromJsonMap(map["product"]) : null;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["count"] = count;
    map["price"] = price;
    map["productSize"] = productSize;
    if (product != null) {
      map["product"] = product.toJson();
    }
    return map;
  }
}