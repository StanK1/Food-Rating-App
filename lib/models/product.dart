class Product {
  final String name;
  final String brand;
  final String imageUrl;
  final double rating;
  final String nutriScore;
  final Map<String, dynamic> nutriments;

  Product({
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.rating,
    required this.nutriScore,
    required this.nutriments,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['product_name'] ?? 'Unknown',
      brand: json['brands']?.split(',').first ?? 'Unknown',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150',
      rating: 0.0,
      nutriScore: json['nutriscore_grade'] ?? 'unknown',
      nutriments: json['nutriments'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'rating': rating,
      'nutriScore': nutriScore,
      'nutriments': nutriments,
    };
  }
}
