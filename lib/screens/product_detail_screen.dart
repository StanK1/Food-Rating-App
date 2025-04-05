import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Cosmic background gradient
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  Color(0xFF05032A),
                  Color(0xFF1B0945),
                  Color(0xFF353352)
                ],
              ),
            ),
          ),

          // Animated star field
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarFieldPainter(
                    animation: _animationController.value,
                  ),
                );
              },
            ),
          ),

          // Main content with custom scroll physics
          SafeArea(
            child: Column(
              children: [
                // App bar with cosmic styling
                _buildCosmicAppBar(),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero image with cosmic overlay
                        _buildHeroImage(),

                        // Product name and brand
                        _buildProductHeader(),

                        // Nutri-score section
                        _buildNutriScoreSection(),

                        // Divider with cosmic styling
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildCosmicDivider(),
                        ),

                        // Nutritional information section
                        _buildNutritionalInfoSection(),

                        // Ingredients section
                        _buildIngredientsSection(),

                        // Actions section
                        _buildActionsSection(),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCosmicAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          // Back button with cosmic styling
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF09EFF).withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Spacer(),
          // Bookmark button
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.bookmark_border, color: Colors.white),
              onPressed: () {
                // Bookmark functionality
              },
            ),
          ),
          const SizedBox(width: 8),
          // Share button
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {
                // Share functionality
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      children: [
        // Image container with cosmic overlay
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF09EFF).withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            child: Image.network(
              widget.product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.white54,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Cosmic overlay gradient
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFF05032A).withOpacity(0.8),
                ],
                stops: const [0.6, 1.0],
              ).createShader(bounds),
              blendMode: BlendMode.darken,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ),

        // Animated orbital decoration
        Positioned(
          bottom: 20,
          right: 20,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: OrbitPainter(_animationController.value),
                size: const Size(40, 40),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name with shimmer effect
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Colors.white,
                Color(0xFFF09EFF),
                Colors.white,
              ],
              stops: [0.0, 0.5, 1.0],
            ).createShader(bounds),
            child: Text(
              widget.product.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Brand with cosmic styling
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFF09EFF).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.business,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.product.brand,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Rating display
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFFB800).withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFB800),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.product.rating}/5',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutriScoreSection() {
    final scoreColors = _getNutriScoreColors(widget.product.nutriScore);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nutrition Quality',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.3),
                  const Color(0xFF353352).withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nutri-Score',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: scoreColors,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: scoreColors[0].withOpacity(0.5),
                            blurRadius: 8,
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
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.product.nutriScore,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Nutri-score scale
                _buildNutriScoreScale(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutriScoreScale() {
    final scores = ['A', 'B', 'C', 'D', 'E'];
    final currentScore = widget.product.nutriScore.toUpperCase();
    final currentIndex = scores.indexOf(currentScore);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        scores.length,
        (index) {
          final isActive = index == currentIndex;
          final scoreColor = _getNutriScoreColors(scores[index])[0];

          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final pulseValue = isActive
                  ? math.sin(_animationController.value * math.pi * 2) * 0.5 +
                      0.5
                  : 0.0;

              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scoreColor.withOpacity(isActive ? 0.8 : 0.3),
                  border: Border.all(
                    color: isActive ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: scoreColor
                                .withOpacity(0.3 + (pulseValue * 0.2)),
                            blurRadius: 10 + (pulseValue * 10),
                            spreadRadius: pulseValue * 2,
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    scores[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      fontSize: isActive ? 18 : 14,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCosmicDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            const Color(0xFFF09EFF).withOpacity(0.6),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildNutritionalInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nutritional Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.3),
                  const Color(0xFF353352).withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                _buildNutrientRow(
                  'Energy',
                  '${widget.product.nutriments['energy-kcal_100g']} kcal',
                  icon: Icons.bolt,
                  iconColor: const Color(0xFFFFB800),
                ),
                _buildNutrientRow(
                  'Fat',
                  '${widget.product.nutriments['fat_100g']} g',
                  icon: Icons.opacity,
                  iconColor: const Color(0xFFF09EFF),
                ),
                _buildNutrientRow(
                  'Sugars',
                  '${widget.product.nutriments['sugars_100g']} g',
                  icon: Icons.grain,
                  iconColor: Colors.white,
                ),
                // Add more nutrients as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsSection() {
    // Placeholder ingredients - in a real app, you'd get this from the product
    final ingredients = [
      'Cocoa mass',
      'Sugar',
      'Cocoa butter',
      'Emulsifier: soy lecithin',
      'Natural vanilla flavoring'
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ingredients',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.3),
                  const Color(0xFF353352).withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 8, right: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF09EFF),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFF09EFF).withOpacity(0.5),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ingredient,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientRow(String name, String value,
      {required IconData icon, required Color iconColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: iconColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                'Add Review',
                Icons.rate_review,
                onTap: () {
                  // Add review functionality
                },
              ),
              const SizedBox(width: 16),
              _buildActionButton(
                'View Similar',
                Icons.view_in_ar,
                isPrimary: false,
                onTap: () {
                  // View similar products functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon,
      {bool isPrimary = true, required VoidCallback onTap}) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final glowIntensity = isPrimary
            ? (math.sin(_animationController.value * math.pi) + 1) / 2
            : 0.0;

        return InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: isPrimary
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFF09EFF).withOpacity(0.8),
                        const Color(0xFFAB2AC2),
                      ],
                    )
                  : null,
              color: isPrimary ? null : Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isPrimary
                    ? Colors.white.withOpacity(0.2)
                    : const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: isPrimary
                  ? [
                      BoxShadow(
                        color: const Color(0xFFF09EFF)
                            .withOpacity(0.3 + (glowIntensity * 0.2)),
                        blurRadius: 12 + (glowIntensity * 8),
                        offset: const Offset(0, 4),
                        spreadRadius: glowIntensity * 2,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
}

class StarFieldPainter extends CustomPainter {
  final double animation;
  final random = List.generate(80, (index) => index * 3.14159 * 0.017 * index);

  StarFieldPainter({required this.animation});

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
  bool shouldRepaint(StarFieldPainter oldDelegate) => true;
}

class OrbitPainter extends CustomPainter {
  final double animation;

  OrbitPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width * 0.4;

    // Draw orbit
    final orbitPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(Offset(centerX, centerY), radius, orbitPaint);

    // Draw planet
    final planetAngle = animation * math.pi * 2;
    final planetX = centerX + math.cos(planetAngle) * radius;
    final planetY = centerY + math.sin(planetAngle) * radius;

    final planetPaint = Paint()
      ..color = const Color(0xFFF09EFF)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(planetX, planetY), 3, planetPaint);

    // Draw center star
    final starPaint = Paint()
      ..color = const Color(0xFFFFB800)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), 5, starPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
