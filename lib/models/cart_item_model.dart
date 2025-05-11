import 'product_model.dart';

class CartItem {
  final Product product;
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
