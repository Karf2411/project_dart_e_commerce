import 'package:hive/hive.dart';

part 'payment_model.g.dart';

@HiveType(typeId: 6)
class Payment {
  @HiveField(0)
  int paymentId;

  @HiveField(1)
  int orderId;

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime paymentDate;

  @HiveField(4)
  String paymentMethod;

  Payment({
    required this.paymentId,
    required this.orderId,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
  });

  void processPayment() {
    print(
        'Processing payment of \$${amount.toStringAsFixed(2)} via $paymentMethod');
  }
}
