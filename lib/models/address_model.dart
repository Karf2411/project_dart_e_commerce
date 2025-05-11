class Address {
  final String street;
  final String city;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.country,
  });

  @override
  String toString() => '$street, $city, $country';
}
