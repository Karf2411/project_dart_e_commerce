import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 4)
class Product {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  String description;

  @HiveField(4)
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  void updateDetails({
    String? newName,
    double? newPrice,
    String? newDescription,
    String? newImageUrl,
  }) {
    if (newName != null) name = newName;
    if (newPrice != null) price = newPrice;
    if (newDescription != null) description = newDescription;
    if (newImageUrl != null) imageUrl = newImageUrl;
  }

  // Calculate total price for a given quantity
  double getTotalPrice(int quantity) => price * quantity;

  @override
  String toString() => "$name - \$$price";
}
