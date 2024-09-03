import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/scan_history_service.dart';
import 'product_detail_screen.dart';

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

          setState(() {
            _scannedProduct = product;
            _isLoading = false;
          });

          // Show the product details in a bottom sheet
          _showProductBottomSheet(product);
        } else {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Product not found!")));
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error occurred while scanning.")));
    }
  }

  void _showProductBottomSheet(Product product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Brand: ${product.brand}',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 10),
              Text('Rating: ⭐⭐⭐⭐', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
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
                child: Text('Show Product Details'),
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
        title: Text('Scan a Chocolate'),
      ),
      body: Stack(
        children: [
          Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _scanBarcode,
                    child: Text('Start Scanning'),
                  ),
          ),
        ],
      ),
    );
  }
}
