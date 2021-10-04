import 'package:flutter_restaurant/utils/validator.dart';
import 'package:get/get.dart';

const _kRatings = [0, 1, 2, 3, 4, 5];

class Review {
  final String? slug;
  final String restaurant;
  final String email;
  final String? comments;
  final int rating;
  final String? created;
  DateTime? get createdDate => DateTime.tryParse(created ?? '') ?? null;

  const Review._({
    required this.slug,
    required this.restaurant,
    required this.email,
    this.comments,
    required this.rating,
    this.created,
  });

  Review({
    required this.restaurant,
    required this.email,
    this.comments,
    required this.rating,
  })  : assert(restaurant.isSlug),
        assert(email.isEmail && email.length <= 64),
        assert(_kRatings.contains(rating)),
        this.slug = null,
        this.created = null;

  Review copyWith({
    String? restaurant,
    String? email,
    String? comments,
    int? rating,
  }) {
    return Review._(
      slug: this.slug,
      restaurant: restaurant ?? this.restaurant,
      email: email ?? this.email,
      comments: comments ?? this.comments,
      rating: rating ?? this.rating,
      created: this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'slug': slug,
      'restaurant': restaurant,
      'email': email,
      'comments': comments,
      'rating': rating,
      'created': created,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review._(
      slug: map['slug'],
      restaurant: map['restaurant'] ?? '',
      email: map['email'] ?? '',
      comments: map['comments'],
      rating: map['rating'] ?? 0,
      created: map['created'],
    );
  }

  @override
  String toString() {
    return 'Review(slug: $slug, restaurant: $restaurant, email: $email, comments: $comments, rating: $rating, created: $created)';
  }
}
