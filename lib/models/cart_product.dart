import 'package:locally_flutter_app/enums/product_size.dart';
import 'package:locally_flutter_app/models/product.dart';

class CartProduct{
  Product product;
  int count;
  double price;
  String productSize;

  CartProduct(this.product, this.count, this.price, this.productSize);
}