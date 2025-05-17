import 'package:hive/hive.dart';
import 'cart_item_model.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 5)
class Cart {
  @HiveField(0)
  final List<CartItem> items;

  Cart({required this.items});

  // Add item to cart
  void addItem(CartItem item, int quantity) {
    final existingItem = items.firstWhere(
      (i) => i.product.id == item.product.id,
      orElse: () => item,
    );

    if (existingItem == item) {
      items.add(item);
    } else {
      existingItem.quantity += item.quantity;
    }
  }

  // Remove item from cart
  void removeItem(String productId) {
    items.removeWhere((item) => item.product.id == productId);
  }

  // Update item quantity
  void updateItemQuantity(String productId, int quantity) {
    final item = items.firstWhere((item) => item.product.id == productId);
    item.quantity = quantity;
  }

  // Get total price of all items
  double getTotal() {
    return items.fold(0, (sum, item) => sum + item.getTotal());
  }

  // Clear cart
  void clear() => items.clear();

  // Check if cart is empty
  bool get isEmpty => items.isEmpty;

  // Get number of items
  int get itemCount => items.length;
}
