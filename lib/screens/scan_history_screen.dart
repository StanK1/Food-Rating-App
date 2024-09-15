import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/scan_history_service.dart';
import 'product_detail_screen.dart';
import '../widgets/product_card.dart';

class ScanHistoryScreen extends StatefulWidget {
  const ScanHistoryScreen({super.key});

  @override
  _ScanHistoryScreenState createState() => _ScanHistoryScreenState();
}

class _ScanHistoryScreenState extends State<ScanHistoryScreen> {
  late Future<List<Product>> _scannedProductsFuture;
  final ScanHistoryService _scanHistoryService = ScanHistoryService();

  @override
  void initState() {
    super.initState();
    _scannedProductsFuture = _scanHistoryService.getScannedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanned Chocolates'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _scannedProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading scanned products'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products scanned yet.'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: ProductCard(product: product),
                );
              },
            );
          }
        },
      ),
    );
  }
}
