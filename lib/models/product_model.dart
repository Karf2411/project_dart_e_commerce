import 'review_model.dart';

class Product {
  final String id;
  String name;
  double price;
  String description;
  String imageUrl;
  List<Review> reviews = [];

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  void addReview(Review review) {
    reviews.add(review);
  }

  double get averageRating {
    if (reviews.isEmpty) return 0.0;
    return reviews.map((r) => r.rating).reduce((a, b) => a + b) /
        reviews.length;
  }

  // Calculate total price for a given quantity
  double getTotalPrice(int quantity) => price * quantity;

  @override
  String toString() => '$name - \$$price';
}
