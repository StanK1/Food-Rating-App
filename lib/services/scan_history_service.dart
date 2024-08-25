import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ScanHistoryService {
  static const String _scannedProductsKey = 'scanned_products';

  // Save a new scanned product
  Future<void> addProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productList =
        prefs.getStringList(_scannedProductsKey) ?? [];

    // Convert product to JSON and save it to the list
    productList.add(jsonEncode(product.toJson()));
    await prefs.setStringList(_scannedProductsKey, productList);
  }

  // Retrieve all scanned products
  Future<List<Product>> getScannedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productList =
        prefs.getStringList(_scannedProductsKey) ?? [];

    // Convert JSON to Product list
    return productList
        .map((item) => Product.fromJson(jsonDecode(item)))
        .toList();
  }

  // Clear all scanned products
  Future<void> clearScannedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scannedProductsKey);
  }
}
