import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/scan_history_service.dart';
import '../widgets/product_card.dart';
import 'scan_history_screen.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  Product? _scannedProduct;
  bool _isLoading = false;
  final ScanHistoryService _scanHistoryService = ScanHistoryService();

  Future<void> _scanBarcode() async {
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      if (barcode != '-1') {
        setState(() {
          _isLoading = true;
        });

        ProductService productService = ProductService();
        Product? product = await productService.fetchProductByBarcode(barcode);

        if (product != null) {
          await _scanHistoryService.addProduct(product);
        }

        setState(() {
          _scannedProduct = product;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan a Chocolate'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _scannedProduct == null
              ? Center(
                  child: ElevatedButton(
                    onPressed: _scanBarcode,
                    child: Text('Start Scanning'),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ProductCard(product: _scannedProduct!),
                ),
    );
  }
}
