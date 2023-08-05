import 'dart:convert';

class Ratings {
  final String uid;
  final double rating;

  Ratings({
    required this.uid,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'rating': rating,
    };
  }

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(
      uid: map['uid'] as String,
      rating: map['rating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ratings.fromJson(String source) =>
      Ratings.fromMap(json.decode(source) as Map<String, dynamic>);
}
