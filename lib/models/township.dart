class Township {
  final int id;
  final String name;

  Township({required this.id, required this.name});

  factory Township.fromJson(Map<String, dynamic> json) {
    return Township(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
