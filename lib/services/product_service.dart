import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  // Timeout for API requests
  static const int _timeoutSeconds = 10;

  Future<Product?> fetchProductByBarcode(String barcode) async {
    // Clean barcode - remove any whitespace or non-numeric characters
    barcode = barcode.trim().replaceAll(RegExp(r'[^0-9]'), '');

    if (barcode.isEmpty) {
      print("Empty barcode after cleaning");
      return _createFallbackProduct("Unknown");
    }

    print("Fetching product for barcode: $barcode");
    final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';

    try {
      // Use a timeout to prevent hanging if network is slow
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: _timeoutSeconds));

      if (response.statusCode == 200) {
        // Try-catch to handle potential JSON parsing errors
        try {
          final data = jsonDecode(response.body);
          if (data['status'] == 1 && data['product'] != null) {
            final productData = data['product'];

            // Handle case where product name is missing
            String productName = productData['product_name'] ?? '';
            if (productName.isEmpty) {
              productName = productData['generic_name'] ?? 'Unknown Chocolate';
            }

            // Handle case where brand is missing
            String brand = 'Unknown Brand';
            if (productData['brands'] != null &&
                productData['brands'].toString().isNotEmpty) {
              brand = productData['brands'].toString().split(',').first.trim();
            }

            // Handle missing image URL with a placeholder
            String imageUrl = productData['image_url'] ??
                productData['image_front_url'] ??
                productData['image_small_url'] ??
                'https://via.placeholder.com/150?text=No+Image';

            // Create and return product
            return Product(
              name: productName,
              brand: brand,
              imageUrl: imageUrl,
              rating: 0.0,
              nutriScore:
                  productData['nutriscore_grade']?.toUpperCase() ?? 'N/A',
              nutriments: productData['nutriments'] ?? {},
            );
          } else {
            print("Product not found for barcode: $barcode");
          }
        } catch (e) {
          print("Error parsing product data: $e");
        }
      } else {
        print("Failed to fetch product. Status code: ${response.statusCode}");
      }
    } on TimeoutException {
      print("Request timed out after $_timeoutSeconds seconds");
    } catch (e) {
      print("Error occurred during API call: $e");
    }

    // Create a fallback product for a better user experience
    return _createFallbackProduct(barcode);
  }

  Product _createFallbackProduct(String barcode) {
    return Product(
      name: "Unknown Chocolate",
      brand: "Barcode: $barcode",
      imageUrl: "https://via.placeholder.com/150?text=Chocolate",
      rating: 0.0,
      nutriScore: "?",
      nutriments: {
        "energy-kcal_100g": "Unknown",
        "fat_100g": "Unknown",
        "sugars_100g": "Unknown",
      },
    );
  }
}
