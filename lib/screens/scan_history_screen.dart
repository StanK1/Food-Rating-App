import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/scan_history_service.dart';
import '../widgets/product_card.dart';

class ScanHistoryScreen extends StatefulWidget {
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
        title: Text('Scanned Chocolates'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _scannedProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading scanned products'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products scanned yet.'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            );
          }
        },
      ),
    );
  }
}