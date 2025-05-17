import 'package:hive/hive.dart';
import 'product_model.dart';

part 'order_item_model.g.dart';

@HiveType(typeId: 7)
class OrderItem {
  @HiveField(0)
  Product product;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  double price;

  OrderItem({
    required this.product,
    required this.quantity,
    required this.price,
  });
}
