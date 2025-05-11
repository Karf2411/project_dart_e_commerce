class Shipping {
  int shippingId;
  int orderId;
  String shippingAddress;
  DateTime shippingDate;
  String status;

  Shipping({
    required this.shippingId,
    required this.orderId,
    required this.shippingAddress,
    required this.shippingDate,
    required this.status,
  });

  void updateShippingStatus(String newStatus) {
    status = newStatus;
  }
}
