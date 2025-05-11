import 'address_model.dart';

class User {
  final String name;
  final int age;
  final String email;
  final String _password;
  final Address address;
  final String phone;

  User({
    required this.name,
    required this.age,
    required this.email,
    required String password,
    required this.address,
    required this.phone,
  }) : _password = password;

  // Verify password
  bool verifyPassword(String password) => _password == password;

  // Get masked password for display
  String get maskedPassword => '*' * _password.length;

  @override
  String toString() => '''
Name: $name
Age: $age
Email: $email
Phone: $phone
Address: ${address.toString()}
''';
}
