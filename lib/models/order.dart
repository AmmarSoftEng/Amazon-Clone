// import 'dart:convert';

// import 'package:amazon_clone_flutter/models/product.dart';

// class OrderList {
//   final String id;
//   final List<Product> product;
//   final List<int> quantity;
//   final String address;
//   final String userId;
//   final int orderedAt;
//   final int status;
//   final double totalPrice;
//   OrderList({
//     required this.id,
//     required this.product,
//     required this.quantity,
//     required this.address,
//     required this.userId,
//     required this.orderedAt,
//     required this.status,
//     required this.totalPrice,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'products': product.map((x) => x.toMap()).toList(),
//       'quantity': quantity,
//       'address': address,
//       'userId': userId,
//       'orderedAt': orderedAt,
//       'status': status,
//       'totalPrice': totalPrice,
//     };
//   }

//   factory OrderList.fromMap(Map<String, dynamic> map) {
//     return OrderList(
//       id: map['_id'] ?? '',
//       product: List<Product>.from(
//           map['products']?.map((x) => Product.fromMap(x['product']))),
//       quantity: List<int>.from(
//         map['products']?.map(
//           (x) => x['quantity'],
//         ),
//       ),
//       address: map['address'] ?? '',
//       userId: map['userId'] ?? '',
//       orderedAt: map['orderedAt']?.toInt() ?? 0,
//       status: map['status']?.toInt() ?? 0,
//       totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory OrderList.fromJson(String source) =>
//       OrderList.fromMap(json.decode(source));
// }

import 'dart:convert';

import 'package:amazon_clone_flutter/models/product.dart';

class OrderList {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;
  OrderList(
      {required this.id,
      required this.products,
      required this.quantity,
      required this.address,
      required this.userId,
      required this.orderedAt,
      required this.status,
      required this.totalPrice});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory OrderList.fromMap(Map<String, dynamic> map) {
    return OrderList(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderList.fromJson(String source) =>
      OrderList.fromMap(json.decode(source) as Map<String, dynamic>);
}
