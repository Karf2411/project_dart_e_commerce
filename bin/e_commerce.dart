import 'dart:io';
import 'package:e_commerce/e_commerce.dart' as e_commerce;
import 'package:e_commerce/models/customer_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/models/order_item_model.dart';
import 'package:hive/hive.dart';

String getInput(String message) {
  print(message);
  return stdin.readLineSync() ?? '';
}

int getNumber(String message) {
  while (true) {
    try {
      return int.parse(getInput(message));
    } catch (e) {
      print('Please enter a valid number');
    }
  }
}

double getDouble(String message) {
  while (true) {
    try {
      return double.parse(getInput(message));
    } catch (e) {
      print('Please enter a valid number');
    }
  }
}

void main() async {
  // Initialize Hive and load data before starting the application
  print('Initializing database...');

  bool databaseInitialized = false;

  try {
    await e_commerce.initializeApp();
    print('Database initialized successfully!');
    databaseInitialized = true;
  } catch (e) {
    print('Error initializing database: $e');

    // Try to manually clean up lock files
    try {
      print('Attempting to clean up lock files...');
      final hiveDir = Directory('hive_data');
      if (hiveDir.existsSync()) {
        for (var file in hiveDir.listSync()) {
          if (file.path.endsWith('.lock')) {
            try {
              File(file.path).deleteSync();
              print('Deleted lock file: ${file.path}');
            } catch (e) {
              print('Failed to delete lock file ${file.path}: $e');
            }
          }
        }
      }

      print('Retrying database initialization...');
      await e_commerce.initializeApp();
      print('Database initialized successfully on second attempt!');
      databaseInitialized = true;
    } catch (retryError) {
      print('Failed to initialize database on retry: $retryError');
      print('Running with in-memory data only.');
    }
  }

  while (true) {
    print('\n=== Welcome to E-Commerce Console App ===');
    print('1. Login as Admin');
    print('2. Login as User');
    print('3. Register as Admin');
    print('4. Register as User');
    print('0. Exit');
    print('=======================================');

    String choice = getInput('Choose an option: ');

    switch (choice) {
      case '1':
        loginAdmin();
        break;
      case '2':
        loginUser();
        break;
      case '3':
        registerAdmin();
        break;
      case '4':
        registerUser();
        break;
      case '0':
        print('Thank you for using the app!');

        // Close Hive boxes before exiting only if we successfully initialized
        if (databaseInitialized) {
          try {
            await e_commerce.closeApp();
            print('Database closed successfully.');
          } catch (e) {
            print('Error closing database: $e');
          }
        }

        return;
      default:
        print('Invalid choice, please try again');
    }
  }
}

void loginAdmin() {
  String email = getInput('Enter admin email: ');
  String password = getInput('Enter admin password: ');

  try {
    // Use the function from e_commerce library that checks Hive first
    bool success = e_commerce.loginAdmin(email, password);
    if (success) {
      var admin = e_commerce.currentUser;
      print('Welcome ${admin?.name}!');
      showAdminMenu();
    } else {
      print('Invalid credentials!');
    }
  } catch (e) {
    print('Invalid credentials!');
  }
}

void loginUser() {
  String email = getInput('Enter user email: ');
  String password = getInput('Enter user password: ');

  try {
    // Use the function from e_commerce library that checks Hive first
    bool success = e_commerce.loginUser(email, password);
    if (success) {
      var user = e_commerce.currentUser;
      print('Welcome ${user?.name}!');
      showUserMenu();
    } else {
      print('Invalid credentials!');
    }
  } catch (e) {
    print('Invalid credentials!');
  }
}

void registerAdmin() {
  print('\n=== Register as Admin ===');

  String adminPassword = getInput('Enter admin registration password: ');
  if (adminPassword != e_commerce.adminRegistrationPassword) {
    print('Invalid admin registration password!');
    return;
  }

  String name = getInput('Enter name: ');
  int age = getNumber('Enter age: ');
  String email = getInput('Enter email: ');
  String password = getInput('Enter password: ');
  String street = getInput('Enter street: ');
  String city = getInput('Enter city: ');
  String country = getInput('Enter country: ');
  String phone = getInput('Enter phone: ');

  e_commerce.addAdmin(name, age, email, password, street, city, country, phone);
  print('Admin registered successfully!');
}

void registerUser() {
  print('\n=== Register as User ===');

  String name = getInput('Enter name: ');
  int age = getNumber('Enter age: ');
  String email = getInput('Enter email: ');
  String password = getInput('Enter password: ');
  String street = getInput('Enter street: ');
  String city = getInput('Enter city: ');
  String country = getInput('Enter country: ');
  String phone = getInput('Enter phone: ');

  e_commerce.addUser(name, age, email, password, street, city, country, phone);
  print('User registered successfully!');
}

void showAdminMenu() {
  while (true) {
    print('\n=== Admin Menu ===');
    print('1. Show All Products');
    print('2. Add New Product');
    print('3. Update Product');
    print('4. Delete Product');
    print('5. Show All Orders');
    print('6. Show All Users');
    print('0. Logout');
    print('===================');

    String choice = getInput('Choose an option: ');

    switch (choice) {
      case '1':
        showProducts();
        break;
      case '2':
        addProduct();
        break;
      case '3':
        updateProduct();
        break;
      case '4':
        deleteProduct();
        break;
      case '5':
        showOrders();
        break;
      case '6':
        showUsers();
        break;
      case '0':
        return;
      default:
        print('Invalid choice, please try again');
    }
  }
}

void showUserMenu() {
  while (true) {
    print('\n=== User Menu ===');
    print('1. Show Products');
    print('2. Add Product to Cart');
    print('3. Show Cart');
    print('4. Remove Product from Cart');
    print('5. Update Cart Item Quantity');
    print('6. Place Order');
    print('7. View Order History');
    print('8. Pay for Order');
    print('0. Logout');
    print('===================');

    String choice = getInput('Choose an option: ');

    switch (choice) {
      case '1':
        showProducts();
        break;
      case '2':
        addToCart();
        break;
      case '3':
        showCart();
        break;
      case '4':
        removeFromCart();
        break;
      case '5':
        updateCartItem();
        break;
      case '6':
        placeOrder();
        break;
      case '7':
        showOrderHistory();
        break;
      case '8':
        payForOrder();
        break;
      case '0':
        return;
      default:
        print('Invalid choice, please try again');
    }
  }
}

// Admin functions
void showProducts() {
  print('\n=== Available Products ===');
  for (var product in e_commerce.productsList) {
    print('${product.id}. ${product.name} - \$${product.price}');
    print('   Description: ${product.description}');
    print('-------------------');
  }
}

void addProduct() {
  print('\n=== Add New Product ===');
  String name = getInput('Enter product name: ');
  double price = getDouble('Enter product price: ');
  String description = getInput('Enter product description: ');

  try {
    e_commerce.addNewProduct(name, price, description);
    print('Product added successfully!');
  } catch (e) {
    print('Error adding product: $e');
  }
}

void updateProduct() {
  String id = getInput('Enter product ID: ');
  String name = getInput('Enter new name: ');
  double price = double.parse(getInput('Enter new price: '));
  String description = getInput('Enter new description: ');

  var product = e_commerce.getProductById(id);
  if (product != null) {
    product.name = name;
    product.price = price;
    product.description = description;

    // حفظ التغييرات في قاعدة البيانات
    final productsBox = Hive.box<Product>('products');
    productsBox.put(id, product);

    print('Product updated successfully!');
  } else {
    print('Product not found!');
  }
}

void deleteProduct() {
  String id = getInput('Enter product ID: ');
  var product = e_commerce.getProductById(id);
  if (product != null) {
    e_commerce.productsList.remove(product);

    // حذف المنتج من قاعدة البيانات
    final productsBox = Hive.box<Product>('products');
    productsBox.delete(id);

    print('Product deleted successfully!');
  } else {
    print('Product not found!');
  }
}

void showOrders() {
  print('\n=== All Orders ===');
  if (e_commerce.orders.isEmpty) {
    print('No orders found');
  } else {
    for (var order in e_commerce.orders) {
      print('\nOrder ID: ${order.id}');
      print('Customer: ${order.customerName}');
      print('Address: ${order.customerAddress}');
      print('Items:');
      for (var item in order.items) {
        print(
            '- ${item.product.name} x ${item.quantity} = \$${item.price * item.quantity}');
      }
      print('Total: \$${order.total}');
      print('Status: ${order.status}');
      print('Paid: ${order.isPaid ? 'Yes' : 'No'}');
      if (order.isPaid) {
        print('Payment Method: ${order.paymentMethod}');
        print('Payment Date: ${order.paymentDate?.toString().split('.')[0]}');
      }
      print('-------------------');
    }
  }
}

void showUsers() {
  print('\n=== All Users ===');
  if (e_commerce.usersList.isEmpty) {
    print('No users found');
  } else {
    for (var user in e_commerce.usersList) {
      print('\nUser ID/Email: ${user.email}');
      print('Name: ${user.name}');
      print('Age: ${user.age}');
      print(
          'Address: ${user.address.street}, ${user.address.city}, ${user.address.country}');
      print('Phone: ${user.phone}');
      print('-------------------');
    }
  }
}

// User functions
void addToCart() {
  String id = getInput('Enter product ID: ');
  int quantity = getNumber('Enter quantity: ');

  e_commerce.addToCart(id, quantity);
  print('Product added to cart!');
}

void showCart() {
  print('\n=== Cart Contents ===');
  var items = e_commerce.getCartItems();
  if (items.isEmpty) {
    print('Cart is empty');
  } else {
    for (var item in items) {
      print(
          '${item.product.name} x ${item.quantity} = \$${item.product.price * item.quantity}');
    }
    print('Total: \$${e_commerce.getCartTotal()}');
  }
}

void removeFromCart() {
  String id = getInput('Enter product ID: ');
  e_commerce.removeFromCart(id);
  print('Product removed from cart!');
}

void updateCartItem() {
  String id = getInput('Enter product ID: ');
  int quantity = getNumber('Enter new quantity: ');
  e_commerce.updateCartItemQuantity(id, quantity);
  print('Quantity updated!');
}

void placeOrder() {
  var cartItems = e_commerce.getCartItems();

  if (cartItems.isEmpty) {
    print('Cart is empty!');
    return;
  }

  String name = getInput('Enter your name: ');
  String address = getInput('Enter your address: ');

  List<OrderItem> orderItems = cartItems
      .map((cartItem) => OrderItem(
          product: cartItem.product,
          quantity: cartItem.quantity,
          price: cartItem.product.price))
      .toList();

  Order order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerName: name,
      customerAddress: address,
      items: orderItems,
      total: e_commerce.getCartTotal(),
      status: 'Pending');

  if (e_commerce.currentUser is Customer) {
    var customer = e_commerce.currentUser as Customer;

    // إضافة الطلب إلى قائمة الطلبات العامة
    e_commerce.orders.add(order);

    // إضافة الطلب إلى سجل العميل
    customer.placeOrder(order);

    // تفريغ السلة بعد إتمام الطلب
    customer.cart.clear();

    // حفظ الطلب في قاعدة البيانات
    final ordersBox = Hive.box<Order>('orders');
    ordersBox.put(order.id, order);

    // تحديث بيانات العميل في قاعدة البيانات
    final customersBox = Hive.box<Customer>('customers');
    customersBox.put(customer.email, customer);

    // Sync the current user to Hive using the library function
    e_commerce.syncCurrentUserToHive();

    print('Order placed successfully!');
    print('Order ID: ${order.id}');
    print('Total: \$${order.total}');
  } else {
    print('You need to be logged in as a customer to place an order.');
  }
}

void showOrderHistory() {
  print('\n=== Order History ===');

  if (e_commerce.currentUser is Customer) {
    var customer = e_commerce.currentUser as Customer;
    var userOrders = customer.orderHistory;

    if (userOrders.isEmpty) {
      print('No orders found in your history');
    } else {
      for (var order in userOrders) {
        print('\nOrder ID: ${order.id}');
        print('Customer: ${order.customerName}');
        print('Address: ${order.customerAddress}');
        print('Items:');
        for (var item in order.items) {
          print(
              '- ${item.product.name} x ${item.quantity} = \$${item.price * item.quantity}');
        }
        print('Total: \$${order.total}');
        print('Status: ${order.status}');
        print('Paid: ${order.isPaid ? 'Yes' : 'No'}');
        if (order.isPaid) {
          print('Payment Method: ${order.paymentMethod}');
          print('Payment Date: ${order.paymentDate?.toString().split('.')[0]}');
        }
        print('-------------------');
      }
    }
  } else {
    print('You need to be logged in as a customer to view your order history.');
  }
}

void payForOrder() {
  print('\n=== Pay for Order ===');

  if (e_commerce.currentUser is Customer) {
    var customer = e_commerce.currentUser as Customer;

    // عرض الطلبات غير المدفوعة من تاريخ طلبات المستخدم
    var unpaidOrders =
        customer.orderHistory.where((order) => !order.isPaid).toList();
    if (unpaidOrders.isEmpty) {
      print('No unpaid orders found!');
      return;
    }

    print('Your unpaid orders:');
    for (var order in unpaidOrders) {
      print('${order.id}. Total: \$${order.total} - Status: ${order.status}');
    }

    // اختيار الطلب للدفع
    String orderId = getInput('Enter order ID to pay (or 0 to cancel): ');
    if (orderId == '0') return;

    // البحث عن الطلب باستخدام الدالة المحسنة للبحث في النظام
    Order? order = e_commerce.getOrderById(orderId);

    if (order == null) {
      print('Order not found!');
      return;
    }

    if (order.isPaid) {
      print('This order is already paid!');
      return;
    }

    // اختيار طريقة الدفع
    print('\nPayment Methods:');
    print('1. Credit Card');
    print('2. PayPal');
    print('3. Cash on Delivery');

    String paymentChoice = getInput('Choose payment method: ');
    String paymentMethod;

    switch (paymentChoice) {
      case '1':
        paymentMethod = 'Credit Card';
        getInput('Enter card number: ');
        getInput('Enter expiry date (MM/YY): ');
        getInput('Enter CVV: ');
        print('Processing credit card payment...');
        break;
      case '2':
        paymentMethod = 'PayPal';
        getInput('Enter PayPal email: ');
        getInput('Enter PayPal password: ');
        print('Processing PayPal payment...');
        break;
      case '3':
        paymentMethod = 'Cash on Delivery';
        print('Cash on delivery selected');
        break;
      default:
        print('Invalid payment method!');
        return;
    }

    // معالجة الدفع
    bool success = e_commerce.processPayment(orderId, paymentMethod);

    if (success) {
      print('Payment processed successfully!');
      print('Order status updated to: Paid');

      // تحديث بيانات المستخدم في قاعدة البيانات
      final customersBox = Hive.box<Customer>('customers');
      customersBox.put(customer.email, customer);
    } else {
      print('Payment processing failed!');
    }
  } else {
    print('You need to be logged in as a customer to pay for orders.');
  }
}
