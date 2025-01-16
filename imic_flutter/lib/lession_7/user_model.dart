class User {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String ip_address;

  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.ip_address,
  });

  factory User.fromJson(Map json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      gender: json['gender'],
      ip_address: json['ip_address'],
    );
  }
  @override
  String toString() {
    return 'id: $id, first_name: $first_name, last_name: $last_name, gender: $gender';
  }

  toJson() {
    return {'id': id, 'name': first_name};
  }
}
