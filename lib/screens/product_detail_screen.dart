import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl,
                height: 200, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(product.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Brand: ${product.brand}',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 16),
            Text('Nutri-Score: ${product.nutriScore}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 16),
            Text('Nutritional Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
                'Energy: ${product.nutriments['energy-kcal_100g']} kcal per 100g'),
            Text('Fat: ${product.nutriments['fat_100g']} g per 100g'),
            Text('Sugars: ${product.nutriments['sugars_100g']} g per 100g'),
          ],
        ),
      ),
    );
  }
}
