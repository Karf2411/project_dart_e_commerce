class Payment {
  int paymentId;
  int orderId;
  double amount;
  DateTime paymentDate;
  String paymentMethod;

  Payment({
    required this.paymentId,
    required this.orderId,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
  });

  void processPayment() {
    print('Processing payment of \$${amount.toStringAsFixed(2)} via $paymentMethod');
  }
}
