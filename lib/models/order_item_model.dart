import 'product_model.dart';

class OrderItem {
  Product product;
  int quantity;
  double price;

  OrderItem({
    required this.product,
    required this.quantity,
    required this.price,
  });
}
