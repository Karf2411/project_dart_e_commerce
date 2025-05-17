import 'dart:io';
import 'package:hive/hive.dart';
import '../models/address_model.dart';
import '../models/user_model.dart';
import '../models/customer_model.dart';
import '../models/admin_model.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import '../models/order_item_model.dart';
import '../models/payment_model.dart';

class HiveInit {
  static Future<void> initialize() async {
    try {
      final appDocDir = Directory('hive_data');
      if (!appDocDir.existsSync()) {
        appDocDir.createSync();
      }
      Hive.init(appDocDir.path);

      // Register adapters
      _registerAdapters();

      // Open boxes
      await Future.wait([
        Hive.openBox<Customer>('customers'),
        Hive.openBox<Product>('products'),
        Hive.openBox<Order>('orders'),
        Hive.openBox<Payment>('payments'),
        Hive.openBox<Admin>('admins'),
      ]);

      print('Hive initialized successfully!');
    } catch (e) {
      print('Error initializing Hive: $e');
      rethrow; // إعادة رمي الخطأ للمعالجة في المستوى الأعلى
    }
  }

  static void _registerAdapters() {
    // Only register if not already registered
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(AddressAdapter());
      Hive.registerAdapter(UserAdapter());
      Hive.registerAdapter(ProductAdapter());
      Hive.registerAdapter(CartItemAdapter());
      Hive.registerAdapter(CartAdapter());
      Hive.registerAdapter(CustomerAdapter());
      Hive.registerAdapter(OrderItemAdapter());
      Hive.registerAdapter(OrderAdapter());
      Hive.registerAdapter(PaymentAdapter());
      Hive.registerAdapter(AdminAdapter());
    }
  }
}
