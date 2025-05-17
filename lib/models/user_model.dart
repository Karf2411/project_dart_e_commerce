import 'package:hive/hive.dart';
import 'address_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final Address address;

  @HiveField(5)
  final String phone;

  User({
    required this.name,
    required this.age,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
  });

  // Verify password
  bool verifyPassword(String pwd) => password == pwd;

  // Get masked password for display
  String get maskedPassword => '*' * password.length;

  @override
  String toString() => '''
Name: $name
Age: $age
Email: $email
Phone: $phone
Address: ${address.toString()}
''';
}
