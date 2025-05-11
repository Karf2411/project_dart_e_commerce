import 'cart_item_model.dart';

class Order {
  final String id;
  final String customerName;
  final String customerAddress;
  final List<CartItem> items;
  final double total;
  String status;

  Order({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.items,
    required this.total,
    required this.status,
  });

  void placeOrder() {
    status = 'Placed';
  }

  @override
  String toString() {
    return 'Order ID: $id\nCustomer: $customerName\nAddress: $customerAddress\nTotal: $total\nStatus: $status';
  }
}
