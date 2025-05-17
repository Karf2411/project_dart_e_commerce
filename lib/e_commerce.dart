import 'models/address_model.dart';
import 'models/user_model.dart';
import 'models/customer_model.dart';
import 'models/admin_model.dart';
import 'models/product_model.dart';
import 'models/cart_model.dart';
import 'models/cart_item_model.dart';
import 'models/order_model.dart';
import 'models/payment_model.dart';
import 'package:hive/hive.dart';
import 'database/hive_init.dart';

export 'models/address_model.dart';
export 'models/user_model.dart';
export 'models/customer_model.dart';
export 'models/admin_model.dart';
export 'models/product_model.dart';
export 'models/cart_model.dart';
export 'models/cart_item_model.dart';
export 'models/order_model.dart';
export 'models/payment_model.dart';

Future<void> initializeApp() async {
  await HiveInit.initialize();
  await loadDataFromHive();
}

Future<void> closeApp() async {
  // Ensure all data is synced before closing
  if (currentUser != null) {
    syncCurrentUserToHive();
  }

  // Close Hive properly
  await Hive.close();
}

Future<void> loadDataFromHive() async {
  try {
    final productsBox = Hive.box<Product>('products');
    if (productsBox.isNotEmpty) {
      productsList = productsBox.values.toList();
    } else {
      for (var product in productsList) {
        productsBox.put(product.id, product);
      }
    }

    final customersBox = Hive.box<Customer>('customers');
    if (customersBox.isNotEmpty) {
      usersList = customersBox.values.toList();
    } else {
      for (var user in usersList) {
        customersBox.put(user.email, user);
      }
    }

    final adminsBox = Hive.box<Admin>('admins');
    if (adminsBox.isNotEmpty) {
      adminsList = adminsBox.values.toList();
    } else {
      for (var admin in adminsList) {
        adminsBox.put(admin.email, admin);
      }
    }

    final ordersBox = Hive.box<Order>('orders');
    if (ordersBox.isNotEmpty) {
      orders = ordersBox.values.toList();
    }

    for (var user in usersList) {
      for (var order in user.orderHistory) {
        if (!orders.any((o) => o.id == order.id)) {
          orders.add(order);

          if (ordersBox.get(order.id) == null) {
            ordersBox.put(order.id, order);
          }
        }
      }
    }

    final paymentsBox = Hive.box<Payment>('payments');
    if (paymentsBox.isNotEmpty) {
      payments = paymentsBox.values.toList();
    }

    print('Data loaded from Hive successfully!');
  } catch (e) {
    print('Error loading data from Hive: $e');
  }
}

User? currentUser;

List<Product> productsList = [
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

List<Order> orders = [];

List<Payment> payments = [];

List<Customer> usersList = [
  Customer(
    name: 'abdullah',
    age: 25,
    email: 'abdullah@gmail.com',
    password: '550411',
    address: Address(street: '123 Main St', city: 'Cairo', country: 'Egypt'),
    phone: '0123456789',
    cart: Cart(items: []),
  ),
  Customer(
    name: 'ahmed',
    age: 30,
    email: 'ahmed@gmail.com',
    password: '550411',
    address:
        Address(street: '456 Park Ave', city: 'Alexandria', country: 'Egypt'),
    phone: '0987654321',
    cart: Cart(items: []),
  ),
];

List<Admin> adminsList = [
  Admin(
    name: 'abdullah',
    age: 35,
    email: 'abdullah@gmail.com',
    password: '550411',
    address: Address(street: '789 Admin St', city: 'Cairo', country: 'Egypt'),
    phone: '0112233445',
  ),
  Admin(
    name: 'ahmed',
    age: 40,
    email: 'ahmed@gmail.com',
    password: '550411',
    address:
        Address(street: '321 Admin Ave', city: 'Alexandria', country: 'Egypt'),
    phone: '0556677889',
  ),
];

const String adminRegistrationPassword = 'admin_secret_123';

bool loginUser(String email, String password) {
  try {
    // Try to find the user in the Hive box first
    final customersBox = Hive.box<Customer>('customers');
    Customer? customer = customersBox.get(email);

    if (customer != null && customer.verifyPassword(password)) {
      currentUser = customer;
      return true;
    }

    // Fall back to in-memory list
    try {
      currentUser = usersList.firstWhere(
        (user) => user.email == email && user.verifyPassword(password),
      );
      return true;
    } catch (e) {
      return false;
    }
  } catch (e) {
    print('Error during user login: $e');
    return false;
  }
}

bool loginAdmin(String email, String password) {
  try {
    // Try to find the admin in the Hive box first
    final adminsBox = Hive.box<Admin>('admins');
    Admin? admin = adminsBox.get(email);

    if (admin != null && admin.verifyPassword(password)) {
      currentUser = admin;
      return true;
    }

    // Fall back to in-memory list
    try {
      currentUser = adminsList.firstWhere(
        (admin) => admin.email == email && admin.verifyPassword(password),
      );
      return true;
    } catch (e) {
      return false;
    }
  } catch (e) {
    print('Error during admin login: $e');
    return false;
  }
}

void logout() {
  currentUser = null;
}

void addUser(String name, int age, String email, String password, String street,
    String city, String country, String phone) {
  Customer newUser = Customer(
    name: name,
    age: age,
    email: email,
    password: password,
    address: Address(street: street, city: city, country: country),
    phone: phone,
    cart: Cart(items: []),
  );
  usersList.add(newUser);

  final customersBox = Hive.box<Customer>('customers');
  customersBox.put(email, newUser);
}

void addAdmin(String name, int age, String email, String password,
    String street, String city, String country, String phone) {
  Admin newAdmin = Admin(
    name: name,
    age: age,
    email: email,
    password: password,
    address: Address(street: street, city: city, country: country),
    phone: phone,
  );
  adminsList.add(newAdmin);

  final adminsBox = Hive.box<Admin>('admins');
  adminsBox.put(email, newAdmin);
}

List<Product> getAllProducts() {
  return productsList;
}

Product? getProductById(String id) {
  try {
    return productsList.firstWhere((product) => product.id == id);
  } catch (e) {
    return null;
  }
}

void addNewProduct(String name, double price, String description) {
  String newId = (productsList.length + 1).toString();
  Product newProduct = Product(
    id: newId,
    name: name,
    price: price,
    description: description,
    imageUrl: '',
  );
  productsList.add(newProduct);

  final productsBox = Hive.box<Product>('products');
  productsBox.put(newId, newProduct);
}

void syncCurrentUserToHive() {
  if (currentUser == null) return;

  try {
    if (currentUser is Customer) {
      final customersBox = Hive.box<Customer>('customers');
      customersBox.put(currentUser!.email, currentUser as Customer);
    } else if (currentUser is Admin) {
      final adminsBox = Hive.box<Admin>('admins');
      adminsBox.put(currentUser!.email, currentUser as Admin);
    }
  } catch (e) {
    print('Error syncing current user to Hive: $e');
  }
}

void addToCart(String productId, int quantity) {
  Product? product = getProductById(productId);
  if (product != null && currentUser is Customer) {
    (currentUser as Customer)
        .cart
        .addItem(CartItem(product: product, quantity: quantity), quantity);

    // Sync changes to Hive
    syncCurrentUserToHive();
  }
}

void removeFromCart(String productId) {
  if (currentUser is Customer) {
    (currentUser as Customer).cart.removeItem(productId);

    // Sync changes to Hive
    syncCurrentUserToHive();
  }
}

void updateCartItemQuantity(String productId, int quantity) {
  if (currentUser is Customer) {
    (currentUser as Customer).cart.updateItemQuantity(productId, quantity);

    // Sync changes to Hive
    syncCurrentUserToHive();
  }
}

List<CartItem> getCartItems() {
  return currentUser is Customer ? (currentUser as Customer).cart.items : [];
}

double getCartTotal() {
  return currentUser is Customer
      ? (currentUser as Customer).cart.getTotal()
      : 0.0;
}

bool processPayment(String orderId, String paymentMethod) {
  try {
    // البحث في قائمة الطلبات العامة ثم في سجل العميل
    Order? order;
    try {
      order = orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      if (currentUser is Customer) {
        try {
          order = (currentUser as Customer).orderHistory.firstWhere(
                (order) => order.id == orderId,
              );
        } catch (_) {
          return false; // الطلب غير موجود
        }
      } else {
        return false; // المستخدم ليس عميل
      }
    }

    if (order.isPaid) {
      return false;
    }

    Payment payment = Payment(
      paymentId: payments.length + 1,
      orderId: int.parse(orderId),
      amount: order.total,
      paymentDate: DateTime.now(),
      paymentMethod: paymentMethod,
    );

    payment.processPayment();

    order.markAsPaid(paymentMethod);

    payments.add(payment);

    final ordersBox = Hive.box<Order>('orders');
    ordersBox.put(order.id, order);

    final paymentsBox = Hive.box<Payment>('payments');
    paymentsBox.put(payment.paymentId.toString(), payment);

    // Sync the current user data to Hive if it's a customer
    syncCurrentUserToHive();

    return true;
  } catch (e) {
    print('Error processing payment: $e');
    return false;
  }
}

Order? getOrderById(String orderId) {
  // البحث عن الطلب في القائمة العامة
  try {
    return orders.firstWhere((order) => order.id == orderId);
  } catch (_) {
    // البحث في سجل العميل إذا كان مسجل دخول
    if (currentUser is Customer) {
      try {
        return (currentUser as Customer)
            .orderHistory
            .firstWhere((order) => order.id == orderId);
      } catch (_) {}
    }
    return null;
  }
}

List<Order> getUnpaidOrders() {
  List<Order> result = [];

  // الطلبات غير المدفوعة في القائمة العامة
  result.addAll(orders.where((order) => !order.isPaid));

  // إضافة الطلبات غير المدفوعة من سجل العميل الحالي
  if (currentUser is Customer) {
    var userOrders = (currentUser as Customer)
        .orderHistory
        .where((order) => !order.isPaid)
        .toList();

    // إضافة الطلبات التي لم تتم إضافتها بالفعل
    for (var order in userOrders) {
      if (!result.any((o) => o.id == order.id)) {
        result.add(order);
      }
    }
  }

  return result;
}
