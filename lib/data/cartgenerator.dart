

import 'dart:math';

import '../modle/CartItem.dart';
import '../modle/productmodel.dart';

final _rng = Random();

final List<Product> productsCatalog = [
  Product(name: "Milk", price: 1.50),
  Product(name: "Bread", price: 2.20),
  Product(name: "Apple", price: 0.40),
  Product(name: "Cheese", price: 3.75),
  Product(name: "Juice", price: 2.10),
  Product(name: "Eggs", price: 2.95),
  Product(name: "Rice", price: 4.30),
];

List<CartItem> generateRandomCart({int itemsCount = 3}) {
  final list = List<Product>.from(productsCatalog)..shuffle(_rng);
  final picked = list.take(itemsCount).toList();

  return picked
      .map((p) => CartItem(
    product: p,
    quantity: 1 + _rng.nextInt(4),
  ))
      .toList();
}

double calculateCartTotal(List<CartItem> cart) {
  double total = 0;
  for (final item in cart) {
    total += item.totalPrice;
  }
 return (total * 100).round() / 100;
}
