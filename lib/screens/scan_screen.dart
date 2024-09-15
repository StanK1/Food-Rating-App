import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/scan_history_service.dart';
import 'product_detail_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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

          setState(() {
            _isLoading = false;
          });

          // Show the product details in a bottom sheet
          _showProductBottomSheet(product);
        } else {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Product not found!")));
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error occurred while scanning.")));
    }
  }

  void _showProductBottomSheet(Product product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Brand: ${product.brand}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 10),
              const Text('Rating: ⭐⭐⭐⭐', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product)),
                  );
                },
                child: const Text('Show Product Details'),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan a Chocolate'),
      ),
      body: Stack(
        children: [
          Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _scanBarcode,
                    child: const Text('Start Scanning'),
                  ),
          ),
        ],
      ),
    );
  }
}
