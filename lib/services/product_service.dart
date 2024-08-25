import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  Future<Product?> fetchProductByBarcode(String barcode) async {
    final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print('API Response: ${response.body}'); // Debugging line
        if (data['status'] == 1) {
          final productData = data['product'];
          return Product(
            name: productData['product_name'] ?? 'Unknown',
            brand: productData['brands']?.split(',').first ?? 'Unknown',
            imageUrl:
                productData['image_url'] ?? 'https://via.placeholder.com/150',
            rating: 0.0, // Default rating as the API doesn't provide this
            nutriScore: productData['nutriscore_grade'] ?? 'unknown',
            nutriments: productData['nutriments'] ?? {},
          );
        } else {
          print("Product not found");
        }
      } else {
        print("Failed to fetch product. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
    return null;
  }
}
