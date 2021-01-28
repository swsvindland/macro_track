class User {
  final String id;
  final String name;
  final String email;

  User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], email: json['email']);
  }

  factory User.set(String id, String name, String email) {
    return User(id: id, name: name, email: email);
  }
}