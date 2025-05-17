import 'package:hive/hive.dart';
import 'product_model.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 10)
class CartItem {
  @HiveField(0)
  Product product;

  @HiveField(1)
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  // Get total price for this item
  double getTotal() => product.price * quantity;

  void updateQuantity(int newQuantity) {
    if (newQuantity > 0) {
      quantity = newQuantity;
    } else {
      throw ArgumentError('Quantity must be greater than zero');
    }
  }

  @override
  String toString() => '${product.name} x $quantity = \$${getTotal()}';
}
