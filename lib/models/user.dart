class User {
  final int id;
  final String name;
  final String phone;
  final String nrc;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.nrc,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      nrc: json['nrc'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'phone': phone, 'nrc': nrc};
  }
}
