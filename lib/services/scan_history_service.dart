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

    productList.add(jsonEncode(product.toJson()));
    await prefs.setStringList(_scannedProductsKey, productList);
  }

  // Retrieve all scanned products
  Future<List<Product>> getScannedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productList =
        prefs.getStringList(_scannedProductsKey) ?? [];

    List<Product> products = productList.map((item) {
      return Product.fromJson(jsonDecode(item));
    }).toList();

    return products;
  }

  Future<void> clearScannedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scannedProductsKey);
  }
}
