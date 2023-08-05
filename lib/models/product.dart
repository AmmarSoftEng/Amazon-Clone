import 'dart:convert';

// class Product {
//   final String name;
//   final String discription;
//   final double quantity;
//   final String catagory;
//   final double price;
//   final String? id;
//   final List<String> images;
//   Product({
//     required this.name,
//     required this.discription,
//     required this.quantity,
//     required this.catagory,
//     required this.price,
//     this.id,
//     required this.images,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'discription': discription,
//       'quantity': quantity,
//       'catagory': catagory,
//       'price': price,
//       'id': id,
//       'images': images,
//     };
//   }

//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       name: map['name'] as String,
//       discription: map['discription'] as String,
//       quantity: map['quantity'] as double,
//       catagory: map['catagory'] as String,
//       price: map['price'] as double,
//       id: map['_id'] != null ? map['id'] as String : null,
//       images: List<String>.from(map['images']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Product.fromJson(String source) =>
//       Product.fromMap(json.decode(source) as Map<String, dynamic>);
// }
class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  //final List<Ratings>? rating;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    // this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      // 'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      // rating: map['ratings'] != null
      //     ? List<Ratings>.from(map['rating']?.map((x) => Ratings.fromMap(x)))
      //     : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
