class User {
  final String name, email, token, balance;
  final int id;

  User({
    required this.name,
    required this.email,
    required this.id,
    required this.balance,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      id: json['id'],
      balance: json['balance'],
      token: json['token'],
    );
  }
}
