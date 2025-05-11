import 'models/product_model.dart';
import 'models/cart_model.dart';
import 'models/cart_item_model.dart';
import 'models/order_model.dart';
import 'models/user_model.dart';
import 'models/address_model.dart';

export 'models/product_model.dart';
export 'models/cart_model.dart';
export 'models/cart_item_model.dart';
export 'models/order_model.dart';
export 'models/user_model.dart';

// قائمة المنتجات
List<Product> products = [
  Product(
    id: '1',
    name: 'Product 1',
    price: 100.0,
    description: 'Description for Product 1',
    imageUrl: '',
  ),
  Product(
    id: '2',
    name: 'Product 2',
    price: 200.0,
    description: 'Description for Product 2',
    imageUrl: '',
  ),
  Product(
    id: '3',
    name: 'Product 3',
    price: 300.0,
    description: 'Description for Product 3',
    imageUrl: '',
  ),
];

// قائمة الطلبات
List<Order> orders = [];

// قائمة المستخدمين
List<User> users = [
  User(
    name: 'User 1',
    age: 25,
    email: 'user1@example.com',
    password: 'user123',
    address: Address(street: '123 Main St', city: 'Cairo', country: 'Egypt'),
    phone: '0123456789',
  ),
  User(
    name: 'User 2',
    age: 30,
    email: 'user2@example.com',
    password: 'user123',
    address:
        Address(street: '456 Park Ave', city: 'Alexandria', country: 'Egypt'),
    phone: '0987654321',
  ),
];

// قائمة المسؤولين
List<User> admins = [
  User(
    name: 'Admin 1',
    age: 35,
    email: 'admin1@example.com',
    password: 'admin123',
    address: Address(street: '789 Admin St', city: 'Cairo', country: 'Egypt'),
    phone: '0112233445',
  ),
  User(
    name: 'Admin 2',
    age: 40,
    email: 'admin2@example.com',
    password: 'admin123',
    address:
        Address(street: '321 Admin Ave', city: 'Alexandria', country: 'Egypt'),
    phone: '0556677889',
  ),
];

// سلة المشتريات
Cart cart = Cart(items: []);

// كلمة مرور تسجيل المسؤولين
const String ADMIN_REGISTRATION_PASSWORD = 'admin_secret_123';

// دوال إدارة المستخدمين
void addUser(String name, int age, String email, String password, String street,
    String city, String country, String phone) {
  users.add(User(
    name: name,
    age: age,
    email: email,
    password: password,
    address: Address(street: street, city: city, country: country),
    phone: phone,
  ));
}

void addAdmin(String name, int age, String email, String password,
    String street, String city, String country, String phone) {
  admins.add(User(
    name: name,
    age: age,
    email: email,
    password: password,
    address: Address(street: street, city: city, country: country),
    phone: phone,
  ));
}

// دوال إدارة المنتجات
List<Product> getAllProducts() {
  return products;
}

Product? getProductById(String id) {
  try {
    return products.firstWhere((product) => product.id == id);
  } catch (e) {
    return null;
  }
}

// Add new product function
void addNewProduct(String name, double price, String description) {
  String newId = (products.length + 1).toString();
  products.add(Product(
    id: newId,
    name: name,
    price: price,
    description: description,
    imageUrl: '',
  ));
}

// دوال إدارة السلة
void addToCart(String productId, int quantity) {
  Product? product = getProductById(productId);
  if (product != null) {
    cart.addItem(CartItem(product: product, quantity: quantity), quantity);
  }
}

void removeFromCart(String productId) {
  cart.removeItem(productId);
}

void updateCartItemQuantity(String productId, int quantity) {
  cart.updateItemQuantity(productId, quantity);
}

List<CartItem> getCartItems() {
  return cart.items;
}

double getCartTotal() {
  return cart.getTotal();
}

int calculate() {
  return 6 * 7;
}
