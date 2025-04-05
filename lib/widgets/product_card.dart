import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
    if (hovering) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -4 * _hoverController.value),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black
                        .withOpacity(0.3 + (0.1 * _hoverController.value)),
                    const Color(0xFF353352)
                        .withOpacity(0.5 + (0.1 * _hoverController.value)),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color.lerp(
                    Colors.white.withOpacity(0.1),
                    const Color(0xFFF09EFF).withOpacity(0.5),
                    _hoverController.value,
                  )!,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF09EFF)
                        .withOpacity(0.1 + (0.2 * _hoverController.value)),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                    spreadRadius: _hoverController.value * 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product image with cosmic overlay
                      Stack(
                        children: [
                          // Image
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF09EFF).withOpacity(
                                      0.2 * _hoverController.value),
                                  blurRadius: 10,
                                  spreadRadius: _hoverController.value * 3,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                widget.product.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.black.withOpacity(0.2),
                                    child: const Center(
                                      child: Icon(Icons.image_not_supported,
                                          size: 50, color: Colors.white54),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          // Cosmic overlay
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    const Color(0xFF1B0945).withOpacity(0.7),
                                  ],
                                ).createShader(bounds),
                                blendMode: BlendMode.darken,
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),

                          // Cosmic stars overlay for hover effect
                          if (_hoverController.value > 0)
                            Positioned.fill(
                              child: Opacity(
                                opacity: _hoverController.value * 0.7,
                                child: CustomPaint(
                                  painter: StarOverlayPainter(),
                                ),
                              ),
                            ),

                          // Nutri-score badge
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: _getNutriScoreColors(
                                      widget.product.nutriScore),
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: _getNutriScoreColors(
                                            widget.product.nutriScore)[0]
                                        .withOpacity(0.5),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.eco_outlined,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.product.nutriScore,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Product info with glowing effect
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.white
                                  .withOpacity(0.3 * _hoverController.value),
                              blurRadius: 8 * _hoverController.value,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Brand: ${widget.product.brand}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Rating stars with animation
                      Row(
                        children: List.generate(5, (index) {
                          final isActive = index < widget.product.rating;

                          return Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: AnimatedBuilder(
                              animation: _hoverController,
                              builder: (context, child) {
                                final delay = index * 0.2;
                                final animValue = _hoverController.value > delay
                                    ? (_hoverController.value - delay) /
                                        (1 - delay)
                                    : 0.0;

                                return Transform.rotate(
                                  angle: isActive ? animValue * 0.5 : 0,
                                  child: Icon(
                                    isActive ? Icons.star : Icons.star_border,
                                    color: isActive
                                        ? Color.lerp(
                                            const Color(0xFFFFB800),
                                            const Color(0xFFF09EFF),
                                            animValue * 0.5,
                                          )
                                        : Colors.white.withOpacity(0.3),
                                    size: 20 + (isActive ? animValue * 4 : 0),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 12),

                      // Date and discover button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Scanned: ${_getFormattedDate()}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF09EFF).withOpacity(
                                  0.2 + (0.2 * _hoverController.value)),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFF09EFF).withOpacity(
                                    0.3 + (0.2 * _hoverController.value)),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Discover',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 12 + (_hoverController.value * 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Color> _getNutriScoreColors(String nutriScore) {
    switch (nutriScore.toUpperCase()) {
      case 'A':
        return [const Color(0xFF1FAF38), const Color(0xFF088F4C)];
      case 'B':
        return [const Color(0xFF85BB2F), const Color(0xFF599F0E)];
      case 'C':
        return [const Color(0xFFFECC00), const Color(0xFFDFB000)];
      case 'D':
        return [const Color(0xFFEF7D00), const Color(0xFFDF6000)];
      case 'E':
        return [const Color(0xFFE63E11), const Color(0xFFCC0000)];
      default:
        return [Colors.grey, Colors.grey.shade700];
    }
  }

  String _getFormattedDate() {
    // Placeholder for date formatting
    return '2 days ago';
  }
}

class StarOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42); // Fixed seed for consistent pattern
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final starSize = random.nextDouble() * 1.5 + 0.5;

      paint.color = i % 3 == 0
          ? const Color(0xFFF09EFF).withOpacity(random.nextDouble() * 0.7 + 0.3)
          : Colors.white.withOpacity(random.nextDouble() * 0.7 + 0.3);

      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
