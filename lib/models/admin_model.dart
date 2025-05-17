import 'package:e_commerce/models/address_model.dart';
import 'package:hive/hive.dart';
import 'user_model.dart';
import 'product_model.dart';

part 'admin_model.g.dart';

@HiveType(typeId: 8)
class Admin extends User {
  Admin({
    required String name,
    required int age,
    required String email,
    required String password,
    required Address address,
    required String phone,
  }) : super(
          name: name,
          age: age,
          email: email,
          password: password,
          address: address,
          phone: phone,
        );

  void addProduct(List<Product> products, Product product) {
    products.add(product);
    // Save to Hive
    final productsBox = Hive.box<Product>('products');
    productsBox.put(product.id, product);
  }

  void removeProduct(List<Product> products, Product product) {
    products.remove(product);
    // Delete from Hive
    final productsBox = Hive.box<Product>('products');
    productsBox.delete(product.id);
  }

  void updateProduct(Product product,
      {String? name, double? price, String? description}) {
    if (name != null) product.name = name;
    if (price != null) product.price = price;
    if (description != null) product.description = description;

    // Update in Hive
    final productsBox = Hive.box<Product>('products');
    productsBox.put(product.id, product);
  }
}
