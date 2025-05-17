import 'package:e_commerce/models/address_model.dart';
import 'package:hive/hive.dart';
import 'user_model.dart';
import 'cart_model.dart';
import 'order_model.dart';
import 'product_model.dart';
import 'cart_item_model.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 3)
class Customer extends User {
  @HiveField(6)
  Cart cart;

  @HiveField(7)
  List<Order> orderHistory = [];

  Customer({
    required super.name,
    required super.age,
    required super.email,
    required super.password,
    required super.address,
    required super.phone,
    required this.cart,
  });

  void addToCart(Product product, int quantity) {
    cart.addItem(CartItem(product: product, quantity: quantity), quantity);
  }

  void placeOrder(Order order) {
    order.placeOrder();
    orderHistory.add(order);
  }

  void viewOrderHistory() {
    for (var order in orderHistory) {
      print(order.toString());
    }
  }
}
