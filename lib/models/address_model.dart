import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 1)
class Address {
  @HiveField(0)
  final String street;

  @HiveField(1)
  final String city;

  @HiveField(2)
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.country,
  });

  @override
  String toString() => '$street, $city, $country';
}
