import 'package:hive/hive.dart';
import 'order_item_model.dart';

part 'order_model.g.dart';

@HiveType(typeId: 9)
class Order {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String customerName;

  @HiveField(2)
  final String customerAddress;

  @HiveField(3)
  final List<OrderItem> items;

  @HiveField(4)
  final double total;

  @HiveField(5)
  String status;

  @HiveField(6)
  bool isPaid;

  @HiveField(7)
  String? paymentMethod;

  @HiveField(8)
  DateTime? paymentDate;

  Order({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.items,
    required this.total,
    required this.status,
    this.isPaid = false,
    this.paymentMethod,
    this.paymentDate,
  });

  void placeOrder() {
    status = 'Placed';
  }

  void markAsPaid(String method) {
    isPaid = true;
    paymentMethod = method;
    paymentDate = DateTime.now();
    status = 'Paid';
  }

  @override
  String toString() {
    return 'Order ID: $id\nCustomer: $customerName\nAddress: $customerAddress\nTotal: $total\nStatus: $status\nPaid: ${isPaid ? 'Yes' : 'No'}${isPaid ? '\nPayment Method: $paymentMethod' : ''}';
  }
}
