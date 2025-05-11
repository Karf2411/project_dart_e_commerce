import 'user_model.dart';
import 'cart_model.dart';
import 'order_model.dart';
import 'product_model.dart';
import 'cart_item_model.dart';

class Customer extends User {
  Cart cart;
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
