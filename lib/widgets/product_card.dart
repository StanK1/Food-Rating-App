import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Image.network(
              product.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(Icons.image_not_supported,
                        size: 50, color: Colors.grey),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            // Product Name
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            // Product Brand
            Text(
              'Brand: ${product.brand}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            // Nutri-Score
            if (product.nutriScore != 'unknown')
              Text(
                'Nutri-Score: ${product.nutriScore.toUpperCase()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            const SizedBox(height: 10),
            // Nutritional Information
            if (product.nutriments.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nutritional Information:',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(
                      'Energy: ${product.nutriments['energy-kcal_100g'] ?? 'N/A'} kcal per 100g'),
                  Text(
                      'Fat: ${product.nutriments['fat_100g'] ?? 'N/A'} g per 100g'),
                  Text(
                      'Sugars: ${product.nutriments['sugars_100g'] ?? 'N/A'} g per 100g'),
                  // Add more nutritional info as needed
                ],
              ),
            const SizedBox(height: 10),
            // Product Rating (Placeholder)
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < product.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
