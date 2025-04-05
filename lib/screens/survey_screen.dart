import 'package:flutter/material.dart';
import 'dart:math' as math;
//import 'scan_screen.dart';
import 'scan_instruction_screen.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen>
    with SingleTickerProviderStateMixin {
  final Set<String> _selectedFlavors = {};
  late AnimationController _animationController;

  final List<String> flavors = [
    'Milk Chocolate',
    'Dark Chocolate',
    'White Chocolate',
    'Vegan Chocolate',
    'Caramel',
    'Nuts',
    'Fruit',
    'Mint',
    'Coffee',
    'Coconut',
    'Vanilla',
  ];

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
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
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: StarFieldPainter(
                  animation: _animationController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                // Logo and Title Section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Animated logo
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          final glowValue = math.sin(
                                      _animationController.value *
                                          math.pi *
                                          2) *
                                  0.5 +
                              0.5;
                          return Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/logo/astro.png'),
                                fit: BoxFit.contain,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF09EFF)
                                      .withOpacity(0.2 + (glowValue * 0.3)),
                                  blurRadius: 20 + (glowValue * 15),
                                  spreadRadius: 5 * glowValue,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      // Cosmic title with gradient effect
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFFF09EFF),
                            Colors.white,
                            Color(0xFFF09EFF),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ).createShader(bounds),
                        child: const Text(
                          'Discover Your\nChocolate Universe',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Select your favorite flavors to start\nyour chocolate journey through the stars',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Flavors List with cosmic animations
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: flavors.length,
                    itemBuilder: (context, index) {
                      final flavor = flavors[index];
                      final isSelected = _selectedFlavors.contains(flavor);

                      // Calculate item-specific animation offset
                      final itemOffset = index * 0.1;

                      return AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          final animValue = _animationController.value;
                          final pulseValue =
                              math.sin((animValue + itemOffset) * math.pi * 2) *
                                  0.03;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(bottom: 16),
                            transform: Matrix4.identity()
                              ..translate(0.0, isSelected ? pulseValue * 10 : 0)
                              ..scale(1.0 + (isSelected ? pulseValue : 0)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedFlavors.remove(flavor);
                                    } else {
                                      _selectedFlavors.add(flavor);
                                    }
                                  });
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                        ? LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              const Color(0xFFAB2AC2),
                                              const Color(0xFFF09EFF),
                                            ],
                                          )
                                        : LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.black.withOpacity(0.3),
                                              Colors.black.withOpacity(0.1),
                                            ],
                                          ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.white.withOpacity(0.3)
                                          : Colors.white.withOpacity(0.1),
                                      width: 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFFF09EFF)
                                                  .withOpacity(
                                                      0.3 + pulseValue),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.white.withOpacity(0.2)
                                              : Colors.black.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isSelected
                                                ? const Color(0xFFF09EFF)
                                                    .withOpacity(0.5)
                                                : Colors.white.withOpacity(0.1),
                                            width: 1,
                                          ),
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFFF09EFF)
                                                            .withOpacity(0.3),
                                                    blurRadius: 6,
                                                    spreadRadius: 1,
                                                  )
                                                ]
                                              : null,
                                        ),
                                        child: Icon(
                                          _getFlavorIcon(flavor),
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.7),
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              flavor,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (isSelected)
                                              Text(
                                                'Tap to deselect',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontSize: 12,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFFF09EFF)
                                                    .withOpacity(0.5),
                                                blurRadius: 6,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Color(0xFFAB2AC2),
                                            size: 20,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // Continue Button with animation
                if (_selectedFlavors.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        final glowIntensity =
                            (math.sin(_animationController.value * math.pi) +
                                    1) /
                                2;
                        return _buildContinueButton(glowIntensity);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFlavorIcon(String flavor) {
    switch (flavor.toLowerCase()) {
      case 'milk chocolate':
        return Icons.local_cafe_outlined;
      case 'dark chocolate':
        return Icons.circle;
      case 'white chocolate':
        return Icons.circle_outlined;
      case 'vegan chocolate':
        return Icons.eco_outlined;
      case 'caramel':
        return Icons.water_drop_outlined;
      case 'nuts':
        return Icons.egg_outlined;
      case 'fruit':
        return Icons.apple;
      case 'mint':
        return Icons.spa_outlined;
      case 'coffee':
        return Icons.coffee_outlined;
      case 'coconut':
        return Icons.beach_access_outlined;
      case 'vanilla':
        return Icons.grass;
      default:
        return Icons.cookie_outlined;
    }
  }

  Widget _buildContinueButton(double glowIntensity) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ScanInstructionScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        height: 48,
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
              color: const Color(0xFFF09EFF)
                  .withOpacity(0.3 + (glowIntensity * 0.2)),
              blurRadius: 12 + (glowIntensity * 8),
              offset: const Offset(0, 4),
              spreadRadius: glowIntensity * 2,
            ),
            BoxShadow(
              color: const Color(0xFFAB2AC2).withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: -5,
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.1 + (glowIntensity * 0.1)),
            width: 1,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue (${_selectedFlavors.length})',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
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
