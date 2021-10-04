// ignore_for_file: non_constant_identifier_names
import 'package:flutter_restaurant/models/Review.dart';
import 'package:flutter_restaurant/utils/validator.dart';

class Restaurant {
  final String? slug;
  final String name;
  final String description;
  final String? logo;
  final double? rating;
  final Set<String> food_type;
  final List<Review>? reviews;

  const Restaurant._({
    required this.slug,
    required this.name,
    required this.description,
    this.logo,
    this.rating = 0.0,
    required this.food_type,
    required this.reviews,
  });

  Restaurant({
    required this.name,
    required this.description,
    required this.food_type,
  })  : assert(name.isNotEmpty && name.length <= 32),
        assert(description.isNotEmpty),
        assert(food_type.every((element) => element.isSlug)),
        slug = null,
        logo = null,
        rating = null,
        reviews = null;

  Restaurant copyWith({
    String? name,
    String? description,
    Set<String>? food_type,
  }) {
    return Restaurant._(
      slug: this.slug,
      name: name ?? this.name,
      description: description ?? this.description,
      logo: this.logo,
      rating: this.rating,
      food_type: food_type ?? this.food_type,
      reviews: this.reviews,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'slug': slug,
      'name': name,
      'description': description,
      'logo': logo,
      'rating': rating,
      'food_type': food_type.toList(),
      'reviews': reviews?.map((x) => x.toMap()).toList(),
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant._(
      slug: map['slug'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      logo: map['logo'],
      rating: map['rating'] ?? 0.0,
      food_type: Set<String>.from(map['food_type'] ?? const {}),
      reviews: List<Review>.from(map['reviews']?.map((x) => Review.fromMap(x)) ?? const []),
    );
  }

  @override
  String toString() {
    return 'Restaurant(slug: $slug, name: $name, description: $description, logo: $logo, rating: $rating, food_type: $food_type, reviews: $reviews)';
  }
}
