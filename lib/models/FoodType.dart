class FoodType {
  final String? slug;
  final String name;

  const FoodType._({
    required this.slug,
    required this.name,
  });

  FoodType({
    required this.name,
  })  : assert(name.isNotEmpty && name.length <= 32),
        this.slug = null;

  FoodType copyWith({
    String? name,
  }) {
    return FoodType._(
      slug: this.slug,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'slug': slug,
      'name': name,
    };
  }

  factory FoodType.fromMap(Map<String, dynamic> map) {
    return FoodType._(
      slug: map['slug'],
      name: map['name'] ?? '',
    );
  }

  @override
  String toString() => 'FoodType(slug: $slug, name: $name)';
}
