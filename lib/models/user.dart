import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String address;
  final String password;
  final String token;
  final String types;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.password,
    required this.token,
    required this.types,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'password': password,
      'token': token,
      'types': types,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      types: map['types'] ?? '',
      cart: List<Map<String, dynamic>>.from(
          (map['cart']?.map((x) => Map<String, dynamic>.from(x)))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? address,
    String? password,
    String? token,
    String? types,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      password: password ?? this.password,
      token: token ?? this.token,
      types: types ?? this.types,
      cart: cart ?? this.cart,
    );
  }
}
