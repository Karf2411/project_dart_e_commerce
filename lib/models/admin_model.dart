import 'product_model.dart';

class Admin {
  void addProduct(List<Product> products, Product product) {
    products.add(product);
  }

  void removeProduct(List<Product> products, Product product) {
    products.remove(product);
  }

  void updateProduct(Product product,
      {String? name, double? price, String? description}) {
    if (name != null) product.name = name;
    if (price != null) product.price = price;
    if (description != null) product.description = description;
  }
}
