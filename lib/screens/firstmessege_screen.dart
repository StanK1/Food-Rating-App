import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'survey_screen.dart';

class FirstMessege extends StatefulWidget {
  const FirstMessege({super.key});

  @override
  State<FirstMessege> createState() => _FirstMessegeState();
}

class _FirstMessegeState extends State<FirstMessege>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

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
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            width: screenSize.width,
            height: screenSize.height,
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
            width: screenSize.width,
            height: screenSize.height,
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

          // Main content
          SafeArea(
            child: Stack(
              children: [
                // Logo at top with cosmic glow
                Positioned(
                  left: (screenSize.width - 280) / 2,
                  top: 58,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final glowValue =
                          math.sin(_animationController.value * math.pi * 2) *
                                  0.5 +
                              0.5;

                      return ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFFF09EFF),
                            Colors.white,
                            Color(0xFFF09EFF),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ).createShader(bounds),
                        child: Container(
                          width: 280,
                          height: 46,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/logo/choconavttext.png'),
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
                        ),
                      );
                    },
                  ),
                ),

                // Cosmic decoration elements
                Positioned(
                  left: 20,
                  top: 120,
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

                Positioned(
                  right: 30,
                  top: 140,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: CosmicShapePainter(_animationController.value),
                        size: const Size(30, 30),
                      );
                    },
                  ),
                ),

                // Welcome Text
                Positioned(
                  left: 24,
                  top: 169,
                  child: SizedBox(
                    width: screenSize.width - 48,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hi, ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                            ),
                          ),
                          TextSpan(
                            text: 'CHOCONAVT',
                            style: TextStyle(
                              color: const Color(0xFFF09EFF),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                              letterSpacing: 1,
                              shadows: [
                                Shadow(
                                  color:
                                      const Color(0xFFF09EFF).withOpacity(0.5),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                          TextSpan(
                            text: '! \n\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                            ),
                          ),
                          TextSpan(
                            text:
                                'This is your Captain speaking. You are requested to explore the never-ending universe of chocolate! Before we begin your quest, you need to participate in a mini-task which will help with your conscription. ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Continue Button with animation
                Positioned(
                  left: 25,
                  right: 25,
                  top: 420,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final glowIntensity =
                          (math.sin(_animationController.value * math.pi) + 1) /
                              2;

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SurveyScreen()),
                          );
                        },
                        child: Container(
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
                              color: Colors.white
                                  .withOpacity(0.1 + (glowIntensity * 0.1)),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Continue',
                                  style: TextStyle(
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
                    },
                  ),
                ),

                // Skip Button with improved styling
                Positioned(
                  left: 25,
                  right: 25,
                  top: 492,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SurveyScreen()),
                      );
                    },
                    child: Container(
                      height: 48,
                      decoration: ShapeDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.5,
                            color: const Color(0xFFF09EFF).withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadows: [
                          BoxShadow(
                            color: const Color(0xFFF09EFF).withOpacity(0.1),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

// Orbit decorative element
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

// Cosmic shape decorative element
class CosmicShapePainter extends CustomPainter {
  final double animation;

  CosmicShapePainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw cosmic shape
    final path = Path();
    final numberOfPoints = 5;
    final radius = size.width * 0.4;
    final innerRadius = radius * 0.4;

    for (int i = 0; i < numberOfPoints * 2; i++) {
      final angle = (i * math.pi / numberOfPoints) + (animation * math.pi);
      final currentRadius = i.isEven ? radius : innerRadius;

      final x = centerX + math.cos(angle) * currentRadius;
      final y = centerY + math.sin(angle) * currentRadius;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    final paint = Paint()
      ..color = const Color(0xFFF09EFF).withOpacity(0.7)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Add glow effect
    final glowPaint = Paint()
      ..color = const Color(0xFFF09EFF).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawPath(path, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
