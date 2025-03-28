import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/scan_history_service.dart';
import '../services/points_service.dart';
import 'product_detail_screen.dart';
import 'scan_history_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _isCameraInitialized = false;
  final ScanHistoryService _scanHistoryService = ScanHistoryService();
  late AnimationController _pulseController;
  MobileScannerController? _scannerController;
  bool _hasScanned = false;
  String _errorMessage = '';
  bool _hasCameraPermission = false;

  // Animation controllers for space theme elements
  late AnimationController _starsController;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _starsController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    // Delay scanner initialization to prevent crashes
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted && !_isInitializing) {
        _initializeScanner();
      }
    });
  }

  Future<void> _initializeScanner() async {
    // Guard against multiple initialization attempts
    if (_isInitializing) return;

    setState(() {
      _isInitializing = true;
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Dispose existing controller if it exists to prevent duplicates
      if (_scannerController != null) {
        try {
          await _scannerController!.stop();
          _scannerController!.dispose();
          _scannerController = null;
        } catch (e) {
          print("Error disposing existing scanner: $e");
        }
      }

      // Create a new controller with safe settings
      _scannerController = MobileScannerController(
        formats: const [
          BarcodeFormat.ean8,
          BarcodeFormat.ean13,
          BarcodeFormat.upcA,
          BarcodeFormat.upcE
        ],
        detectionSpeed: DetectionSpeed.normal,
        facing: CameraFacing.back,
        torchEnabled: false,
      );

      // Use a try-catch with a timeout to ensure we don't get stuck
      try {
        await _scannerController!.start().timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            throw TimeoutException('Camera initialization timed out');
          },
        );

        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
            _hasCameraPermission = true;
            _isLoading = false;
            _isInitializing = false;
          });
        }
      } catch (e) {
        print("Error starting scanner: $e");
        if (mounted) {
          setState(() {
            _errorMessage = e.toString().contains('permission')
                ? 'Camera permission denied'
                : 'Failed to initialize camera. Please try again.';
            _isLoading = false;
            _isInitializing = false;
          });
        }
      }
    } catch (e) {
      print("Error creating scanner controller: $e");
      if (mounted) {
        setState(() {
          _errorMessage = 'Could not access camera: $e';
          _isLoading = false;
          _isInitializing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _starsController.dispose();

    // Safely dispose scanner controller
    try {
      if (_scannerController != null) {
        _scannerController!.stop();
        _scannerController!.dispose();
        _scannerController = null;
      }
    } catch (e) {
      print("Error disposing scanner: $e");
    }
    super.dispose();
  }

  Future<void> _processBarcode(String barcode) async {
    if (_hasScanned) return; // Prevent multiple scans
    _hasScanned = true;

    setState(() {
      _isLoading = true;
    });

    try {
      ProductService productService = ProductService();
      PointsService pointsService = PointsService();

      Product? product = await productService.fetchProductByBarcode(barcode);

      if (product != null) {
        bool isFirstScan = await pointsService.isFirstScan();
        await _scanHistoryService.addProduct(product);

        if (isFirstScan) {
          await pointsService.markFirstScanComplete();
        }

        setState(() {
          _isLoading = false;
        });

        // Show success message with points
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFirstScan
                  ? "Congratulations! You earned ${PointsService.firstScanPoints} ChocoPoints!"
                  : "You earned ${PointsService.regularScanPoints} ChocoPoints!",
            ),
            backgroundColor: const Color(0xFFFFB800),
          ),
        );

        _showProductBottomSheet(product);
      } else {
        setState(() {
          _isLoading = false;
          _hasScanned = false;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Product not found!")));
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasScanned = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Error scanning: ${e.toString().substring(0, min(50, e.toString().length))}")));
    }
  }

  void _retryScanner() {
    setState(() {
      _errorMessage = '';
      _isInitializing = false;
    });

    _initializeScanner();
  }

  void _showProductBottomSheet(Product product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2A1A4A), Color(0xFF05032A)],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cosmic discovery theme
              Center(
                child: Container(
                  width: 80,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF09EFF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.rocket_launch,
                      color: Color(0xFFF09EFF),
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cosmic Discovery",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          product.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.science,
                      color: Color(0xFFAB2AC2),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Brand: ${product.brand}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(0xFFFFB800),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Cosmic Rating: ★★★★',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product)),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFFF09EFF).withOpacity(0.8),
                        const Color(0xFFAB2AC2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF09EFF).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore More Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) {
      // Reset hasScanned when bottom sheet is closed
      setState(() {
        _hasScanned = false;
      });
    });
  }

  // Helper function to safely get substring length
  int min(int a, int b) {
    return a < b ? a : b;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          // Enhanced cosmic gradient background
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [
              const Color(0xFF0A0428), // Deeper space color
              const Color(0xFF1B0945), // Deep purple space
              const Color(0xFF353352), // Medium space color
            ],
          ),
        ),
        child: Stack(
          children: [
            // Space star particles background
            Positioned.fill(
              child: _buildStarParticles(),
            ),

            // Main content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Section
                      Column(
                        children: [
                          const SizedBox(height: 32),
                          // Logo and Header
                          _buildHeader(),
                          const SizedBox(height: 32),
                          // Scanner Frame
                          _buildScannerFrame(),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage.isNotEmpty
                                ? 'Please grant camera permission to scan'
                                : 'Align the barcode within the cosmic scanner',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),

                      // Bottom Section
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            _isLoading
                                ? Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xFFF09EFF),
                                      ),
                                    ),
                                  )
                                : _buildScanButton(),
                            const SizedBox(height: 16),
                            _buildHistoryButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarParticles() {
    return AnimatedBuilder(
      animation: _starsController,
      builder: (context, child) {
        return CustomPaint(
          painter: StarsPainter(
            animation: _starsController.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Animated Logo
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFF09EFF)
                      .withOpacity(0.3 + (_pulseController.value * 0.2)),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF09EFF)
                        .withOpacity(0.2 + (_pulseController.value * 0.1)),
                    blurRadius: 20 + (_pulseController.value * 20),
                    spreadRadius: _pulseController.value * 5,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/logo/astro.png',
                fit: BoxFit.contain,
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        // Title and Subtitle with cosmic shine
        _buildTitleAndSubtitle(),
      ],
    );
  }

  Widget _buildTitleAndSubtitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color(0xFFAB2AC2),
          Color(0xFFF09EFF),
          Color(0xFF9D71E8),
          Color(0xFFF09EFF),
        ],
        stops: [0.0, 0.3, 0.6, 1.0],
      ).createShader(bounds),
      child: const Text(
        'Ready for Your\nCosmic Chocolate Mission?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildScannerFrame() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF09EFF).withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Show error message if scanner failed
                if (_errorMessage.isNotEmpty)
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Color(0xFFF09EFF),
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _retryScanner,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFAB2AC2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Request Permission'),
                          ),
                        ],
                      ),
                    ),
                  )
                // Camera Scanner
                else if (_isCameraInitialized && _scannerController != null)
                  MobileScanner(
                    controller: _scannerController!,
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      if (barcodes.isNotEmpty && !_hasScanned) {
                        for (final barcode in barcodes) {
                          if (barcode.rawValue != null) {
                            print("Barcode detected: ${barcode.rawValue}");
                            _processBarcode(barcode.rawValue!);
                            break;
                          }
                        }
                      }
                    },
                    errorBuilder: (context, error, child) {
                      return Container(
                        color: Colors.black.withOpacity(0.7),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Color(0xFFF09EFF),
                                size: 48,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Camera error: ${error.errorCode}',
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: _retryScanner,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFAB2AC2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                // Loading placeholder
                else
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, _) {
                                return CircularProgressIndicator(
                                  color: Color.lerp(
                                    const Color(0xFFF09EFF),
                                    const Color(0xFFAB2AC2),
                                    _pulseController.value,
                                  ),
                                  strokeWidth: 3,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Initializing cosmic scanner...",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Cosmic Scanner Corner Decorations
                ...List.generate(4, (index) {
                  return Positioned(
                    top: index < 2 ? 0 : null,
                    bottom: index >= 2 ? 0 : null,
                    left: index % 2 == 0 ? 0 : null,
                    right: index % 2 == 1 ? 0 : null,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border(
                          left: index % 2 == 0
                              ? BorderSide(
                                  color:
                                      const Color(0xFFF09EFF).withOpacity(0.6),
                                  width: 3)
                              : BorderSide.none,
                          top: index < 2
                              ? BorderSide(
                                  color:
                                      const Color(0xFFF09EFF).withOpacity(0.6),
                                  width: 3)
                              : BorderSide.none,
                          right: index % 2 == 1
                              ? BorderSide(
                                  color:
                                      const Color(0xFFF09EFF).withOpacity(0.6),
                                  width: 3)
                              : BorderSide.none,
                          bottom: index >= 2
                              ? BorderSide(
                                  color:
                                      const Color(0xFFF09EFF).withOpacity(0.6),
                                  width: 3)
                              : BorderSide.none,
                        ),
                      ),
                    ),
                  );
                }),

                // Scanning animation overlay
                if (_isCameraInitialized &&
                    !_hasScanned &&
                    _errorMessage.isEmpty)
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, _) {
                        return CustomPaint(
                          painter: ScanningBeamPainter(
                            progress: _pulseController.value,
                            color: const Color(0xFFF09EFF),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScanButton() {
    return InkWell(
      onTap: () {
        if (_errorMessage.isNotEmpty) {
          _retryScanner();
          return;
        }

        if (!_hasScanned && _scannerController != null && !_isLoading) {
          try {
            _scannerController!.toggleTorch();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Cosmic light toggled"),
                backgroundColor: Color(0xFFAB2AC2),
                duration: Duration(seconds: 1),
              ),
            );
          } catch (e) {
            // Handle flash error silently
            print("Error toggling torch: $e");
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              const Color(0xFFF09EFF).withOpacity(0.8),
              const Color(0xFFAB2AC2),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF09EFF).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _errorMessage.isNotEmpty
                  ? Icons.refresh
                  : (_hasScanned ? Icons.refresh : Icons.flashlight_on),
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              _errorMessage.isNotEmpty
                  ? 'Retry Scanner'
                  : (_hasScanned ? 'Scan Another' : 'Toggle Cosmic Light'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScanHistoryScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Space Mission History',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Star particle painter for space effect
class StarsPainter extends CustomPainter {
  final double animation;
  final random = List.generate(80, (index) => index * 3.14159 * 0.017 * index);

  StarsPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw small twinkling stars
    for (int i = 0; i < random.length; i++) {
      final x = (random[i] * 173.13) % size.width;
      final y = (random[i] * 321.37) % size.height;
      final pulseOffset = math.sin((animation * 6.28) + random[i]) * 0.5 + 0.5;

      // Star size varies based on index and animation
      final starSize = (i % 4 == 0)
          ? 2.0
          : (i % 3 == 0)
              ? 1.5
              : 1.0;
      final finalSize = starSize * (0.7 + (pulseOffset * 0.3));

      // Star color varies
      final color = i % 5 == 0
          ? Color.lerp(
              Colors.white, const Color(0xFFF09EFF), pulseOffset * 0.7)!
          : i % 4 == 0
              ? Color.lerp(
                  Colors.white, const Color(0xFF00B4FF), pulseOffset * 0.5)!
              : Colors.white.withOpacity(0.5 + (pulseOffset * 0.5));

      paint.color = color;

      // Draw the star
      canvas.drawCircle(Offset(x, y), finalSize, paint);
    }
  }

  @override
  bool shouldRepaint(StarsPainter oldDelegate) => true;
}

// Scanning beam animation
class ScanningBeamPainter extends CustomPainter {
  final double progress;
  final Color color;

  ScanningBeamPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Scan line
    final scanLineY = size.height * progress;
    final scanLinePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(0, scanLineY),
      Offset(size.width, scanLineY),
      scanLinePaint,
    );

    // Scan line glow
    final glowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(0.0),
          color.withOpacity(0.5),
          color.withOpacity(0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, scanLineY - 15, size.width, 30));

    canvas.drawRect(
      Rect.fromLTWH(0, scanLineY - 15, size.width, 30),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(ScanningBeamPainter oldDelegate) => true;
}
