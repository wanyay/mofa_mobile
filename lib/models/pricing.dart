class Pricing {
  final String id;
  final String name;
  final int notaryID;
  final int price;

  Pricing({
    required this.id,
    required this.name,
    required this.notaryID,
    required this.price,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      id: json['id'] as String,
      name: json['name'] as String,
      notaryID: (json['notaryID'] as int),
      price: (json['price'] as int),
    );
  }
}
