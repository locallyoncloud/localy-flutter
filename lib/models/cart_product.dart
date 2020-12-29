import 'package:locally_flutter_app/models/product.dart';

class CartProduct{
  Product product;
  int count;
  double price;
  List<String> selectedProductOptions;

  CartProduct(this.product, this.count, this.price, this.selectedProductOptions);

  CartProduct.fromJsonMap(Map<String, dynamic> map):
        count = map["count"],
        price = double.parse(map["price"].toString()),
        selectedProductOptions = List<String>.from(map['selectedProductOptions']),
        product = map["product"] != null ? Product.fromJson(map["product"]) : null;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["count"] = count;
    map["price"] = price;
    map["selectedProductOptions"] = selectedProductOptions;
    if (product != null) {
      map["product"] = product.toJson();
    }
    return map;
  }
}

class CartProductOption {
  String name;
  List<Options> options;

  CartProductOption({
    this.name,
    this.options});

  CartProductOption.fromJson(dynamic json) {
    name = json["name"];
    if (json["options"] != null) {
      options = [];
      json["options"].forEach((v) {
        options.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    if (options != null) {
      map["options"] = options.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
