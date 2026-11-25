class Org {
  final String name;
  final String id;
  final String? logo;
  final String ownerId;

  Org({
    required this.name,
    required this.id,
    required this.ownerId, 
    this.logo
});

  factory Org.fromMap(Map<String, dynamic> map, String id) {
    return Org(
      id: id,
      name: map['name'],
      logo: map['logo'],
      ownerId: map['ownerId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'logo': logo, 'ownerId': ownerId};
  }
}
