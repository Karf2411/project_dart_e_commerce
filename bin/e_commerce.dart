import 'dart:io';
import 'package:e_commerce/e_commerce.dart' as e_commerce;
import 'package:e_commerce/models/order_model.dart';

// Helper function to get user input
String getInput(String message) {
  print(message);
  return stdin.readLineSync() ?? '';
}

// Helper function to get a number
int getNumber(String message) {
  while (true) {
    try {
      return int.parse(getInput(message));
    } catch (e) {
      print('Please enter a valid number');
    }
  }
}

void main() {
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
    var admin = e_commerce.admins.firstWhere(
      (admin) => admin.email == email && admin.verifyPassword(password),
    );
    print('Welcome ${admin.name}!');
    showAdminMenu();
  } catch (e) {
    print('Invalid credentials!');
  }
}

void loginUser() {
  String email = getInput('Enter user email: ');
  String password = getInput('Enter user password: ');

  try {
    var user = e_commerce.users.firstWhere(
      (user) => user.email == email && user.verifyPassword(password),
    );
    print('Welcome ${user.name}!');
    showUserMenu();
  } catch (e) {
    print('Invalid credentials!');
  }
}

void registerAdmin() {
  print('\n=== Register as Admin ===');

  String adminPassword = getInput('Enter admin registration password: ');
  if (adminPassword != e_commerce.ADMIN_REGISTRATION_PASSWORD) {
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
  for (var product in e_commerce.products) {
    print('${product.id}. ${product.name} - \$${product.price}');
  }
}

void addProduct() {
  String name = getInput('Enter product name: ');
  double price = double.parse(getInput('Enter product price: '));
  String description = getInput('Enter product description: ');

  e_commerce.addNewProduct(name, price, description);
  print('Product added successfully!');
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
    print('Product updated successfully!');
  } else {
    print('Product not found!');
  }
}

void deleteProduct() {
  String id = getInput('Enter product ID: ');
  var product = e_commerce.getProductById(id);
  if (product != null) {
    e_commerce.products.remove(product);
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
      print(order);
    }
  }
}

void showUsers() {
  print('\n=== All Users ===');
  if (e_commerce.users.isEmpty) {
    print('No users found');
  } else {
    for (var user in e_commerce.users) {
      print(user);
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
  if (e_commerce.cart.items.isEmpty) {
    print('Cart is empty!');
    return;
  }

  String name = getInput('Enter your name: ');
  String address = getInput('Enter your address: ');

  Order order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerName: name,
      customerAddress: address,
      items: List.from(e_commerce.cart.items),
      total: e_commerce.cart.getTotal(),
      status: 'Pending');

  e_commerce.orders.add(order);
  e_commerce.cart.items.clear();
  print('Order placed successfully!');
  print('Order ID: ${order.id}');
  print('Total: \$${order.total}');
}

void showOrderHistory() {
  print('\n=== Order History ===');
  if (e_commerce.orders.isEmpty) {
    print('No orders found');
  } else {
    for (var order in e_commerce.orders) {
      print('\nOrder ID: ${order.id}');
      print('Customer: ${order.customerName}');
      print('Address: ${order.customerAddress}');
      print('Items:');
      for (var item in order.items) {
        print('- ${item.product.name} x ${item.quantity}');
      }
      print('Total: \$${order.total}');
      print('Status: ${order.status}');
      print('-------------------');
    }
  }
}
