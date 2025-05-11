import 'user_model.dart';
import 'product_model.dart';

class Review {
  int reviewId;
  User user;
  Product product;
  double rating;
  String comment;

  Review({
    required this.reviewId,
    required this.user,
    required this.product,
    required this.rating,
    required this.comment,
  });

  @override
  String toString() {
    return 'Review by ${user.name} for ${product.name}: $rating stars';
  }
}
