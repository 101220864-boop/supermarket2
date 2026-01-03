import 'package:supermarket2/modle/productmodel.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;
}
